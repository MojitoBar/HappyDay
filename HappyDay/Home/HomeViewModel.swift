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
            .map{ data -> [String:[Person]] in
                var persons: [String:[Person]] = [:]
                data.enumerated().forEach { (index, item) in
                    if persons[item.name.getFirstChar()] != nil {
                        persons[item.name.getFirstChar()]!.append(Person(name: item.name, phoneNumber: item.phoneNumber))
                    }
                    else {
                        persons[item.name.getFirstChar()] = [Person(name: item.name, phoneNumber: item.phoneNumber)]
                    }
                }
                return persons
            }
            .map{ persons -> [PersonSection] in
                var sections: [PersonSection] = []
                persons.forEach { (key, value) in
                    sections.append(PersonSection(header: key, items: value))
                }
                return sections
            }
            .map{ result -> [PersonSection] in
                return result.sorted { item1, item2 in
                    return item1.header < item2.header
                }
            }
            .bind(to: personObservable)
    }
    
    func filterSearchText() {
        
    }
}
