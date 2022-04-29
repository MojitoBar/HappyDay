//
//  HomeViewModel.swift
//  HappyDay
//
//  Created by judongseok on 2022/04/29.
//

import Foundation
import RxRelay

class HomeViewModel {
    var sections: [PersonSection] = []

    lazy var personObservable = BehaviorRelay<[PersonSection]>(value: sections)
    
    init() {
        sections = [
            PersonSection.init(header: "ㄱ", items: [Person.init(identity: 1, name: "강길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 1, name: "강길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 1, name: "강길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 1, name: "강길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 1, name: "강길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 1, name: "강길동", phoneNumber: "010-1234-1234")]),
            PersonSection.init(header: "ㄷ", items: [Person.init(identity: 1, name: "다길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 1, name: "다길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 1, name: "다길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 1, name: "다길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 1, name: "다길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 1, name: "다길동", phoneNumber: "010-1234-1234")]),
            PersonSection.init(header: "ㅎ", items: [Person.init(identity: 1, name: "강길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 2, name: "홍길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 2, name: "홍길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 2, name: "홍길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 2, name: "홍길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(identity: 2, name: "홍길동", phoneNumber: "010-1234-1234")])
        ]
    }
}
