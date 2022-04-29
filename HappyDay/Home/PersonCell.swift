//
//  PersonCell.swift
//  HappyDay
//
//  Created by judongseok on 2022/04/29.
//

import UIKit
import RxDataSources

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
        
        name.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.top.bottom.equalTo(0)
        }
        
        phoneNumber.snp.makeConstraints{
            $0.leading.equalTo(name.snp.trailing).offset(20)
            $0.top.bottom.equalTo(0)
        }
    }
}

final class PersonTableViewHeaderView: UITableViewHeaderFooterView {
    static let headerViewId = "PersonTableViewHeaderView"
    
}

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