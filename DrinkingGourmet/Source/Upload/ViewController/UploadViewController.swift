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
import PhotosUI

class UploadViewController: UIViewController {
    
    var imageList: [NSItemProvider] = []
    
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
        layout.itemSize = CGSize(width: 115, height: 115)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configHierarchy()
        configLayout()
        configView()
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
            $0.top.equalTo(cameraBtn.snp.top).offset(-15)
            $0.leading.equalTo(cameraBtn.snp.trailing).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(115)
        }
        
    }
    
    func configView() {
        cameraBtn.addTarget(self, action: #selector(uploadBtnClicked), for: .touchUpInside)
    }
}

extension UploadViewController {
    @objc func uploadBtnClicked() {
        print(imageList)
        if imageList.count < 10 {
            var config = PHPickerConfiguration()
            config.filter = .images // 라이브러리에서 보여줄 Assets을 필터를 한다. (기본값: 이미지, 비디오, 라이브포토)
            config.selectionLimit = 5   // 한 번에 최대 5장 까지만 설정
                    
            let imagePicker = PHPickerViewController(configuration: config)
            imagePicker.delegate = self
                
            self.present(imagePicker, animated: true)
        } else {
            let alert = UIAlertController(title: "이미지는 최대 10장까지만 업로드 가능합니다.", message: "이미 10장의 이미지를 업로드 하셨습니다.", preferredStyle: .alert)
            
            let btn1 = UIAlertAction(title: "취소", style: .cancel)
            let btn2 = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(btn1)
            alert.addAction(btn2)
            
            present(alert, animated: true)
        }
    }
    
    private func displayImages() {
        guard !imageList.isEmpty else { return }

        let group = DispatchGroup()

        // 각 itemProvider에서 UIImage를 로드하고 처리
        for itemProvider in imageList {
            group.enter()

            // 로드 핸들러를 통해 UIImage를 처리
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let self = self, let image = image as? UIImage else {
                    group.leave()
                    return
                }

                DispatchQueue.main.async {
                    self.imageList.append(NSItemProvider(object: image))
                    group.leave()
                }
            }
        }

        group.notify(queue: DispatchQueue.main) {
            self.collectionView.reloadData()
        }
    }
}

extension UploadViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        imageList.append(contentsOf: results.map(\.itemProvider))

        collectionView.reloadData()
        
        picker.dismiss(animated: true)
    }
}

extension UploadViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedImgCollectionViewCell", for: indexPath) as! UploadedImgCollectionViewCell
        
        let itemProvider = imageList[indexPath.item]
            
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage else { return }
                
                DispatchQueue.main.async {
                    cell.uploadedImageView.image = image
                    cell.uploadedImageView.layer.cornerRadius = 8
                    cell.uploadedImageView.layer.masksToBounds = true
                }
            }
        }
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteImg), for: .touchUpInside)
        
        return cell
    }
    
    @objc func deleteImg(sender: UIButton) {
        let index = sender.tag
        
        imageList.remove(at: index)
        collectionView.reloadData()
    }
    
}
