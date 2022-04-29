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
import RxDataSources

class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        setRx()
    }
    
    // MARK: - ui setting
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        return tableView
    }()
    
    let dataSource = RxTableViewSectionedReloadDataSource<PersonSection>(configureCell: { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.cellId, for: indexPath) as! PersonCell
        cell.selectionStyle = .blue
        cell.phoneNumber.text = item.phoneNumber
        cell.name.text = item.name
        
        return cell
    })
    
    // MARK: - table setting
    func setTable() {
        self.view.addSubview(tableView)
        // 테이블 뷰 델리게이트 세팅
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        // 테이블 뷰 셀 세팅
        tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.cellId)
        tableView.register(PersonTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: PersonTableViewHeaderView.headerViewId)
        // 테이블 뷰 레이아웃 세팅
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(self.view)
        }
    }
    
    // MARK: - Rx Setting
    func setRx() {
        // 테이블 뷰 데이터 바인딩
        viewModel.personObservable
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let wetherTableViewHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PersonTableViewHeaderView.headerViewId) as? PersonTableViewHeaderView else {
            return UIView()
        }
        wetherTableViewHeaderView.profileImageVIew.image = UIImage(systemName: "star")
        wetherTableViewHeaderView.nameLabel.text = "주동석"
        return wetherTableViewHeaderView
    }
}
