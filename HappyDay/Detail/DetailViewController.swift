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
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setLayout()
        setRx()
    }
    
    let backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(systemName: "arrow.backward"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    // MARK: - layout setting
    func setLayout() {
        self.view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(16)
            $0.width.equalTo(30)
        }
    }
    
    // MARK: - Rx Setting
    func setRx() {
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
