//
//  CombinationUploadVC.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/16/24.
//

import UIKit
import Photos
import PhotosUI

final class CombinationUploadVC: UIViewController {
    
    // MARK: - UI
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
//        $0.keyboardDismissMode = .onDrag // 스크롤 시 키보드 숨김
    }
    
    private let scrollViewContentView = UIView()
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 56
    }
    
    private let pickerView = UIPickerView()
    
    // 선택한 조합
    private let selectCombinationView = UIView()
    
    private let selectCombinationLabel = UILabel().then {
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "선택한 조합", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let selectCombinationTextField = UITextField().then {
        $0.placeholder = "조합을 선택해주세요."
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.tintColor = .clear
    }
    
    private let selectCombinationRoundView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.customColor.checkMarkGray.cgColor
    }
    
    private let selectCombinationArrowIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_upload_more_false")
    }
    
    // 해시태그
    private let hashtagView = UIView()
    
    private let hashtagLabel = UILabel().then {
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "해시태그", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let hashtagTextField = UITextField().then {
        $0.placeholder = "#태그입력"
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    private let hashtagLine = UIView().then {
        $0.backgroundColor = .base0700
    }
    
    // 사진
    private let imageView = UIView()
    
    private let imageLabel = UILabel().then {
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "사진", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let imageUploadButton = UIButton().then {
        let resizedImg = UIImage(systemName: "camera.fill")?.resizedImage(to: CGSize(width: 30, height: 20))
        var configuration = UIButton.Configuration.plain()
        configuration.baseBackgroundColor = .clear

        var titleAttr = AttributedString.init("0/10")
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
    
    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout()).then {
        $0.backgroundColor = .clear
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
    
    // 제목
    private let titleView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "제목", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let titleTextField = UITextField().then {
        $0.placeholder = "쉽게 만드는 토스트"
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    private let titleLine = UIView().then {
        $0.backgroundColor = .base0700
    }
    
    // 내용
    private let contentView = UIView()
    
    private let contentLabel = UILabel().then {
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "내용", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let contentTextField = UITextField().then {
        $0.placeholder = "내용을 입력해주세요."
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    private let contentLine = UIView().then {
        $0.backgroundColor = .base0700
    }
    
    // 작성완료 버튼
    private let completeButton = UIButton().then {
        $0.backgroundColor = .base0500
        $0.isEnabled = false
    }
    
    private let completeLabel = UILabel().then {
        $0.text = "작성 완료"
        $0.textColor = .base1000
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    // MARK: - Properties
    var isModify = false // 수정 여부
    var combinationDetailData: CombinationDetailResponseDTO? // 수정일 때 이전 값
    
    var imageList: [UIImage] = [] // 사진 담는 배열
    var arrayRecommendList: [CombinationUploadModel.FetchRecommendListModel.RecommendResponseDTOList] = [] // 추천 받은 조합
    var recommendId: Int? // 추천 받은 조합 Id
    
    // MARK: - ViewDidLodad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if self.isModify { // 수정일 때
            guard let beforeData = self.combinationDetailData else { return }
            
            DispatchQueue.main.async {
                self.completeLabel.text = "수정하기"
                self.recommendId = beforeData.result.combinationResult.recommendId
                self.selectCombinationTextField.text = beforeData.result.combinationResult.recommend
                self.hashtagTextField.text = beforeData.result.combinationResult.hashTagList.joined(separator: " ")
                self.titleTextField.text = beforeData.result.combinationResult.title
                self.contentTextField.text = beforeData.result.combinationResult.content
                
                for imageURL in beforeData.result.combinationResult.combinationImageList {
                    if let url = URL(string: imageURL) {
                        // Kingfisher를 사용해 이미지를 비동기적으로 로드하고 캐시
                        let imageView = UIImageView()
                        imageView.kf.setImage(with: url) { result in
                            switch result {
                            case .success(let value):
                                DispatchQueue.main.async {
                                    self.imageList.append(value.image)
                                    self.imageCollectionView.reloadData()
                                    self.updateImageCountLabel()
                                    self.updateCompleteButton()
                                }
                            case .failure(let error):
                                print("Error: \(error)")
                            }
                        }
                    }
                }
            }
        }
        
        checkPermission()
        
        addViews()
        configureConstraints()
        
        createPickerView()
        
        fetchData()
        setupNaviBar()
        setupTextField()
        setupButton()
        setupCollectionView()
        
        // 키보드 알림 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    deinit {
        // 알림 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        return toolbar
    }
    
    @objc private func doneButtonTapped() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
            
            if selectedRow == 0 {
                // 선택된 항목이 없으면 첫 번째 항목을 선택
                pickerView.selectRow(0, inComponent: 0, animated: true)
                pickerView(pickerView, didSelectRow: 0, inComponent: 0)
            } else {
                // 사용자가 이미 선택한 항목이 있으면 그대로 사용
                pickerView(pickerView, didSelectRow: selectedRow, inComponent: 0)
            }
        
        view.endEditing(true)
    }
    
    // 피커뷰
    private func createPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // 텍스트 필드의 입력 방식을 피커 뷰로 설정
        selectCombinationTextField.inputView = pickerView
        
        // 피커 뷰 위에 툴바 추가
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        selectCombinationTextField.inputAccessoryView = toolbar
    }
    
    private func fetchData() {
        let input = CombinationUploadInput.FetchRecommendListDataInput(page: 0, size: 20)
        
        CombinationUploadService.shared.fetchRecommendListData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.arrayRecommendList = model.result.recommendResponseDTOList
            }
        }
    }
    
    private func setupNaviBar() {
        title = "글쓰기"
    }
    
    private func setupTextField() {
        
        [self.selectCombinationTextField,
         self.hashtagTextField,
         self.titleTextField,
         self.contentTextField].forEach { $0.delegate = self }
    }
    
    private func setupButton() {
        self.imageUploadButton.addTarget(self, action: #selector(imageUploadButtonTapped), for: .touchUpInside)
        
        self.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.register(UploadedImgCollectionViewCell.self, forCellWithReuseIdentifier: "UploadedImgCollectionViewCell")
    }
    
    private func updateImageCountLabel() {
        var configuration = imageUploadButton.configuration
        var titleAttr = AttributedString("\(imageList.count)/10")
        titleAttr.foregroundColor = .lightGray
        titleAttr.font = UIFont.systemFont(ofSize: 12)
        configuration?.attributedTitle = titleAttr
        imageUploadButton.configuration = configuration
    }
    
    // 작성완료 버튼 상태 변경
    private func updateCompleteButton() {
        let textFields: [UITextField] = [
            self.selectCombinationTextField,
            self.hashtagTextField,
            self.titleTextField,
            self.contentTextField
        ]
        
        // 모든 텍스트 필드가 채워져 있는지 확인
        let allFieldsFilled = textFields.allSatisfy { !$0.text!.isEmpty }
        
        // 이미지 리스트에 최소 하나 이상의 이미지가 있는지 확인
        let hasImages = !imageList.isEmpty
        
        // 검사 후 상태 변경
        if allFieldsFilled && hasImages{
            self.completeButton.backgroundColor = .base0100
            self.completeButton.isEnabled = true
        } else {
            self.completeButton.backgroundColor = .base0500
            self.completeButton.isEnabled = false
        }
    }
}

// MARK: - Actions
extension CombinationUploadVC {
    // 이미지 업로드 버튼
    @objc private func imageUploadButtonTapped() {
        let availableSlots = 10 - imageList.count
        
        if availableSlots > 0 {
            var config = PHPickerConfiguration()
            config.filter = .images // 이미지만 보이게
            config.selectionLimit = availableSlots // 사진 갯수 제한
                    
            let imagePicker = PHPickerViewController(configuration: config)
            imagePicker.delegate = self
            imagePicker.modalPresentationStyle = .fullScreen
                    
            self.present(imagePicker, animated: true)
        } else {
            let alert = UIAlertController(title: nil, message: "이미지는 최대 10장까지만 업로드 가능합니다.", preferredStyle: .alert)
            
            let btn1 = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(btn1)
            
            self.present(alert, animated: true)
        }
    }
    
    // 작성완료 버튼
    @objc private func completeButtonTapped() {
        
        self.completeButton.isEnabled = false // 두번 클릭 막기
        
        CombinationUploadService.shared.uploadImages(self.imageList) { response, error in
            if let error = error {
                print("오늘의 조합 이미지 업로드 실패 - \(error.localizedDescription)")
            } else if let response = response {
                guard let combinationImageList = response.result?.combinationImageList else { return }
                
                // 해시태그 문자열을 배열로 변환
                let hashtagText = self.hashtagTextField.text ?? ""
                let hashtags = self.extractHashtags(from: hashtagText)
                
                let postModel = CombinationUploadModel.WritingPostModel(
                    title: self.titleTextField.text!,
                    content: self.contentTextField.text!,
                    recommendId: self.recommendId!,
                    hashTagNameList: hashtags,
                    combinationImageList: combinationImageList
                )
                
                if self.isModify { // 수정일 때
                    guard let recipeBookId = self.combinationDetailData?.result.combinationResult.combinationId else { return }
                    
                    CombinationService.shared.patchCombination(combinationId: recipeBookId, fetchModel: postModel) { error in
                        if let error = error {
                            print("오늘의 조합 수정 실패 - \(error.localizedDescription)")
                        } else {
                            print("오늘의 조합 수정 성공")
                            if let vc = self.navigationController?.viewControllers.first(where: { $0 is CombinationDetailViewController }) as? CombinationDetailViewController {
                                vc.fetchData()
                                self.navigationController?.popToViewController(vc, animated: true)
                            }
                        }
                    }
                } else { // 일반 작성
                    CombinationUploadService.shared.uploadPost(postModel) { response, error in
                        if let error = error {
                            print("오늘의 조합 게시글 업로드 실패 - \(error.localizedDescription)")
                        } else if let response = response {
                            print("오늘의 조합 게시글 업로드 성공")
                            DispatchQueue.main.async {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func extractHashtags(from text: String) -> [String] {
        let components = text.split(separator: " ").map { $0.trimmingCharacters(in: .whitespaces) }
        return components.filter { $0.hasPrefix("#") }
    }
}

// MARK: - Setting
extension CombinationUploadVC {
    private func checkPermission() {
        if #available(iOS 14, *) {
            switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
            case .notDetermined:
                print("not determined")
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    switch status {
                    case .authorized, .limited:
                        print("권한이 부여 됐습니다. 앨범 사용이 가능합니다")
                    case .denied:
                        DispatchQueue.main.async {
                            self.moveToSetting()
                        }
                        print("권한이 거부 됐습니다. 앨범 사용 불가합니다.")
                    default:
                        print("그 밖의 권한이 부여 되었습니다.")
                    }
                }
            case .restricted:
                print("restricted")
            case .denied:
                DispatchQueue.main.async {
                    self.moveToSetting()
                }
                print("denined")
            case .authorized:
                print("autorized")
            case .limited:
                print("limited")
            @unknown default:
                print("unKnown")
            }
        } else {
            switch PHPhotoLibrary.authorizationStatus() {
            case .notDetermined:
                print("not determined")
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    switch status {
                    case .authorized, .limited:
                        print("권한이 부여 됐습니다. 앨범 사용이 가능합니다")
                    case .denied:
                        DispatchQueue.main.async {
                            self.moveToSetting()
                        }
                        print("권한이 거부 됐습니다. 앨범 사용 불가합니다.")
                    default:
                        print("그 밖의 권한이 부여 되었습니다.")
                    }
                }
            case .restricted:
                print("restricted")
            case .denied:
                DispatchQueue.main.async {
                    self.moveToSetting()
                }
                print("denined")
            case .authorized:
                print("autorized")
            case .limited:
                print("limited")
            @unknown default:
                print("unKnown")
            }
            
        }
    }
    
    private func moveToSetting() {
        let alertController = UIAlertController(title: "권한 거부됨", message: "앨범 접근이 거부 되었습니다. 앱의 일부 기능을 사용할 수 없어요", preferredStyle: UIAlertController.Style.alert)
            
        let okAction = UIAlertAction(title: "권한 설정으로 이동하기", style: .default) { (action) in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
            
        self.present(alertController, animated: false, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension CombinationUploadVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedImgCollectionViewCell", for: indexPath) as! UploadedImgCollectionViewCell
        
        let image = imageList[indexPath.item]
        cell.uploadedImageView.image = image
        cell.uploadedImageView.layer.cornerRadius = 8
        cell.uploadedImageView.layer.masksToBounds = true

        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteImg), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func deleteImg(sender: UIButton) {
        let index = sender.tag
        
        imageList.remove(at: index)
        imageCollectionView.reloadData()
        self.updateImageCountLabel()
        self.updateCompleteButton()
    }
}

// MARK: - UITextFieldDelegate
extension CombinationUploadVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case selectCombinationTextField:
            selectCombinationRoundView.layer.borderColor = UIColor.customOrange.cgColor
        case hashtagTextField:
            hashtagLine.backgroundColor = .customOrange
        case titleTextField:
            titleLine.backgroundColor = .customOrange
        case contentTextField:
            contentLine.backgroundColor = .customOrange
        default:
            break
        }
        
        if textField == hashtagTextField, textField.text?.isEmpty ?? true {
            textField.text = "#"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == hashtagTextField {
            // 띄어쓰기가 입력될 때 # 추가
            if string == " ", let text = textField.text {
                textField.text = text + " #"
                return false
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        selectCombinationRoundView.layer.borderColor = UIColor.base0700.cgColor
        hashtagLine.backgroundColor = .base0700
        titleLine.backgroundColor = .base0700
        contentLine.backgroundColor = .base0700
        
        self.updateCompleteButton() // 텍스트필드 입력이 끝날때 마다 작성완료 버튼 업데이트
    }
}

// MARK: - PHPickerViewControllerDelegate
extension CombinationUploadVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let image = image as? UIImage else {
                    return
                }

                DispatchQueue.main.async {
                    self?.imageList.append(image)
                    self?.imageCollectionView.reloadData()
                    self?.updateImageCountLabel()
                    self?.updateCompleteButton()
                    
                    print(self?.imageList ?? "No data available")
                }
            }
        }
        picker.dismiss(animated: true)
    }
}

// MARK: - 피커뷰
extension CombinationUploadVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayRecommendList.count
    }
}

extension CombinationUploadVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(arrayRecommendList[row].foodName) & \(arrayRecommendList[row].drinkName)"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectCombinationTextField.text = "\(arrayRecommendList[row].foodName) & \(arrayRecommendList[row].drinkName)"
        recommendId = arrayRecommendList[row].recommendID
        print("recommendId: \(String(describing: recommendId))")
    }
}

// MARK: - UI
extension CombinationUploadVC {
    
    private func addViews() {
        view.addSubviews([
            scrollView,
            completeButton
        ])
        
        scrollView.addSubview(scrollViewContentView)
        
        scrollViewContentView.addSubview(stackView)
        
        stackView.addArrangedSubviews([
            selectCombinationView,
            hashtagView,
            imageView,
            titleView,
            contentView
        ])
        
        selectCombinationView.addSubviews([selectCombinationLabel, selectCombinationRoundView])
        selectCombinationRoundView.addSubviews([selectCombinationTextField, selectCombinationArrowIcon])
        hashtagView.addSubviews([hashtagLabel, hashtagTextField, hashtagLine])
        imageView.addSubviews([imageLabel, imageUploadButton, imageCollectionView])
        titleView.addSubviews([titleLabel, titleTextField, titleLine])
        contentView.addSubviews([contentLabel, contentTextField, contentLine])
        
        
        completeButton.addSubview(completeLabel)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(completeButton.snp.top)
        }
        
        scrollViewContentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.edges.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollViewContentView).inset(20)
        }
        
        [titleView, hashtagView, contentView].forEach {
            $0.snp.makeConstraints { make in
                make.leading.trailing.equalTo(stackView)
                make.height.equalTo(72)
            }
        }
        
        // 선택한 조합
        selectCombinationView.snp.makeConstraints { make in
            make.height.equalTo(81)
        }
        
        selectCombinationLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(selectCombinationView)
        }
        
        selectCombinationRoundView.snp.makeConstraints { make in
            make.height.equalTo(49)
            make.top.equalTo(selectCombinationLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(stackView)
        }
        
        selectCombinationTextField.snp.makeConstraints { make in
            make.leading.equalTo(selectCombinationRoundView).offset(16)
            make.trailing.equalTo(selectCombinationRoundView)
            make.centerY.equalTo(selectCombinationRoundView)
        }
        
        selectCombinationArrowIcon.snp.makeConstraints { make in
            make.trailing.equalTo(selectCombinationRoundView).inset(16)
            make.centerY.equalTo(selectCombinationRoundView)
        }
        
        // 해시태그
        hashtagLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(hashtagView)
        }
        
        hashtagTextField.snp.makeConstraints { make in
            make.top.equalTo(hashtagLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(hashtagView)
        }
        
        hashtagLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(hashtagView)
            make.height.equalTo(1)
        }
        
        // 이미지
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView)
            make.height.equalTo(136)
        }
        
        imageLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(imageView)
        }
        
        imageUploadButton.snp.makeConstraints { make in
            make.top.equalTo(imageLabel.snp.bottom).offset(12)
            make.leading.equalTo(imageView)
            make.size.equalTo(100)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(imageUploadButton.snp.top).offset(-15)
            make.leading.equalTo(imageUploadButton.snp.trailing).offset(16)
            make.trailing.equalTo(stackView)
            make.height.equalTo(115)
        }
        
        // 제목
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(titleView)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(titleView)
        }
        
        titleLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(titleView)
            make.height.equalTo(1)
        }
        
        // 내용
        contentLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView)
        }
        
        contentLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(contentView)
            make.height.equalTo(1)
        }
        
        // 작성완료 버튼
        completeButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(89)
        }
        
        completeLabel.snp.makeConstraints { make in
            make.top.equalTo(completeButton).offset(18)
            make.centerX.equalTo(completeButton)
        }
    }
}
