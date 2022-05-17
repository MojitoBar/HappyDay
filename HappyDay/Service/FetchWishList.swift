//
//  FetchWishList.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/16.
//

import Foundation

import UIKit
import RxSwift
import RxRelay

class FetchWishList {
    static func fetchWishListRx() -> Observable<[WishItem]> {
        return Observable.create() { emitter in
            emitter.onNext(dummyWishItems)
            emitter.onCompleted()
            
            return Disposables.create()
        }
    }
}
