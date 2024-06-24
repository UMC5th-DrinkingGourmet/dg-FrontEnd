//
//  ReportViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 3/26/24.
//

import UIKit
import Toast

enum ReportType: String, CaseIterable {
    case select = "-- 신고 유형을 선택해주세요 --"
    case abusiveLanguage = "욕설, 비속어, 혐오 발언 등 타인에게 불쾌감을 주는 내용"
    case defamation = "타인을 모욕하거나 명예를 훼손하는 내용"
    case pornographyIllegalContent = "음란물, 불법적인 내용"
    case unauthorizedPersonalInfo = "타인의 개인정보를 무단으로 수집하거나 공개"
    case copyrightInfringement = "타인의 저작권을 침해"
    case termsViolation = "기타"
    
    var apiValue: String? {
        switch self {
        case .abusiveLanguage: return "ABUSIVE_LANGUAGE"
        case .defamation: return "DEFAMATION"
        case .pornographyIllegalContent: return "PORNOGRAPHY_ILLEGAL_CONTENT"
        case .unauthorizedPersonalInfo: return "UNAUTHORIZED_PERSONAL_INFO"
        case .copyrightInfringement: return "COPYRIGHT_INFRINGEMENT"
        case .termsViolation: return "TERMS_VIOLATION"
        case .select: return nil
        }
    }
}

final class ReportViewController: UIViewController {
    // MARK: - Properties
    var resourceId: Int?
    var reportTarget: String?
    var reportContent: String?
    
    private let reportView = ReportView()
    
    // MARK: - View 설정
    override func loadView() {
        view = reportView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupTextField()
        setupTextView()
        setupButton()
        setupPickerView()
    }
    
    private func setupNaviBar() {
        title = "신고하기"
    }
    
    private func setupTextField() {
        reportView.reportTypeTextField.delegate = self
    }
    
    private func setupTextView() {
        reportView.reportDetailsTextView.delegate = self
        reportView.reportDetailsTextView.inputAccessoryView = createToolbar()
    }
    
    private func setupButton() {
        reportView.completeButton.addTarget(self,
                                            action: #selector(completeButtonTapped),
                                            for: .touchUpInside)
    }
    
    private func updateCompleteButton() {
        guard let reportTypeText = reportView.reportTypeTextField.text,
              let reportType = ReportType(rawValue: reportTypeText),
              reportType != .select,
              let reportDetailsText = reportView.reportDetailsTextView.text,
              !reportDetailsText.isEmpty else {
            reportView.completeButton.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
            reportView.completeButton.isEnabled = false
            return
        }
        
        reportView.completeButton.backgroundColor = .customOrange
        reportView.completeButton.isEnabled = true
    }
    
    private func setupPickerView() {
        reportView.pickerView.dataSource = self
        reportView.pickerView.delegate = self
        reportView.reportTypeTextField.inputView = reportView.pickerView
        reportView.reportTypeTextField.inputAccessoryView = createToolbar()
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btnDoneBar = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneBtnClicked))
        
        toolbar.setItems([flexibleSpace, btnDoneBar], animated: false)
        return toolbar
    }
}

// MARK: - @objc
extension ReportViewController {
    @objc func doneBtnClicked() {
        view.endEditing(true)
    }
    
    @objc func completeButtonTapped() {
        guard let resourceId = self.resourceId,
              let reportTarget = self.reportTarget,
              let reportReasonText = self.reportView.reportTypeTextField.text,
              let reportReason = ReportType(rawValue: reportReasonText)?.apiValue,
              let content = self.reportView.reportDetailsTextView.text,
              let reportContent = self.reportContent else {
            return
        }
        
        DispatchQueue.main.async {
            self.navigationItem.hidesBackButton = true // 백버튼 숨기기
            self.reportView.isUserInteractionEnabled = false // 화면 터지 막기
            self.reportView.completeView.isHidden = true
            
            let popUpView = ReportCompletePopUpView() // 토스트 뷰
            ToastManager.shared.style.fadeDuration = 1.5
            self.view.showToast(popUpView)
        }
        
        AdministrationService.shared.postReport(resourceId: resourceId,
                                                reportTarget: reportTarget,
                                                reportReason: reportReason,
                                                content: content,
                                                reportContent: reportContent) { error in
            if let error = error {
                print("\(reportTarget): \(resourceId)번 신고 실패 - \(error.localizedDescription)")
            } else {
                print("\(reportTarget): \(resourceId)번 신고 성공")
                
                switch reportTarget {
                case "COMBINATION": // 오늘의 조합 게시물 신고
                    if let vc = self.navigationController?.viewControllers.first(where: { $0 is CombinationHomeViewController }) as? CombinationHomeViewController {
                        vc.fetchData()
                        vc.combinationHomeView.tableView.setContentOffset(.zero, animated: true)
                        self.navigationController?.popToViewController(vc, animated: true)
                    } else if let likeVC = self.navigationController?.viewControllers.first(where: { $0 is LikeViewController }) as? LikeViewController {
                        likeVC.fetchData()
                        likeVC.likeView.collectionView.setContentOffset(.zero, animated: true)
                        self.navigationController?.popToViewController(likeVC, animated: true)
                    }
                case "COMBINATION_COMMENT": // 오늘의 조합 뎃글 신고
                    self.navigationController?.popViewController(animated: true)
                    if let vc = self.navigationController?.viewControllers.last as? CombinationDetailViewController {
                        vc.combinationDetailView.tabelView.setContentOffset(.zero, animated: true)
                        vc.fetchData()
                    }
                case "RECIPE": // 레시피북 게시물 신고
                    if let vc = self.navigationController?.viewControllers.first(where: { $0 is RecipeBookHomeViewController }) as? RecipeBookHomeViewController {
                        vc.fetchData()
                        vc.recipeBookHomeView.tableView.setContentOffset(.zero, animated: true)
                        self.navigationController?.popToViewController(vc, animated: true)
                    } else if let likeVC = self.navigationController?.viewControllers.first(where: { $0 is LikeViewController }) as? LikeViewController {
                        likeVC.fetchData()
                        likeVC.likeView.collectionView.setContentOffset(.zero, animated: true)
                        self.navigationController?.popToViewController(likeVC, animated: true)
                    }
                case "RECIPE_COMMENT": // // 레시피북 댓글 신고
                    self.navigationController?.popViewController(animated: true)
                    if let vc = self.navigationController?.viewControllers.last as? RecipeBookDetailViewController {
                        vc.recipeBookDetailView.tabelView.setContentOffset(.zero, animated: true)
                        vc.fetchData()
                    }
                default:
                    break
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension ReportViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        reportView.reportTypeView.layer.borderColor = UIColor.customOrange.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        reportView.reportTypeView.layer.borderColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        updateCompleteButton()
    }
}

// MARK: - UITextViewDelegate
extension ReportViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        reportView.reportDetailsTextView.layer.borderColor = UIColor.customOrange.cgColor
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        reportView.reportDetailsTextView.layer.borderColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        updateCompleteButton()
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate
extension ReportViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ReportType.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
            label.numberOfLines = 0
        }
        
        label.text = ReportType.allCases[row].rawValue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reportView.reportTypeTextField.text = ReportType.allCases[row].rawValue
        updateCompleteButton()
    }
}
