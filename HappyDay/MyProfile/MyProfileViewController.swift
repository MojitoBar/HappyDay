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
        
        setLayout()
        setRx()
    }
    
    // MARK: - ui setting
    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        title.text = "HBD TO YOU"
        title.textColor = .black
        return title
    }()
    
    let profile: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(systemName: "star")
        img.backgroundColor = .lightGray
        img.layer.cornerRadius = 30
        return img
    }()
    
    // MARK: - layout setting
    func setLayout() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(profile)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(20)
        }
        profile.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(20)
            $0.width.height.equalTo(80)
        }
    }
    
    // MARK: - Rx Setting
    func setRx() {
        
    }
}
