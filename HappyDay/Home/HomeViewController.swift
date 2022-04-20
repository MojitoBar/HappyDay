//
//  HomeViewController.swift
//  Scouter
//
//  Created by judongseok on 2022/04/19.
//

import UIKit
import SnapKit
import Charts

class HomeViewController: UIViewController {
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var unitsSold = [5, 8, 10, 10, 16, 20, 20, 27, 27, 27, 30, 35]
    
    // MARK: - lazy variables
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "HappyDay"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .primary
        return label
    }()
    
    lazy var chartBackground: UIView = {
        var back = UIView()
        back.layer.masksToBounds = false
        back.backgroundColor = .white
        back.layer.cornerRadius = 8
        
        back.layer.shadowColor = UIColor.black.cgColor
        back.layer.shadowOpacity = 0.06
        back.layer.shadowRadius = 2
        back.layer.shadowOffset = CGSize(width: 0, height: 2)
        back.layer.shadowPath = nil

        return back
    }()
    
    lazy var dropdown: UILabel = {
        let label = UILabel()
        label.text = "바 차트"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    // MARK: - chart views
    lazy var chartView: BarChartView = {
        var chart = BarChartView()
        // X축 레이블 위치 조정
        chart.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        chart.doubleTapToZoomEnabled = false
        chart.leftAxis.enabled = false
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawLabelsEnabled = false
        chart.legend.enabled = false

        return chart
    }()
    
    lazy var pieChartView: PieChartView = {
        var chart = PieChartView()
        return chart
    }()
    
    lazy var lineChartView: LineChartView = {
        var chart = LineChartView()
        chart.doubleTapToZoomEnabled = true
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        return chart
    }()
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        navigationController?.isNavigationBarHidden = true
        setUI()
        setLineChart(dataPoints: months, values: unitsSold)
//        setBarChart(dataPoints: months, values: unitsSold)
//        setPieChart(dataPoints: months, values: unitsSold)
    }
    
    // MARK: - ui setting
    func setUI() {
        self.view.addSubview(titleLabel)
        self.view .addSubview(dropdown)
        self.view.addSubview(chartBackground)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalTo(16)
        }
        dropdown.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(16)
        }
        
        chartBackground.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(100)
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(300)
        }
    }
}
