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

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    let viewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setTable()
        setSearchBar()
        setRx()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - ui setting
    let searchBar: UITextField = {
        let search = UITextField()
        search.placeholder = "검색"
        search.text = nil
        search.layer.cornerRadius = 10
        search.layer.borderWidth = 1
        search.layer.borderColor = UIColor.lightGray.cgColor
        return search
    }()
    
    let header: UIView = {
        let view = UIView()
        return view
    }()
    
    let addButton: UIButton  = {
        let btn = UIButton()
        btn.setImage(UIImage.init(systemName: "plus"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    let profile: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.init(systemName: "star")
        image.tintColor = .black
        return image
    }()
    
    let userName: UILabel = {
        let name = UILabel()
        name.text = "홍길동"
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return name
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Happy Day"
        title.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        title.textColor = .black
        return title
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    let dataSource = RxTableViewSectionedReloadDataSource<PersonSection>(configureCell: { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.cellId, for: indexPath) as! PersonCell
        cell.selectionStyle = .none
//        cell.phoneNumber.text = item.phoneNumber
        cell.name.text = item.name
        return cell
    })
    
    // MARK: - layout setting
    func setLayout() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(header)
        self.view.addSubview(addButton)
        self.view.addSubview(searchBar)
        header.addSubview(profile)
        header.addSubview(userName)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.equalTo(20)
        }
        searchBar.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(35)
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
        header.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(0)
            $0.height.equalTo(70)
        }
        profile.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.top.equalTo(0)
            $0.width.height.equalTo(50)
        }
        userName.snp.makeConstraints {
            $0.leading.equalTo(profile.snp.trailing).offset(10)
            $0.top.equalTo(10)
        }
        addButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.trailing.equalTo(-10)
            $0.width.height.equalTo(40)
        }
    }
    
    func setSearchBar() {
        let leftimage = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        leftimage.image = UIImage(systemName: "magnifyingglass")
        leftimage.contentMode = .scaleAspectFit
        leftimage.tintColor = .lightGray
        searchBar.leftView = leftimage
        searchBar.leftViewMode = .always
        leftimage.widthAnchor.constraint(equalToConstant: 30).isActive = true
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
        tableView.sectionHeaderTopPadding = 5
        // 테이블 뷰 셀 세팅
        tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.cellId)
        tableView.register(PersonTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: PersonTableViewHeaderView.headerViewId)
        // 테이블 뷰 레이아웃 세팅
        tableView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.bottom.equalTo(self.view)
        }
    }
    
    // MARK: - Rx Setting
    func setRx() {
        // 테이블 뷰 데이터 바인딩
        viewModel.personObservable
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // SearchBar Text 변경 감지
        searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] changedText in
                // 입력받은 텍스트가 포함된 persons를 filterPersons에 적용
                if self?.searchBar.text! != "" {
                    self?.viewModel.filterPersons = self?.viewModel.persons.filter { $0.name.contains(changedText) } ?? []
                    // filterPersons로 personObservable 변경
                    let arrToDic = self?.viewModel.arrToDic(persons: (self?.viewModel.filterPersons)!)
                    let dicToObservable = self?.viewModel.dicToObserbable(dic: arrToDic!)
                    self?.viewModel.personObservable.accept(dicToObservable!)
                }
                else{
                    let arrToDic = self?.viewModel.arrToDic(persons: (self?.viewModel.persons)!)
                    let dicToObservable = self?.viewModel.dicToObserbable(dic: arrToDic!)
                    self?.viewModel.personObservable.accept(dicToObservable!)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Keyboard End Editing
    // 터치가 발생할때 핸들러 캐치
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(35)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 페이지 이동
        let detail = DetailViewColler()
        detail.viewModel.info.accept(Person(name: self.viewModel.personObservable.value[indexPath.section].items[indexPath.row].name, phoneNumber: self.viewModel.personObservable.value[indexPath.section].items[indexPath.row].phoneNumber))
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
