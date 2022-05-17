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
    var nameObservable: Observable<String>!
    var birthdayObservable: Observable<String>!
    var profileObservable: Observable<UIImage>!
    
    var wishFirstImg: Observable<UIImage>!
    var wishFirstContent: Observable<String>!
    var wishFirstPrice: Observable<String>!
    var wishFirstName: Observable<String>!
    var wishSecondImg: Observable<UIImage>!
    var wishSecondContent: Observable<String>!
    var wishSecondPrice: Observable<String>!
    var wishSecondName: Observable<String>!
    
    let disposeBag = DisposeBag()
    
    init() {
        fetchUser()
        fetchWishList()
    }
    
    func fetchUser() {
        let user = BehaviorRelay<User>(value: User())
        
        FetchUser.fetchUsersRx()
            .bind(to: user)
            .disposed(by: disposeBag)
        
        nameObservable = user
            .map { $0.name }
        
        birthdayObservable = user
            .map { $0.birthday }
        
        profileObservable = user
            .map { ($0.profile ?? UIImage.init(systemName: "heart"))! }
    }
    
    func fetchWishList(){
        let wishList = BehaviorRelay<[WishItem]>(value: [])
        
        FetchWishList.fetchWishListRx()
            .bind(to: wishList)
            .disposed(by: disposeBag)
        
        wishFirstName = wishList
            .map { $0[0].name }
        wishFirstImg = wishList
            .map { ($0[0].image ?? UIImage.init(systemName: "person"))! }
        wishFirstPrice = wishList
            .map { $0[0].price }
        wishFirstContent = wishList
            .map { $0[0].content }
        
        wishSecondName = wishList
            .map { $0[1].name }
        wishSecondImg = wishList
            .map { ($0[1].image ?? UIImage.init(systemName: "person"))! }
        wishSecondPrice = wishList
            .map { $0[1].price }
        wishSecondContent = wishList
            .map { $0[1].content }
    }
}
