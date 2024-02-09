//
//  UIVIew+CustomSearchView.swift
//  DrinkingGourmet
//
//  Created by hee on 1/22/24.
//

import UIKit
import SnapKit

final class FoodSearchBarView: UIView {
    
    private var foodSearchField: UITextField = {
        let textField = UITextField()
        
        textField.placeHolder(string: "치킨", color: UIColor.baseColor.base07)
        textField.text = ""
        textField.textColor = UIColor.baseColor.base01
        textField.font = UIFont.systemFont(ofSize: 20)
        
        return textField
    }()
    
    private var clearButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        btn.addTarget(FoodSearchBarView.self, action: #selector(clearTextField), for: .touchUpInside)
        btn.tintColor = UIColor.baseColor.base07
        
        return btn
    }()
    
    
    private var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.baseColor.base07
        return lineView
    }()
    
    //MARK: - tableView 추가 예정
    private var relatedSearchWordsTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    
    private var didLayoutSubViews: Bool = false
    
    //MARK: - LifeCycle
    init() {
        super.init(frame: .zero)
        
        foodSearchField.delegate = self
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func layout() {
        addSubview(foodSearchField)
        addSubview(clearButton)
        addSubview(lineView)
        
        foodSearchField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(44)
        }
        clearButton.snp.makeConstraints { make in
            make.leading.equalTo(foodSearchField.snp.trailing)
            make.centerY.equalTo(foodSearchField)
            make.height.equalTo(24)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(foodSearchField.snp.bottom)
            make.leading.equalTo(foodSearchField.snp.leading)
            make.trailing.equalTo(clearButton.snp.trailing)
            make.height.equalTo(1)
        }
        
    }
    
    @objc private func clearTextField(_ sender: UIButton) {
        foodSearchField.text = ""
    }
}

extension FoodSearchBarView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lineView.backgroundColor = UIColor.baseColor.base01
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            lineView.backgroundColor = UIColor.baseColor.base07
        }
    }
}
