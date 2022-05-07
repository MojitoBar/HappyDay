//
//  DetailViewModel.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/08.
//

import UIKit
import RxSwift
import RxRelay

class DetailViewModel {
    let info = BehaviorRelay<Person>(value: Person(name: "", phoneNumber: ""))
    
    init() {
        
    }
}
