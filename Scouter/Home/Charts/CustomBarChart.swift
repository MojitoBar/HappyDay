//
//  CustomBarChart.swift
//  Scouter
//
//  Created by judongseok on 2022/04/19.
//

import Charts
import UIKit

extension HomeViewController {
    func setBarChart(dataPoints: [String], values: [Int]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "누적 비용")

        // 차트 컬러
        chartDataSet.colors = [.primary!]
        chartDataSet.highlightEnabled = false
        
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
        
        chartBackground.addSubview(chartView)
        chartView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
            $0.bottom.equalTo(0)
        }
        
        chartView.animate(yAxisDuration: 1)
    }
}
