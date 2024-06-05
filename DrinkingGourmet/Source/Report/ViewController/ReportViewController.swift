//
//  ReportViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 3/26/24.
//

import UIKit

final class ReportViewController: UIViewController {
    // MARK: - Properties
    var resourceId: Int? = nil
    var reportTarget: String? = nil
    private var reportReason: String = "" // 신고유형
    private var content: String = "" // 신고내용
    var reportContent: String? = nil
    
    private let arrayReportType = ["-- 신고 유형을 선택해주세요 --",
                                   "욕설, 비속어, 혐오 발언 등 타인에게 불쾌감을 주는 내용",
                                   "타인을 모욕하거나 명예를 훼손하는 내용",
                                   "음란물, 불법적인 내용",
                                   "타인의 개인정보를 무단으로 수집하거나 공개",
                                   "타인의 저작권을 침해",
                                   "기타"]
    
    private let reportView = ReportView()
    
    // MARK: - View 설정
    override func loadView() {
        view = reportView
    }
    
    // MARK: - ViewDidLodad
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
        
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, 
                                            target: nil,
                                            action: nil)
        
        let btnDoneBar = UIBarButtonItem(title: "완료",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneBtnClicked))
        
        toolBarKeyboard.items = [flexibleSpace, btnDoneBar]
        reportView.reportDetailsTextView.inputAccessoryView = toolBarKeyboard
    }
    
    private func setupButton() {
        reportView.completeButton.addTarget(
            self,
            action: #selector(completeButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func updateCompleteButton() {
        if reportView.reportTypeView.layer.borderColor == UIColor.customOrange.cgColor
            && reportView.reportDetailsTextView.layer.borderColor == UIColor.customOrange.cgColor {
            reportView.completeButton.backgroundColor = .customOrange
            reportView.completeButton.isEnabled = true
        } else {
            reportView.completeButton.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
            reportView.completeButton.isEnabled = false
        }
    }
    
    private func setupPickerView() {
        reportView.pickerView.dataSource = self
        reportView.pickerView.delegate = self

        // 텍스트 필드의 입력 방식을 피커 뷰로 설정
        reportView.reportTypeTextField.inputView = reportView.pickerView

        // 피커 뷰 위에 툴바 추가
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let doneButton = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self, 
            action: #selector(doneBtnClicked)
        )
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true

        reportView.reportTypeTextField.inputAccessoryView = toolbar
    }
}

// MARK: - @objc
extension ReportViewController {
    @objc func doneBtnClicked() {
        view.endEditing(true)
    }
    
    @objc func completeButtonTapped() {
        self.reportView.isUserInteractionEnabled = false // 터치 비활성화
        
        self.reportView.completeView.isHidden = true
        self.reportView.reportCompletePopUpView.isHidden = false
        
        guard let resourceId = self.resourceId,
              let reportTarget = self.reportTarget,
              let reportContent = self.reportContent else { return }
        
        ReportDataManager().postReport(resourceId: resourceId,
                                       reportTarget: reportTarget,
                                       reportReason: self.reportReason,
                                       content: self.content,
                                       reportContent: reportContent) { [weak self] success in
            guard let self = self else { return }
            
            if success {
                if reportTarget == "COMBINATION" { // 오늘의 조합 게시물 신고일 때
                    if let VC = self.navigationController?.viewControllers.first(where: { $0 is CombiationViewController }) as? CombiationViewController {
                        VC.fetchData()
                        VC.todayCombinationView.tableView.setContentOffset(.zero, animated: true)
                        self.navigationController?.popToViewController(VC, animated: true)
                    }
                }
                
                if reportTarget == "COMBINATION_COMMENT" { // 오늘의 조합 댓글 신고일 때
                    self.navigationController?.popViewController(animated: true)
                    if let VC = self.navigationController?.viewControllers.last as? CombinationDetailViewController {
                        VC.combinationDetailView.tabelView.setContentOffset(.zero, animated: true)
                        VC.fetchData()
                    }
                }
                
                if reportTarget == "RECIPE" { // 레시피북 게시물 신고일 때
                    if let VC = self.navigationController?.viewControllers.first(where: { $0 is RecipeBookHomeVC }) as? RecipeBookHomeVC {
                        VC.fetchData()
                        VC.recipeBookHomeView.tableView.setContentOffset(.zero, animated: true)
                        self.navigationController?.popToViewController(VC, animated: true)
                    }
                }
                
                if reportTarget == "RECIPE_COMMENT" { // 레시피북 댓글 신고일 때
                    self.navigationController?.popViewController(animated: true)
                    if let VC = self.navigationController?.viewControllers.last as? RecipeBookDetailVC {
                        VC.recipeBookDetailView.tabelView.setContentOffset(.zero, animated: true)
                        VC.fetchData()
                    }
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension ReportViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) { // 신고 유형
        guard let text = textField.text else { return }
        
        if !text.isEmpty, text != "-- 신고 유형을 선택해주세요 --" {
            switch text {
            case arrayReportType[1]:
                self.reportReason = "ABUSIVE_LANGUAGE"
            case arrayReportType[2]:
                self.reportReason = "DEFAMATION"
            case arrayReportType[3]:
                self.reportReason = "PORNOGRAPHY_ILLEGAL_CONTENT"
            case arrayReportType[4]:
                self.reportReason = "UNAUTHORIZED_PERSONAL_INFO"
            case arrayReportType[5]:
                self.reportReason = "COPYRIGHT_INFRINGEMENT"
            case arrayReportType[6]:
                self.reportReason = "TERMS_VIOLATION"
            default:
                return
            }
            reportView.reportTypeView.layer.borderColor = UIColor.customOrange.cgColor
        } else {
            reportView.reportTypeView.layer.borderColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        }
        updateCompleteButton()
    }
}

// MARK: - UITextViewDelegate
extension ReportViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) { // 신고 내용
        guard let text = textView.text else { return }
        
        if !text.isEmpty {
            self.content = text
            reportView.reportDetailsTextView.layer.borderColor = UIColor.customOrange.cgColor
        } else {
            reportView.reportDetailsTextView.layer.borderColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        }
        updateCompleteButton()
    }
}

// MARK: - 피커뷰
extension ReportViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayReportType.count
    }
}

extension ReportViewController: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "\(arrayReportType[row])"
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
            label.numberOfLines = 0
        }
        
        label.text = "\(arrayReportType[row])"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reportView.reportTypeTextField.text = "\(arrayReportType[row])"
    }
}
