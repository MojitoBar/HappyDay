//
//  DetailViewController.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/06.
//

import UIKit
import RxSwift

class DetailViewColler: UIViewController {
    static let identifier = "DetailViewColler"
    
    public let viewModel = DetailViewModel()
    var disposeBag = DisposeBag()
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        setCards()
        setRx()
    }
    
    // MARK: - ui setting
    let backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(systemName: "arrow.backward"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    let addBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(systemName: "plus"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    let profile: UIView = {
        let profile = UIView()
        profile.layer.cornerRadius = 50
        profile.backgroundColor = .blue
        return profile
    }()
    
    let spendLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "보냄"
        return label
    }()
    
    let receiveLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "받음"
        return label
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return name
    }()
    
    let line: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - layout setting
    func setLayout() {
        self.view.addSubview(backBtn)
        self.view.addSubview(nameLabel)
        self.view.addSubview(addBtn)
        self.view.addSubview(profile)
        self.view.addSubview(receiveLabel)
        self.view.addSubview(spendLabel)
        self.view.addSubview(line)
        
        addBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(-16)
            $0.width.equalTo(30)
        }
        
        backBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(16)
            $0.width.equalTo(30)
        }
        
        profile.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            $0.centerX.equalTo(self.view)
            $0.width.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.view)
            $0.top.equalTo(profile.snp.bottom).offset(20)
        }
        
        spendLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(30)
            $0.leading.equalTo(20)
        }
        
        receiveLabel.snp.makeConstraints {
            $0.top.equalTo(spendLabel.snp.bottom).offset(10)
            $0.leading.equalTo(20)
        }
        
        line.snp.makeConstraints {
            $0.top.equalTo(receiveLabel.snp.bottom).offset(10)
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(1)
        }
    }
    
    func setCards() {
        for card in viewModel.cards {
            self.view.addSubview(card)
            card.snp.makeConstraints {
                $0.width.equalTo(200)
                $0.height.equalTo(100)
                $0.top.equalTo(line.snp.bottom).offset(20)
                $0.trailing.equalTo(-20)
            }
        }
    }
    
    // MARK: - Rx Setting
    func setRx() {
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.info
            .bind { [weak self] person in
                self?.nameLabel.text = person.name
            }
            .disposed(by: disposeBag)
    }
}
