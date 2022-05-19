//
//  GivenItemCell.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/19.
//

import RxDataSources
import UIKit
import SnapKit

class GivenItemCell: UICollectionViewCell {
    static let CellId: String = "GivenItemCell"
    
    var cellImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        print("asdf")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        contentView.backgroundColor = UIColor.lightGray
        contentView.addSubview(cellImage)
        cellImage.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(0)
            $0.height.equalTo(100)
        }
    }
}
