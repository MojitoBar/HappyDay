//
//  HomeViewController.swift
//  Scouter
//
//  Created by judongseok on 2022/04/19.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        
        viewModel.personObservable
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: PersonCell.cellId, cellType: PersonCell.self)) { index, item, cell in
                cell.name.text = item.name
                cell.phoneNumber.text = item.phoneNumber
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - ui setting
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        return tableView
    }()
    
    // MARK: - table setting
    func setTable() {
        self.view.addSubview(tableView)
        tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.cellId)
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(self.view)
        }
    }
}
