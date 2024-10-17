//
//  RecipeBookUploadViewController.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/20/24.
//

import UIKit
import Photos
import PhotosUI

final class RecipeBookUploadViewController: UIViewController {
    
    // MARK: - UI
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
//        $0.keyboardDismissMode = .onDrag // 스크롤 시 키보드 숨김
    }
    
    private let contentView = UIView()
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 56
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
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    private let titleLine = UIView().then {
        $0.backgroundColor = .base0700
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
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
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
    
    // 소요시간
    private let cookingTimeView = UIView()
    
    private let cookingTimeLabel = UILabel().then {
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "소요시간", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let cookingTimeTextField = UITextField().then {
        $0.placeholder = "소요시간을 분 단위로 입력해주세요."
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.keyboardType = .numberPad
    }
    
    private let cookingTimeLine = UIView().then {
        $0.backgroundColor = .base0700
    }
    
    // 칼로리
    private let calorieView = UIView()
    
    private let calorieLabel = UILabel().then {
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "칼로리", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let calorieTextField = UITextField().then {
        $0.placeholder = "칼로리를 입력해주세요."
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.keyboardType = .numberPad
    }
    
    private let calorieLine = UIView().then {
        $0.backgroundColor = .base0700
    }
    
    // 재료
    private let ingredientView = UIView()
    
    private let ingredientLabel = UILabel().then {
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "재료", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let ingredientTextField = UITextField().then {
        $0.placeholder = "재료를 입력해주세요."
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    private let ingredientLine = UIView().then {
        $0.backgroundColor = .base0700
    }
    
    // 조리 방법
    private let cookingMethodLabel = UILabel().then {
        $0.text = "조리 방법"
        $0.textColor = .base0100
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "조리 방법", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let cookingMethodTextView = UITextView().then {
        $0.text = "조리방법을 입력해주세요."
        $0.textColor = .placeholderText
        $0.textContainer.lineFragmentPadding = 0
//        $0.textContainerInset = .zero
        $0.isScrollEnabled = false
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    private let cookingMethodLine = UIView().then {
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
    var recipeBookDetailData: RecipeBookDetailResponseDTO? // 수정일 때 이전 값
    
    var imageList: [UIImage] = [] // 사진 담는 배열
    
    // MARK: - LifeCycle
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupKeyboardNotifications() // 키보드
        
        if self.isModify { // 수정일 때
            setBeforeData()
        }
        
        checkPermission()
        
        addViews()
        configureConstraints()
        
        setupNaviBar()
        setupTextField()
        setupTextView()
        setupButton()
        setupCollectionView()
    }
    
    // 키보드
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        guard let userInfo = noti.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        var contentInset = scrollView.contentInset
        contentInset.bottom = keyboardHeight
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(noti: Notification) {
        var contentInset = scrollView.contentInset
        contentInset.bottom = 0
        scrollView.contentInset = contentInset
    }
    
    // 키보드 툴바 생성
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        return toolbar
    }
    
    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }
    
    private func setupNaviBar() {
        title = "글쓰기"
    }
    
    private func setupTextField() {
        cookingTimeTextField.inputAccessoryView = createToolbar()
        calorieTextField.inputAccessoryView = createToolbar()
        
        [self.titleTextField,
         self.hashtagTextField,
         self.cookingTimeTextField,
         self.calorieTextField,
         self.ingredientTextField].forEach { $0.delegate = self }
    }
    
    private func setupTextView() {
        cookingMethodTextView.inputAccessoryView = createToolbar()
        self.cookingMethodTextView.delegate = self
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
            self.titleTextField,
            self.hashtagTextField,
            self.cookingTimeTextField,
            self.calorieTextField,
            self.ingredientTextField
        ]
        
        // 모든 텍스트 필드가 채워져 있는지 확인
        let allFieldsFilled = textFields.allSatisfy { !$0.text!.isEmpty } && !self.cookingMethodTextView.text!.isEmpty
        
        // 이미지 리스트에 최소 하나 이상의 이미지가 있는지 확인
        let hasImages = !imageList.isEmpty
        
        // 검사 후 상태 변경
        if allFieldsFilled && hasImages && self.cookingMethodTextView.text! != "조리방법을 입력해주세요." {
            self.completeButton.backgroundColor = .base0100
            self.completeButton.isEnabled = true
        } else {
            self.completeButton.backgroundColor = .base0500
            self.completeButton.isEnabled = false
        }
    }
    
    // 수정일 때 이전 데이터 세팅
    private func setBeforeData() {
        guard let beforeData = self.recipeBookDetailData else { return }
        
        DispatchQueue.main.async {
            self.completeLabel.text = "수정하기"
            self.hashtagTextField.text = beforeData.result.hashTagNameList.joined(separator: " ")
            self.titleTextField.text = beforeData.result.title
            self.cookingTimeTextField.text = beforeData.result.cookingTime
            self.calorieTextField.text = beforeData.result.calorie
            self.ingredientTextField.text = beforeData.result.ingredient
            self.cookingMethodTextView.text = beforeData.result.recipeInstruction
            self.cookingMethodTextView.textColor = .base0100
            
            for imageURL in beforeData.result.recipeImageList {
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
}

// MARK: - Actions
extension RecipeBookUploadViewController {
    // 이미지 업로드 버튼
    @objc private func imageUploadButtonTapped() {
        let availableSlots = 10 - imageList.count
        
        if availableSlots > 0 {
            var config = PHPickerConfiguration()
            config.filter = .images // 이미지만 보이게
            config.selectionLimit = availableSlots // 사진 갯수 제한
                    
            let imagePicker = PHPickerViewController(configuration: config)
            imagePicker.delegate = self
            imagePicker.modalPresentationStyle = .automatic
                    
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
        
        RecipeBookUploadService.shared.uploadImages(self.imageList) { response, error in
            if let error = error {
                print("레시피북 이미지 업로드 실패 - \(error.localizedDescription)")
            } else if let response = response {
                guard let recipeImageList = response.result?.recipeImageList else { return }
                
                // 해시태그 문자열을 배열로 변환
                let hashtagText = self.hashtagTextField.text ?? ""
                let hashtags = self.extractHashtags(from: hashtagText)
                
                let postModel = RecipeBookUploadModel.RecipeRequestDTO(
                    title: self.titleTextField.text!,
                    cookingTime: self.cookingTimeTextField.text!,
                    calorie: self.calorieTextField.text!,
                    ingredient: self.ingredientTextField.text!,
                    recipeInstruction: self.cookingMethodTextView.text!,
                    recommendCombination: self.cookingMethodTextView.text!,
                    hashTagNameList: hashtags,
                    recipeImageList: recipeImageList
                )
                
                if self.isModify { // 수정일 때
                    guard let recipeBookId = self.recipeBookDetailData?.result.id else { return }
                    
                    RecipeBookService.shared.patchRecipeBook(recipeBookId: recipeBookId, patchModel: postModel) { error in
                        if let error = error {
                            print("레시피북 수정 실패 - \(error.localizedDescription)")
                        } else {
                            print("레시피북 수정 성공")
                            if let vc = self.navigationController?.viewControllers.first(where: { $0 is RecipeBookDetailViewController }) as? RecipeBookDetailViewController {
                                vc.fetchData()
                                self.navigationController?.popToViewController(vc, animated: true)
                            }
                        }
                    }
                    
                } else { // 일반 작성
                    RecipeBookUploadService.shared.uploadPost(postModel) { response, error in
                        if let error = error {
                            print("레시피북 게시글 업로드 실패 - \(error.localizedDescription)")
                        } else if response != nil {
                            print("레시피북 게시글 업로드 성공")
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
extension RecipeBookUploadViewController {
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
            
            self.navigationController?.popViewController(animated: true)
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        let cancelAction = UIAlertAction(title: "확인", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
            
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
            
        self.present(alertController, animated: false, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension RecipeBookUploadViewController: UICollectionViewDataSource {
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
extension RecipeBookUploadViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case titleTextField:
            titleLine.backgroundColor = .customOrange
        case hashtagTextField:
            hashtagLine.backgroundColor = .customOrange
        case cookingTimeTextField:
            cookingTimeLine.backgroundColor = .customOrange
        case calorieTextField:
            calorieLine.backgroundColor = .customOrange
        case ingredientTextField:
            ingredientLine.backgroundColor = .customOrange
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
        titleLine.backgroundColor = .base0700
        hashtagLine.backgroundColor = .base0700
        cookingTimeLine.backgroundColor = .base0700
        calorieLine.backgroundColor = .base0700
        ingredientLine.backgroundColor = .base0700
        cookingMethodLine.backgroundColor = .base0700
        
        self.updateCompleteButton() // 텍스트필드 입력이 끝날때 마다 작성완료 버튼 업데이트
    }
}

// MARK: - UITextViewDelegate
extension RecipeBookUploadViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedFrame = textView.sizeThatFits(size)
        
        textView.constraints.forEach{ (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedFrame.height
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "조리방법을 입력해주세요." {
            textView.text = nil
            textView.textColor = .black
        }
        cookingMethodLine.backgroundColor = .customOrange
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "조리방법을 입력해주세요."
            textView.textColor = .placeholderText
        }
        cookingMethodLine.backgroundColor = .base0700
        self.updateCompleteButton()
    }
}

// MARK: - PHPickerViewControllerDelegate
extension RecipeBookUploadViewController: PHPickerViewControllerDelegate {
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

// MARK: - UI
extension RecipeBookUploadViewController {
    
    private func addViews() {
        view.addSubviews([
            scrollView,
            completeButton
        ])
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubviews([
            titleView,
            hashtagView,
            imageView,
            cookingTimeView,
            calorieView,
            ingredientView,
            cookingMethodLabel,
            cookingMethodTextView,
            cookingMethodLine
        ])
        
        stackView.setCustomSpacing(16, after: cookingMethodLabel)
        stackView.setCustomSpacing(0, after: cookingMethodTextView)
        
        titleView.addSubviews([titleLabel, titleTextField, titleLine])
        hashtagView.addSubviews([hashtagLabel, hashtagTextField, hashtagLine])
        imageView.addSubviews([imageLabel, imageUploadButton, imageCollectionView])
        cookingTimeView.addSubviews([cookingTimeLabel, cookingTimeTextField, cookingTimeLine])
        calorieView.addSubviews([calorieLabel, calorieTextField, calorieLine])
        ingredientView.addSubviews([ingredientLabel, ingredientTextField, ingredientLine])
        
        completeButton.addSubview(completeLabel)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(completeButton.snp.top)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.edges.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(20)
        }
        
        [titleView, hashtagView, cookingTimeView, calorieView, ingredientView].forEach {
            $0.snp.makeConstraints { make in
                make.leading.trailing.equalTo(stackView)
                make.height.equalTo(72)
            }
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
        
        // 소요시간
        cookingTimeLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(cookingTimeView)
        }
        
        cookingTimeTextField.snp.makeConstraints { make in
            make.top.equalTo(cookingTimeLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(cookingTimeView)
        }
        
        cookingTimeLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(cookingTimeView)
            make.height.equalTo(1)
        }
        
        // 칼로리
        calorieLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(calorieView)
        }
        
        calorieTextField.snp.makeConstraints { make in
            make.top.equalTo(calorieLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(calorieView)
        }
        
        calorieLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(calorieView)
            make.height.equalTo(1)
        }
        
        // 재료
        ingredientLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(ingredientView)
        }
        
        ingredientTextField.snp.makeConstraints { make in
            make.top.equalTo(ingredientLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(ingredientView)
        }
        
        ingredientLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(ingredientView)
            make.height.equalTo(1)
        }
        
        // 조리 방법
        cookingMethodLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(stackView)
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
