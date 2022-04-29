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
        setLayout()
        setTable()
        setRx()
    }
    
    // MARK: - ui setting
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Happy Day"
        title.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        title.textColor = .black
        return title
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
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
    
    // MARK: - layout setting
    func setLayout() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.equalTo(20)
        }
    }
    
    // MARK: - table setting
    func setTable() {
        self.view.addSubview(tableView)
        // 테이블 뷰 델리게이트 세팅
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        // 테이블 헤더 세팅
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        tableView.sectionHeaderTopPadding = 1
        // 테이블 뷰 셀 세팅
        tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.cellId)
        tableView.register(PersonTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: PersonTableViewHeaderView.headerViewId)
        // 테이블 뷰 레이아웃 세팅
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalTo(self.view)
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
        return CGFloat(35)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

    
// Header
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let wetherTableViewHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PersonTableViewHeaderView.headerViewId) as? PersonTableViewHeaderView else {
//            return UIView()
//        }
//        wetherTableViewHeaderView.profileImageVIew.image = UIImage(systemName: "star")
//        wetherTableViewHeaderView.nameLabel.text = "주동석"
//        return wetherTableViewHeaderView
//    }
}
