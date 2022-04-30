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
    var sections: [PersonSection] = []
    lazy var personObservable = BehaviorRelay<[PersonSection]>(value: sections)
    init() {
        sections = [
            PersonSection.init(header: "ㄱ", items: [Person.init(name: "강길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "강길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "강길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "강길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "강길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "강길동", phoneNumber: "010-1234-1234")]),
            PersonSection.init(header: "ㄷ", items: [Person.init(name: "다길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "다길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "다길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "다길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "다길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "다길동", phoneNumber: "010-1234-1234")]),
            PersonSection.init(header: "ㅎ", items: [Person.init(name: "강길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "홍길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "홍길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "홍길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "홍길동", phoneNumber: "010-1234-1234"),
                                                    Person.init(name: "홍길동", phoneNumber: "010-1234-1234")])
        ]
    }
    
    // MARK: [전화번호 주소록에 저장된 데이터 확인 메소드]
    let store = CNContactStore() // 전화번호 주소록 접근 객체
    func readAddress(){
        print("")
        print("===============================")
        print("[ViewController >> readAddress() :: 전화번호 주소록에 저장된 데이터 읽기 실시]")
        print("===============================")
        print("")
        
        // [퍼미션 권한 확인]
        self.store.requestAccess(for: .contacts) { (granted, error) in
            guard granted // MARK: [권한이 부여된 경우]
            else { // MARK: [권한이 부여되지 않은 경우]
                print("")
                print("===============================")
                print("[ViewController >> readAddress() :: 전화번호 주소록 접근 권한 비활성 상태]")
                print("===============================")
                print("")
                return
            }
            print("")
            print("===============================")
            print("[ViewController >> readAddress() :: 전화번호 주소록 접근 권한 활성 상태]")
            print("===============================")
            print("")
            
            // [Request 생성 : 전화번호 주소록에서 알아오려는 key 지정]
            let request: CNContactFetchRequest = self.getCNContactFetchRequest()
            
            // [주소록 읽을 때 정렬 실시]
            request.sortOrder = CNContactSortOrder.userDefault
            
            // Contacts 주소록 읽기 [주소록이 1개씩 읽혀서 usingBlock으로 들어옵니다]
            try! self.store.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                if contact.phoneNumbers.isEmpty == false { // 휴대폰 번호가 있을 경우만 배열에 추가 실시
//                    // [이름]
//                    let name = contact.familyName + contact.givenName
//                    // [전화번호]
                    let phone = contact.phoneNumbers[0].value.value(forKey: "digits") ?? ""
//                    // [이메일]
//                    let email = contact.emailAddresses[0].value
                    
                    let info = contact.familyName + contact.givenName
                    
                    print("")
                    print("===============================")
                    print("[ViewController >> readAddress() :: 전화번호 주소록 데이터 읽기 실시]")
                    print("INFO: \(info)")
                    print("PHONE: \(phone)")
                    print("===============================")
                    print("")
                }
            })
        }
    }
    // [Request 객체 생성 - 주소록에서 읽을 key 지정]
    private func getCNContactFetchRequest() -> CNContactFetchRequest {
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
}
