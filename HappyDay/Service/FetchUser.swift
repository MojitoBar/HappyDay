//
//  FetchUser.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/16.
//

import UIKit
import RxSwift
import RxRelay

class FetchUser {
    static func fetchUsersRx() -> Observable<User> {
        return Observable.create() { emitter in
            emitter.onNext(DummyUser)
            emitter.onCompleted()
            
            return Disposables.create()
        }
    }
}
