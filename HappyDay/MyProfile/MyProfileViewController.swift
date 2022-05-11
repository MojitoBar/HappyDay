//
//  MyProfileViewController.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/12.
//

import UIKit
import RxSwift

class MyProfileViewController: UIViewController, CustomViewController {
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ui setting
    let titleLabel: UILabel = {
        let title = UILabel()
        return title
    }()
    
    // MARK: - layout setting
    func setLayout() {
        self.view.addSubview(titleLabel)
    }
    
    // MARK: - Rx Setting
    func setRx() {
        
    }
}
