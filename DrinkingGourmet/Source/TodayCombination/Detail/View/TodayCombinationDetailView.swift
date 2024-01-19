//
//  TodayCombinationDetailView.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/18/24.
//

import UIKit
import SnapKit
import Then

class TodayCombinationDetailView: UIView {
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.contentInsetAdjustmentBehavior = .never // 네비게이션바 뒤까지
        $0.showsVerticalScrollIndicator = false
    }
    
    let contentView = UIView().then {
        $0.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    // MARK: - 오토레이아웃 업데이트
    override func updateConstraints() {
        super.updateConstraints()
        configureConstraints()
    }
    
    func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.edges.equalTo(scrollView.contentLayoutGuide)
        }

    }
}
