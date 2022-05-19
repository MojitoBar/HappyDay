//
//  MyProfileView.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/18.
//

import UIKit

extension MyProfileViewController {
    // MARK: - layout setting
    func setLayout() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(profile)
        self.view.addSubview(name)
        self.view.addSubview(birthdayLabel)
        self.view.addSubview(wishLabel)
        self.view.addSubview(givenLabel)
        self.view.addSubview(wishCardContainView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(20)
        }
        profile.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(20)
            $0.width.height.equalTo(80)
        }
        name.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.equalTo(profile.snp.trailing).offset(20)
        }
        birthdayLabel.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom).offset(10)
            $0.leading.equalTo(profile.snp.trailing).offset(20)
        }
        wishLabel.snp.makeConstraints {
            $0.top.equalTo(profile.snp.bottom).offset(30)
            $0.leading.equalTo(20)
        }
        wishCardContainView.snp.makeConstraints {
            $0.top.equalTo(wishLabel.snp.bottom).offset(10)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
            $0.height.equalTo(dummyWishItems.count * 100)
        }
        for i in 0..<wishCards.count {
            wishCardContainView.addSubview(wishCards[i])
            wishCards[i].snp.makeConstraints {
                $0.top.equalTo(i * 100)
                $0.leading.equalTo(0)
                $0.trailing.equalTo(0)
            }
        }
        givenLabel.snp.makeConstraints {
            $0.top.equalTo(wishCardContainView.snp.bottom)
            $0.leading.equalTo(20)
        }
    }
    
    // MARK: - CollectionView Setting
    func setTableView() {
        self.view.addSubview(givenGiftCollectionView)
        
        givenGiftCollectionView.snp.makeConstraints {
            $0.top.equalTo(givenLabel.snp.bottom).offset(10)
            $0.leading.equalTo(0)
            $0.height.equalTo(100)
            $0.width.equalTo(self.view.snp.width)
        }
    }
}
