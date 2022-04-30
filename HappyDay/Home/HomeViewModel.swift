//
//  HomeViewModel.swift
//  HappyDay
//
//  Created by judongseok on 2022/04/29.
//

import UIKit
import RxRelay
import Contacts

class HomeViewModel {
    lazy var personObservable = BehaviorRelay<[PersonSection]>(value: [])
    
    init() {
        _ = FetchContacts.fetchContactsRx()
            .map{ data -> [Person] in
                var persons: [Person] = []
                data.enumerated().forEach { (index, item) in
                    persons.append(Person(name: item.name, phoneNumber: item.phoneNumber))
                }
                return persons
            }
            .map{ persons -> [PersonSection] in
                var sections: [PersonSection] = []
                sections.append(PersonSection(header: "ㄱ", items: persons))
                return sections
            }
            .bind(to: personObservable)
    }
}
