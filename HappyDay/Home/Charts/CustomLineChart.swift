//
//  CustomPieChart.swift
//  Scouter
//
//  Created by judongseok on 2022/04/19.
//

import Charts
import UIKit

extension HomeViewController {
    func setLineChart(dataPoints: [String], values:[Int]) {
        chartBackground.addSubview(lineChartView)
        lineChartView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(100)
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(300)
        }
        
        // 엔트리 설정
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        // 데이터 세팅
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "DataSet 1")
        
        lineChartDataSet.drawFilledEnabled = true
        lineChartDataSet.highlightEnabled = false
        lineChartDataSet.colors = [.primary!]
        lineChartDataSet.circleRadius = 5
        lineChartDataSet.circleHoleRadius = 5
        lineChartDataSet.valueFont = .systemFont(ofSize: 0)
        lineChartDataSet.circleColors = [.primary!]
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.fillColor = .primary!
        lineChartDataSet.fillAlpha = 0.25
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        lineChartData.setValueFormatter(formatter)
        
        lineChartView.data = lineChartData
        lineChartView.animate(xAxisDuration: 0.7, yAxisDuration: 1)
    }
}
