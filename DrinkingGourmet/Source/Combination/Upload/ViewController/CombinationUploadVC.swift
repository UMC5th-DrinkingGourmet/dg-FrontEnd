////
////  CombinationUploadVC.swift
////  DrinkingGourmet
////
////  Created by 이승민 on 2/16/24.
////
//
import SnapKit
import Then
import Photos
import PhotosUI

class CombinationUploadVC: UIViewController {
    
    // MARK: - Properties
    
    var imageList: [UIImage] = []
    
    var recommendId: Int?
    
    var arrayRecommendList: [CombinationUploadModel.FetchRecommendListModel.RecommendResponseDTOList] = []
    
    // MARK: - View
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.keyboardDismissMode = .onDrag // 스크롤 시 키보드 숨김
    }
    
    let contentView = UIView()
    
    let pickerView = UIPickerView()
   
    
    // 선택한 조합
    let combinationLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "선택한 조합", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let roundView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.customColor.checkMarkGray.cgColor
    }
    
    let combinationTextField = UITextField().then {
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.tintColor = .clear
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .paragraphStyle: paragraphStyle,
            .kern: -0.48,
            .foregroundColor: UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        ]

        $0.attributedPlaceholder = NSAttributedString(string: "조합을 선택해주세요.", attributes: attributes)
    }

    
    let combinationButtonIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_upload_more_false")
    }
    
    // 해시태그
    let hashtagLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "해시태그", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let hashtagTextField = UITextField().then {
//        $0.text = "#"
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .paragraphStyle: paragraphStyle,
            .kern: -0.48
        ]
        
        $0.attributedPlaceholder = NSAttributedString(string: "#태그입력", attributes: attributes)
    }
    
    let grayLine1 = UIView().then {
        $0.backgroundColor = UIColor.customColor.checkMarkGray
    }
    
    // 사진
    private let imageLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "사진", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private let uploadBtn = UIButton().then {
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
    
    //제목
    let titleLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "제목", attributes: [NSAttributedString.Key.kern: -0.48, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    let titleTextField = UITextField().then {
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .paragraphStyle: paragraphStyle,
            .kern: -0.48
        ]
        
        $0.attributedPlaceholder = NSAttributedString(string: "제목을 입력해주세요.", attributes: attributes)
    }
    
    let grayLine2 = UIView().then {
        $0.backgroundColor = UIColor.customColor.checkMarkGray
    }
    
    let titleWarningLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.25
        $0.attributedText = NSMutableAttributedString(string: "최소 5자 / 최대 80자", attributes: [NSAttributedString.Key.kern: -0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    lazy var contentInputView = InputTextFieldView(frame: .zero).then {
        $0.onTextChanged = { [weak self] text in
//            print("텍스트 길이: \(text.count)")
            
        }
    }
    
    // 작성완료
    let completionView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
    }
    
    let completionButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.isEnabled = false
    }
    
    let completionLabel = UILabel().then {
        $0.text = "작성 완료"
        $0.textColor = .white
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNaviBar()
        prepare()
        
        configHierarchy()
        configLayout()
        configView()
        
        setupTextField()
        
        createPickerView()
 
        checkPermission()
        
        // 키보드 알림 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    deinit {
        // 알림 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        var configuration = uploadBtn.configuration
        var titleAttr = AttributedString("\(imageList.count)/10")
        titleAttr.foregroundColor = .lightGray
        titleAttr.font = UIFont.systemFont(ofSize: 12)
        configuration?.attributedTitle = titleAttr
        uploadBtn.configuration = configuration
    }
    
    // MARK: - 네비게이션바 설정
    func setupNaviBar() {
        title = "글쓰기"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명
        appearance.backgroundColor = .white
        
        // 백버튼 커스텀
        let customBackImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = customBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - 초기 설정
    func prepare() {
        let input = CombinationUploadInput.FetchRecommendListDataInput(page: 0, size: 20)
        
        CombinationUploadService.shared.fetchRecommendListData(input, self) { [weak self] model in
            guard let self = self else { return }
            
            if let model = model {
                self.arrayRecommendList = model.result.recommendResponseDTOList
            }
        }
    }
    
    // MARK: - UI
    func configHierarchy() {
        completionView.addSubviews([completionLabel, completionButton])
        
        view.addSubviews([scrollView, completionView])
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews([combinationLabel, roundView, combinationTextField, combinationButtonIcon, hashtagLabel, hashtagTextField, grayLine1, imageLabel, uploadBtn, collectionView, titleLabel, titleTextField, grayLine2, titleWarningLabel, contentInputView])
    }
    
    func configLayout() {
        // 스크롤뷰
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(completionView.snp.top)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(800)
        }
        
        // 작성완료
        completionView.snp.makeConstraints { make in
            make.height.equalTo(89)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        completionButton.snp.makeConstraints { make in
            make.edges.equalTo(completionView)
        }
        
        completionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(completionView)
            make.top.equalTo(completionView).inset(18)
        }
        
        // 선택한 조합
        combinationLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(30)
            make.leading.equalTo(contentView).offset(20)
        }
        
        roundView.snp.makeConstraints { make in
            make.top.equalTo(combinationLabel.snp.bottom).offset(8)
            make.leading.equalTo(combinationLabel)
            make.trailing.equalTo(contentView).inset(19)
        }
        
        combinationTextField.snp.makeConstraints { make in
            make.top.equalTo(roundView).inset(13)
            make.leading.equalTo(roundView).inset(16)
            make.trailing.equalTo(roundView).inset(16)
            make.bottom.equalTo(roundView).inset(12)
        }
        
        combinationButtonIcon.snp.makeConstraints { make in
            make.size.equalTo(12)
            make.top.equalTo(roundView).inset(19)
            make.trailing.equalTo(roundView).inset(16)
            make.bottom.equalTo(roundView).inset(18)
        }
        
        // 해시태그
        hashtagLabel.snp.makeConstraints { make in
            make.top.equalTo(roundView.snp.bottom).offset(56)
            make.leading.equalTo(combinationLabel)
        }
        
        hashtagTextField.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(hashtagLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(roundView)
        }
        
        grayLine1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(hashtagTextField.snp.bottom).offset(8)
            make.leading.trailing.equalTo(hashtagTextField)
        }

        // 사진
        imageLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine1.snp.bottom).offset(56)
            make.leading.equalTo(combinationLabel)
        }
        
        uploadBtn.snp.makeConstraints { make in
            make.top.equalTo(imageLabel.snp.bottom).offset(12)
            make.leading.equalTo(imageLabel)
            make.size.equalTo(100)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(uploadBtn.snp.top).offset(-15)
            make.leading.equalTo(uploadBtn.snp.trailing).offset(16)
            make.trailing.equalTo(contentView)
            make.height.equalTo(115)
        }
        
        // 제목
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(uploadBtn.snp.bottom).offset(56)
            make.leading.equalTo(combinationLabel)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(roundView)
        }
        
        grayLine2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(titleTextField.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleTextField)
        }
        
        titleWarningLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine2.snp.bottom).offset(8)
            make.trailing.equalTo(grayLine2.snp.trailing)
        }
        
        contentInputView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(72)
            $0.top.equalTo(titleWarningLabel.snp.bottom).offset(54)
        }
        
    }
    
    func configView() {
        uploadBtn.addTarget(self, action: #selector(uploadBtnClicked), for: .touchUpInside)
        
        contentInputView.title = "내용"
        contentInputView.placeholder = "내용을 입력해주세요"
        contentInputView.xBtn.isHidden = true
        contentInputView.textfieldText = ""
        
        completionButton.addTarget(self, action: #selector(completionBtnClicked), for: .touchUpInside)
    }
    
    @objc func completionBtnClicked() {
        if completionButton.isEnabled == true {
            print("클릭")
            print("Uploading \(imageList.count) images.")
            CombinationUploadService.shared.uploadImages(imageList) { (response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let response = response {
                    print("Response: \(response)")
                    // 이미지 업로드가 성공하면 게시글 업로드
                    if let recommendId = self.recommendId,
                       let combinationImageList = response.result?.combinationImageList,
                       let hashtagString = self.hashtagTextField.text {
                        let hashTagNameList = hashtagString.components(separatedBy: " ")
                        let postModel = CombinationUploadModel.WritingPostModel(
                            title: self.combinationTextField.text!,
                            content: self.contentInputView.textField.text ?? "contentInputView",
                            recommendId: recommendId,
                            hashTagNameList: hashTagNameList,
                            combinationImageList: combinationImageList)
                        CombinationUploadService.shared.uploadPost(postModel) { (response, error) in
                            if let error = error {
                                print("Post upload error: \(error)")
                            } else if let response = response {
                                print("Post upload response: \(response)")
                                DispatchQueue.main.async {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                        }
                    }
                }
            }
        } else {
            print("클릭 불가")
        }
    }

    
    func setupTextField() {
        combinationTextField.delegate = self
        hashtagTextField.delegate = self
        titleTextField.delegate = self
        contentInputView.textField.delegate = self
    }
    
    // 피커뷰
    func createPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self

        // 텍스트 필드의 입력 방식을 피커 뷰로 설정
        combinationTextField.inputView = pickerView

        // 피커 뷰 위에 툴바 추가
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(dismissPickerView))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true

        combinationTextField.inputAccessoryView = toolbar
    }
    
}

extension CombinationUploadVC {
    @objc func dismissPickerView() {
        view.endEditing(true)
    }
    
    @objc func uploadBtnClicked() {
        if imageList.count < 10 {
            var config = PHPickerConfiguration()
            config.filter = .images // 라이브러리에서 보여줄 Assets을 필터를 한다. (기본값: 이미지, 비디오, 라이브포토)
            config.selectionLimit = 10   // 한 번에 최대 10장 까지만 설정
                    
            let imagePicker = PHPickerViewController(configuration: config)
            imagePicker.delegate = self
            imagePicker.modalPresentationStyle = .fullScreen
                
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
    
    func checkPermission() {
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
    
    func moveToSetting() {
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

extension CombinationUploadVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let image = image as? UIImage else {
                    return
                }

                DispatchQueue.main.async {
                    self?.imageList.append(image)
                    self?.collectionView.reloadData()
                    
                    print(self?.imageList ?? "No data available")
                }
            }
        }
        picker.dismiss(animated: true)
    }
}

extension CombinationUploadVC: UICollectionViewDelegate, UICollectionViewDataSource {
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
    
    @objc func deleteImg(sender: UIButton) {
        let index = sender.tag
        
        imageList.remove(at: index)
        collectionView.reloadData()
        
        updateUploadButtonConfiguration()
    }
    
    private func updateUploadButtonConfiguration() {
        var configuration = uploadBtn.configuration
        var titleAttr = AttributedString("\(imageList.count)/10")
        titleAttr.foregroundColor = .lightGray
        titleAttr.font = UIFont.systemFont(ofSize: 12)
        configuration?.attributedTitle = titleAttr
        uploadBtn.configuration = configuration
    }
    
}

extension CombinationUploadVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == hashtagTextField, textField.text?.isEmpty ?? true {
            textField.text = "#"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == titleTextField {
            // 텍스트 필드의 현재 내용을 결정
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)

            updateGrayLine2Color(text: updatedText)
        }
        
        if textField == hashtagTextField {
            // 띄어쓰기가 입력될 때 # 추가
            if string == " ", let text = textField.text {
                textField.text = text + " #"
                return false
            }
            
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)

            updateGrayLine1Color(text: updatedText)
        }
        
        if textField == contentInputView.textField {
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
                
        contentInputView.borderView.backgroundColor = updatedText.isEmpty ? UIColor.customColor.checkMarkGray : UIColor.customColor.customOrange
        }
        
        return true
    }
    
    private func updateGrayLine1Color(text: String) {
        grayLine1.backgroundColor = text.isEmpty ? UIColor.customColor.checkMarkGray : .customOrange
    }
    
    private func updateGrayLine2Color(text: String) {
        grayLine2.backgroundColor = text.count >= 5 ? .customOrange : UIColor.customColor.checkMarkGray
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 모든 필드가 적절히 채워졌는지 확인
        let isFormComplete = isFormFilled()
        
        // 버튼의 활성화 상태 설정
        completionButton.isEnabled = isFormComplete
        
        // completionView의 배경색 변경
        completionView.backgroundColor = isFormComplete ? .black : UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
    }
    
    // 모든 필드가 채워졌는지 확인하는 메서드
    private func isFormFilled() -> Bool {
        return !(combinationTextField.text?.isEmpty ?? true) &&
        !(hashtagTextField.text?.isEmpty ?? true) &&
        !(titleTextField.text?.isEmpty ?? true) &&
        5 <= titleTextField.text!.count && titleTextField.text!.count <= 80 &&
        10 <= contentInputView.textField.text!.count
    }
    
    // 리턴 클릭 시 키보드 숨기기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        roundView.layer.borderColor = UIColor.customOrange.cgColor
        combinationTextField.text = "\(arrayRecommendList[row].foodName) & \(arrayRecommendList[row].drinkName)"
        recommendId = arrayRecommendList[row].recommendID
        print("recommendId: \(String(describing: recommendId))")
    }
}

