//
//  GivenItem.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/17.
//

import UIKit

class GivenItem {
    var image: UIImage?
    
    init() {
        image = nil
    }
    
    init(image: UIImage?) {
        self.image = image
    }
}

let dummyGivenItems: [GivenItem] = [
    GivenItem(image: UIImage.init(systemName: "bell")),
    GivenItem(image: UIImage.init(systemName: "star")),
    GivenItem(image: UIImage.init(systemName: "bell")),
    GivenItem(image: UIImage.init(systemName: "star")),
]
