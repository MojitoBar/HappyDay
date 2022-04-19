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
    var unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "홈"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy var chartView: BarChartView = {
        var chart = BarChartView()
        // X축 레이블 위치 조정
        chart.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        chart.doubleTapToZoomEnabled = false
        chart.leftAxis.enabled = false
        chart.rightAxis.enabled = false
        chart.backgroundColor = .white
        return chart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        navigationController?.isNavigationBarHidden = true
        setUI()
        setChart(dataPoints: months, values: unitsSold)
    }
    
    func setUI() {
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalTo(16)
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "판매량")

        // 차트 컬러
        chartDataSet.colors = [.systemBlue]
        chartDataSet.highlightEnabled = false
        
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
        
        self.view.addSubview(chartView)
        
        chartView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(100)
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(300)
        }
    }
}
