//
//  WishItem.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/17.
//

import UIKit

struct WishItem {
    var name: String
    var content: String
    var price: String
    var image: UIImage?
    
    init() {
        self.name = ""
        self.content = ""
        self.price = ""
        self.image = nil
    }
    
    init(name: String, content: String, price: String, image: UIImage?) {
        self.name = name
        self.content = content
        self.price = price
        self.image = image
    }
}

let dummyWishItems: [WishItem] = [
    WishItem(name: "하트", content: "하트에 대한 소개입니다.", price: "3000원", image: UIImage.init(systemName: "haert")),
    WishItem(name: "별별", content: "별별에 대한 소개입니다.", price: "5000원", image: UIImage.init(systemName: "star")),
]
