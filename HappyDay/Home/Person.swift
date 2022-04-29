//
//  Person.swift
//  HappyDay
//
//  Created by judongseok on 2022/04/29.
//

import RxDataSources

struct Person: IdentifiableType, Equatable {
    var identity: Int
    var name: String
    var phoneNumber: String
}
