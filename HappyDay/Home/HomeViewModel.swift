//
//  HomeViewModel.swift
//  HappyDay
//
//  Created by judongseok on 2022/04/29.
//

import Foundation
import RxRelay

class HomeViewModel {
    var user: [Person] = []

    lazy var personObservable = BehaviorRelay<[Person]>(value: user)
    
    init() {
        user = [Person(name: "홍길동", phoneNumber: "010-1234-5678"),
              Person(name: "홍길동1", phoneNumber: "010-1234-5678"),
              Person(name: "홍길동2", phoneNumber: "010-1234-5678"),
              Person(name: "홍길동3", phoneNumber: "010-1234-5678"),
              Person(name: "홍길동4", phoneNumber: "010-1234-5678"),
              Person(name: "홍길동5", phoneNumber: "010-1234-5678")]
    }
}
