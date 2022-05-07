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
        setRx()
    }
    
    // MARK: - ui setting
    let backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(systemName: "arrow.backward"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    let profile: UIView = {
        let profile = UIView()
        profile.layer.cornerRadius = 50
        return profile
    }()
    
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return name
    }()
    
    // MARK: - layout setting
    func setLayout() {
        self.view.addSubview(backBtn)
        self.view.addSubview(nameLabel)
        
        backBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(16)
            $0.width.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.view)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
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
