//
//  Person.swift
//  HappyDay
//
//  Created by judongseok on 2022/04/29.
//
import UIKit
import RxDataSources

struct Person {
    var name: String
    var phoneNumber: String
}

extension Person: IdentifiableType, Equatable {
    // 예제 편의를 위해 UUID().uuidString을 사용했고, 실제에서는 데이터를 구분하는 id값 사용을 지향
    var identity: String {
        return UUID().uuidString
    }
}
