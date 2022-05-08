//
//  HomeViewModel.swift
//  HappyDay
//
//  Created by judongseok on 2022/04/29.
//

import UIKit
import RxSwift
import RxRelay
import Contacts

class HomeViewModel {
    lazy var personObservable = BehaviorRelay<[PersonSection]>(value: [])
    
    var persons: [Person] = []
    var filterPersons: [Person] = []
    var sections: [PersonSection] = []
    
    let disposeBag = DisposeBag()
    
    init() {
        _ = FetchContacts.fetchContactsRx()
            .map{ [self] data -> [String:[Person]] in
                persons = data
                filterPersons = persons
                let personsDic = arrToDic(persons: persons)
                return personsDic
            }
            .map{ [self] persons -> [PersonSection] in
                sections = dicToObserbable(dic: persons)
                return sections
            }
            .map{ result -> [PersonSection] in
                return result.sorted { item1, item2 in
                    return item1.header < item2.header
                }
            }
            .bind(to: personObservable)
            .disposed(by: disposeBag)
    }
    
    func arrToDic(persons: [Person]) -> [String: [Person]] {
        var personsDic: [String:[Person]] = [:]
        persons.enumerated().forEach { (index, item) in
            if personsDic[item.name.getFirstChar()] != nil {
                personsDic[item.name.getFirstChar()]!.append(Person(name: item.name, phoneNumber: item.phoneNumber))
            }
            else {
                personsDic[item.name.getFirstChar()] = [Person(name: item.name, phoneNumber: item.phoneNumber)]
            }
        }
        return personsDic
    }
    
    func dicToObserbable(dic: [String: [Person]]) -> [PersonSection] {
        var sections: [PersonSection] = []
        dic.forEach { (key, value) in
            sections.append(PersonSection(header: key, items: value))
        }
        sections = sections.sorted { item1, item2 in
            return item1.header < item2.header
        }
        return sections
    }
}
