//
//  ReportCompletePopUpView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 4/14/24.
//

import UIKit

final class ReportCompletePopUpView: UIView {
    // MARK: - View
    private let icon = UIImageView().then {
        $0.image = UIImage(named: "ic_check_report_complete")
    }
    
    private let label = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.text = "신고가 접수되었습니다."
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: 335, height: 64)
        self.backgroundColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
        self.layer.cornerRadius = 8
        
        addViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func addViews() {
        self.addSubviews([
            icon,
            label
        ])
    }
    
    private func configureConstraints() {
        icon.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }
    }
}
