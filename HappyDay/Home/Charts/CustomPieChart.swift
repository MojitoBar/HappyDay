//
//  CustomPieChart.swift
//  Scouter
//
//  Created by judongseok on 2022/04/19.
//

import Charts
import UIKit

extension HomeViewController {
    func setPieChart(dataPoints: [String], values:[Int]) {
        self.view.addSubview(pieChartView)
        pieChartView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(100)
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(300)
        }
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: Double(values[i]), label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "설명")
        
        pieChartDataSet.colors = [.primary!]
        pieChartDataSet.highlightEnabled = false
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        pieChartView.data = pieChartData
    }
}
