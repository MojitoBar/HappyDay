//
//  User.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/16.
//

import UIKit

struct User {
    var name: String
    var birthday: String
    var profile: UIImage?
    
    init() {
        self.name = ""
        self.birthday = ""
        self.profile = nil
    }
    
    init(name: String, birthday: String, profile: UIImage?) {
        self.name = name
        self.birthday = birthday
        self.profile = profile
    }
}

let DummyUser = User(name: "주동석", birthday: "12월 3일", profile: nil)
