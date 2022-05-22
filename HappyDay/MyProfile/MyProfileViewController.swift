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
import RxCocoa
import RxDataSources

class MyProfileViewController: UIViewController, CustomViewController {
    let viewModel = MyProfileViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - view life cycle
    override func loadView() {
        super.loadView()
        setLayout()
        setTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    let givenGiftCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(GivenItemCell.self, forCellWithReuseIdentifier: GivenItemCell.CellId)
        collection.backgroundColor = .blue
        return collection
    }()
    
    let wishCardContainView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - need refactoring
    var wishCards: [WishItemView] = [
        WishItemView(),
        WishItemView()
    ]
    
    // MARK: - Rx Setting
    func setRx() {
        viewModel.userObservable
            .subscribe(onNext: { [weak self] user in
                self?.birthdayLabel.text! = user.birthday
                self?.name.text! = user.name
                self?.profile.image! = user.profile ?? UIImage(systemName: "person")!
        })
        .disposed(by: disposeBag)
        
        viewModel.wishFObservable
            .subscribe(onNext: { [weak self] wish in
                self?.wishCards[0].productContent.text = wish.content
                self?.wishCards[0].productImage.image = wish.image
                self?.wishCards[0].productName.text = wish.name
                self?.wishCards[0].productPrice.text = wish.price
            })
            .disposed(by: disposeBag)
        
        viewModel.wishSObservable
            .subscribe(onNext: { [weak self] wish in
                self?.wishCards[1].productContent.text = wish.content
                self?.wishCards[1].productImage.image = wish.image
                self?.wishCards[1].productName.text = wish.name
                self?.wishCards[1].productPrice.text = wish.price
            })
            .disposed(by: disposeBag)
        
        // GivenItem CollectionView
        viewModel.givenItemObservable
            .debug()
            .bind(to: givenGiftCollectionView.rx.items(cellIdentifier: GivenItemCell.CellId, cellType: GivenItemCell.self)) { indexPath, item, cell in
                cell.cellImage.image = item
            }
            .disposed(by: disposeBag)
    }
}
