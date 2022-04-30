//
//  FetchContacts.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/01.
//

import UIKit
import RxSwift
import Contacts

// MARK: - [전화번호 주소록에 저장된 데이터 확인 메소드]
let store = CNContactStore() // 전화번호 주소록 접근 객체

class FetchContacts {
    static func readAddress(onComplete: @escaping ([Person]) -> Void){
        // [퍼미션 권한 확인]
        store.requestAccess(for: .contacts) { (granted, error) in
            guard granted // MARK: [권한이 부여된 경우]
            else { // MARK: [권한이 부여되지 않은 경우]
                return
            }
            // [Request 생성 : 전화번호 주소록에서 알아오려는 key 지정]
            let request: CNContactFetchRequest = getCNContactFetchRequest()
            // [주소록 읽을 때 정렬 실시]
            request.sortOrder = CNContactSortOrder.userDefault
            
            var persons: [Person] = []
            
            // Contacts 주소록 읽기 [주소록이 1개씩 읽혀서 usingBlock으로 들어옵니다]
            try! store.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                if contact.phoneNumbers.isEmpty == false { // 휴대폰 번호가 있을 경우만 배열에 추가 실시
                    // [이름]
                    let name = contact.familyName + contact.givenName
                    // [전화번호]
                    let phone = contact.phoneNumbers[0].value.value(forKey: "digits") ?? ""
                    
                    let person = Person.init(name: name, phoneNumber: phone as! String)
                    persons.append(person)
                }
            })
            onComplete(persons)
        }
    }
    
    // [Request 객체 생성 - 주소록에서 읽을 key 지정]
    static func getCNContactFetchRequest() -> CNContactFetchRequest {
        // [주소록에서 읽어올 key 설정]
        let keys: [CNKeyDescriptor] = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), // 이름
                                       CNContactPhoneNumbersKey, // 전화번호
                                       CNContactEmailAddressesKey, // 이메일
                                       CNContactJobTitleKey, // 직장
                                       CNContactImageDataAvailableKey, // 이미지
                                       CNContactThumbnailImageDataKey, // 이미지
                                       CNContactPostalAddressesKey] as! [CNKeyDescriptor]
        return CNContactFetchRequest(keysToFetch: keys)
    }
    
    static func fetchContactsRx() -> Observable<[Person]> {
        return Observable.create() { emitter in
            readAddress { result in
                emitter.onNext(result)
                emitter.onCompleted()
            }
            return Disposables.create()
        }
    }
}
