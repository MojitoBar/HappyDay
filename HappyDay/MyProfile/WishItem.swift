//
//  wishListView.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/16.
//

import UIKit

class WishListView: UIView {
    
    // MARK: - view life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(img: UIImage, name: String, content: String, price: String) {
        self.init(frame: CGRect.zero)
        setLayout(img: img, name: name, content: content, price: price)
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
    
    let productName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    let productContent: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    let productPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    // MARK: - layout setting
    func setLayout(img: UIImage, name: String, content: String, price: String) {
        self.addSubview(productImage)
        self.addSubview(productName)
        self.addSubview(productContent)
        self.addSubview(productPrice)
        
        productImage.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.top.equalTo(0)
            $0.width.equalTo(80)
            $0.height.equalTo(70)
        }
        productImage.image = img
        
        productName.snp.makeConstraints {
            $0.leading.equalTo(productImage.snp.trailing).offset(10)
            $0.top.equalTo(0)
        }
        productName.text = name
        
        productContent.snp.makeConstraints {
            $0.leading.equalTo(productImage.snp.trailing).offset(10)
            $0.top.equalTo(productName.snp.bottom).offset(5)
        }
        productContent.text = content
        
        productPrice.snp.makeConstraints {
            $0.leading.equalTo(productImage.snp.trailing).offset(10)
            $0.top.equalTo(productContent.snp.bottom).offset(5)
        }
        productPrice.text = price
    }
}
