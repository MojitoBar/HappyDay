//
//  GivenItem.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/16.
//

import UIKit

class GivenItemView: UIView {
    // MARK: - view life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(givenItem: GivenItem) {
        self.init(frame: CGRect.zero)
        setLayout(img: givenItem.image)
    }
    
    convenience init(img: UIImage) {
        self.init(frame: CGRect.zero)
        setLayout(img: img)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ui setting
    let productImage: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 8
        img.layer.borderColor = UIColor.black.cgColor
        img.layer.borderWidth = 1
        return img
    }()
    
    // MARK: - layout setting
    func setLayout(img: UIImage?) {
        self.addSubview(productImage)
        
        productImage.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.top.equalTo(0)
            $0.width.equalTo(80)
            $0.height.equalTo(70)
        }
        productImage.image = img ?? UIImage.init(systemName: "heart")
    }
}
