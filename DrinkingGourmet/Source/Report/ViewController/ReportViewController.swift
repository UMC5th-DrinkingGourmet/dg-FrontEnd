//
//  ReportViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 3/26/24.
//

import UIKit

final class ReportViewController: UIViewController {
    // MARK: - Properties
    private let arrayReportType = ["-- 신고 유형을 선택해주세요 --",
                                   "욕설, 비속어, 혐오 발언 등 타인에게 불쾌감을 주는 내용",
                                   "타인을 모욕하거나 명예를 훼손하는 내용을 게시",
                                   "음란물, 불법적인 내용을 게시",
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
            action: #selector(dismissPickerView)
        )
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true

        reportView.reportTypeTextField.inputAccessoryView = toolbar
    }
}

// MARK: - @objc
extension ReportViewController {
    @objc func dismissPickerView() {
        view.endEditing(true)
    }
    
    @objc func completeButtonTapped() {
        print("신고하기 버튼 눌림")
    }
}

// MARK: - UITextFieldDelegate
extension ReportViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if !text.isEmpty, text != "-- 신고 유형을 선택해주세요 --" {
            reportView.reportTypeView.layer.borderColor = UIColor.customOrange.cgColor
        } else {
            reportView.reportTypeView.layer.borderColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        }
        updateCompleteButton()
    }
}

// MARK: - UITextViewDelegate
extension ReportViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else { return }
        
        if !text.isEmpty {
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
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(arrayReportType[row])"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reportView.reportTypeTextField.text = "\(arrayReportType[row])"
    }
}
