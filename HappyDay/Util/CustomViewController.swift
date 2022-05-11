//
//  CustomViewController.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/12.
//

import UIKit
import RxSwift

protocol CustomViewController {
    func setLayout()
    func setRx()
}

extension CustomViewController {
    var disposeBag: DisposeBag {
        return DisposeBag()
    }
}
