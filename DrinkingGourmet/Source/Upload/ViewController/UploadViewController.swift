//
//  UploadViewController.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/2/24.
//

import UIKit
import SnapKit
import Then
import Photos

class UploadViewController: UIViewController {
    
    var imageList: [UIImage] = []
    
    let imagePickerController = UIImagePickerController()
    
    private let cameraBtn = UIButton().then {
        let resizedImg = UIImage(systemName: "camera.fill")?.resizedImage(to: CGSize(width: 30, height: 20))
        var configuration = UIButton.Configuration.plain()
        configuration.baseBackgroundColor = .clear

        var titleAttr = AttributedString.init("사진갯수")
        titleAttr.foregroundColor = .lightGray
        titleAttr.font = UIFont.systemFont(ofSize: 12)
        configuration.attributedTitle = titleAttr
        
        configuration.image = resizedImg?.withTintColor(.lightGray)
        configuration.imagePlacement = .top
        configuration.imagePadding = 12

        $0.configuration = configuration

        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        
        $0.addTarget(self, action: #selector(uploadBtnClicked), for: .touchUpInside)
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(UploadedImgCollectionViewCell.self, forCellWithReuseIdentifier: "UploadedImgCollectionViewCell")
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    @objc func uploadBtnClicked() {
        imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
//        imageList.append("")
//        collectionView.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        PHPhotoLibrary.requestAuthorization { (state) in
            print(state)
        }
        
        configHierarchy()
        configLayout()
        
        accessPhoto()
        imagePickerController.delegate = self
    }
    
    func configHierarchy() {
        view.addSubviews([
            cameraBtn,
            collectionView
        ])
    }
    
    func configLayout() {
        cameraBtn.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.width.height.equalTo(100)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(cameraBtn.snp.top)
            $0.leading.equalTo(cameraBtn.snp.trailing).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
    }

}


extension UploadViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedImgCollectionViewCell", for: indexPath) as! UploadedImgCollectionViewCell
        
        cell.uploadedImageView.image = imageList[indexPath.item]
        cell.uploadedImageView.layer.cornerRadius = 8
        cell.uploadedImageView.layer.masksToBounds = true
        
        return cell
    }
}


extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageList.append(image)
        }
        
        collectionView.reloadData()
        
        print(imageList)
        print(#function)
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension UploadViewController {
    func accessPhoto() {
        if #available(iOS 14, *) {
                    switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
                    case .limited:
                        fetchPhotos()
                    case .authorized:
                        fetchPhotos()
                    case .notDetermined:
                        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
                            if status == .limited {
                                self?.fetchPhotos()
                            }
                            else if status == .authorized {
                                self?.fetchPhotos()
                            }
                            else {
                                self?.showPermissionAlert()
                            }
                        }
                    case .restricted, .denied:
                        showPermissionAlert()
                    default:
                        break
                    }
                }
                else {
                    switch PHPhotoLibrary.authorizationStatus() {
                    case .authorized:
                        fetchPhotos()
                    case .notDetermined:
                        PHPhotoLibrary.requestAuthorization({ [weak self] status in
                            if status == .authorized {
                                self?.fetchPhotos()
                            }
                            else {
                                self?.showPermissionAlert()
                            }
                        })
                    case .restricted, .denied:
                        showPermissionAlert()
                    default:
                        break
                    }
                }
    }
    
    private func showPermissionAlert() {
            // PHPhotoLibrary.requestAuthorization() 결과 콜백이 main thread로부터 호출되지 않기 때문에
            // UI처리를 위해 main thread내에서 팝업을 띄우도록 함.
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: "사진 접근 권한이 없습니다. 설정으로 이동하여 권한 설정을 해주세요.", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
                alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))

                self.present(alert, animated: true)
            }
        }

        private func fetchPhotos() {
            // 사진 목록 조회
        }
}
