//
//  SearchResultCell.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

protocol SearchResultCellDelegate: AnyObject {
    func didTapDeleteButton(in cell: SearchResultCell)
}

import UIKit

class SearchResultCell: UITableViewCell {
    
    weak var delegate: SearchResultCellDelegate?

    let searchLabel = UILabel().then {
        $0.text = "골뱅이무침"
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_close"), for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        configureConstraints()
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        contentView.addSubviews([searchLabel, deleteButton])
    }
    
    func configureConstraints() {
        searchLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func deleteButtonTapped() {
        delegate?.didTapDeleteButton(in: self)
    }

}

