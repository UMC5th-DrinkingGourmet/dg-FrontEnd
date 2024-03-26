//
//  ReportViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 3/26/24.
//

import UIKit

final class ReportViewController: UIViewController {
    // MARK: - Properties
    private let reportView = ReportView()
    
    let exampleArray = ["부적절한 내용", "욕설", "비방"]
    
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
        reportView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
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

        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(dismissPickerView))
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
    
}

// MARK: - UITextViewDelegate
extension ReportViewController: UITextViewDelegate {
    
}

// MARK: - 피커뷰
extension ReportViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exampleArray.count
    }
}

extension ReportViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(exampleArray[row])"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        reportView.reportTypeView.layer.borderColor = UIColor.customOrange.cgColor
        reportView.reportTypeTextField.text = "\(exampleArray[row])"
    }
}
