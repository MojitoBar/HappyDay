//
//  MyProfileViewController.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/12.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

class MyProfileViewController: UIViewController, CustomViewController {
    let viewModel = MyProfileViewModel()
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setScrollView()
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
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "홍길동"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "12월 3일"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let wishLabel: UILabel = {
        let label = UILabel()
        label.text = "위시리스트"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let givenLabel: UILabel = {
        let label = UILabel()
        label.text = "그만 받고싶어요"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let givenGiftScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = true
        return scroll
    }()
    
    let wishCardContainView: UIView = {
        let view = UIView()
        return view
    }()
    
    var wishCards: [WishItemView] = [
        WishItemView(),
        WishItemView()
    ]
    
    // MARK: - Rx Setting
    func setRx() {
        // 유저 이름
        viewModel.nameObservable
            .bind(to: name.rx.text)
            .disposed(by: disposeBag)
        // 유저 생일
        viewModel.birthdayObservable
            .bind(to: birthdayLabel.rx.text)
            .disposed(by: disposeBag)
        // 유저 프로필
        viewModel.profileObservable
            .bind(to: profile.rx.image)
            .disposed(by: disposeBag)
        // 첫번째 위시리스트
        viewModel.wishFirstContent
            .bind(to: wishCards[0].productContent.rx.text)
            .disposed(by: disposeBag)
        viewModel.wishFirstImg
            .bind(to: wishCards[0].productImage.rx.image)
            .disposed(by: disposeBag)
        viewModel.wishFirstName
            .bind(to: wishCards[0].productName.rx.text)
            .disposed(by: disposeBag)
        viewModel.wishFirstPrice
            .bind(to: wishCards[0].productPrice.rx.text)
            .disposed(by: disposeBag)
        // 두번째 위시리스트
        viewModel.wishSecondContent
            .bind(to: wishCards[1].productContent.rx.text)
            .disposed(by: disposeBag)
        viewModel.wishSecondImg
            .bind(to: wishCards[1].productImage.rx.image)
            .disposed(by: disposeBag)
        viewModel.wishSecondName
            .bind(to: wishCards[1].productName.rx.text)
            .disposed(by: disposeBag)
        viewModel.wishSecondPrice
            .bind(to: wishCards[1].productPrice.rx.text)
            .disposed(by: disposeBag)
    }
}
