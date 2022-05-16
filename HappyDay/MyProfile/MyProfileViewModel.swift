//
//  MyProfileViewModel.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/16.
//

import UIKit
import RxSwift
import RxRelay

class MyProfileViewModel {
    
    // OUTPUT
    let nameObservable: Observable<String>
    let birthdayObservable: Observable<String>
    let profileObservable: Observable<UIImage>
    
    let disposeBag = DisposeBag()
    
    init() {
        let fetchUser = BehaviorRelay<User>(value: User())
        
        FetchUser.fetchUsersRx()
            .bind(to: fetchUser)
            .disposed(by: disposeBag)
        
        nameObservable = fetchUser
            .map { $0.name }
        
        birthdayObservable = fetchUser
            .map { $0.birthday }
        
        profileObservable = fetchUser
            .map { ($0.profile ?? UIImage.init(systemName: "heart"))! }
    }
}
