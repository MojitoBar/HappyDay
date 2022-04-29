//
//  PersonCell.swift
//  HappyDay
//
//  Created by judongseok on 2022/04/29.
//

import UIKit
import RxDataSources

// MARK: - Person Header Cell
class PersonTableViewHeaderView: UITableViewHeaderFooterView {
    static let headerViewId = "PersonTableViewHeaderView"
    
    var profileImageVIew: UIImageView = {
        var profile = UIImageView()
        return profile
    }()
    
    var nameLabel: UILabel = {
        var name = UILabel()
        return name
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupHeaderView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeaderView() {
        contentView.addSubview(profileImageVIew)
        contentView.addSubview(nameLabel)
    }
    
    private func setupLayout() {
        profileImageVIew.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.leading.equalTo(contentView).offset(20)
            $0.top.bottom.equalTo(contentView)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageVIew.snp.trailing)
            $0.top.bottom.equalTo(contentView)
        }
    }
}

// MARK: - Person Cell
class PersonCell: UITableViewCell {
    static let cellId = "CellId"
    
    let name = UILabel()
    let phoneNumber = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(name)
        self.addSubview(phoneNumber)
        
        name.font = UIFont.systemFont(ofSize: 14)
        phoneNumber.font = UIFont.systemFont(ofSize: 14)
        
        name.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.top.bottom.equalTo(0)
        }
        
        phoneNumber.snp.makeConstraints{
            $0.leading.equalTo(name.snp.trailing).offset(16)
            $0.top.bottom.equalTo(0)
        }
    }
}

// MARK: - Person Section Cell
struct PersonSection {
    var header: String
    var items: [Item]
}

extension PersonSection: AnimatableSectionModelType {
    typealias Item = Person
    
    init(original: PersonSection, items: [Person]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return header
    }
}
