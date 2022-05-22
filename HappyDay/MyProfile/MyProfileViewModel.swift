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
    var userObservable: Observable<User>
    
    var wishFObservable: Observable<WishItem>
    var wishSObservable: Observable<WishItem>
    
    var givenItemObservable = Observable.of([UIImage.init(systemName: "star")!,
                                             UIImage.init(systemName: "star")!,
                                             UIImage.init(systemName: "star")!,
                                             UIImage.init(systemName: "star")!,
                                             UIImage.init(systemName: "star")!,
                                             UIImage.init(systemName: "star")!,
                                             UIImage.init(systemName: "star")!,
                                             UIImage.init(systemName: "star")!])
    
    let disposeBag = DisposeBag()
    
    init() {
        // MARK: - FetchUserData
        let user = BehaviorRelay<User>(value: User())
        
        FetchUser.fetchUsersRx()
            .bind(to: user)
            .disposed(by: disposeBag)
        
        userObservable = user.asObservable()
        
        // MARK: - FetchWishItemData
        let wishList = BehaviorRelay<[WishItem]>(value: [])
        
        FetchWishList.fetchWishListRx()
            .bind(to: wishList)
            .disposed(by: disposeBag)
        
        wishFObservable = wishList
            .map { $0[0] }
        
        wishSObservable = wishList
            .map { $0[1] }
    }
}
