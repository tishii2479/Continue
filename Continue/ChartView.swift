//
//  ChartView.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/24.
//

import UIKit
import Charts

class ChartView: CardView {
    
    let chartView = LineChartView()

    override init() {
        super.init()
        
        setChartView()
        
        reloadData()
    }
    
    func setChartView() {
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.setLabelCount(7, force: true)
        chartView.xAxis.granularity = 1
        
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        
        chartView.highlightPerTapEnabled = false
        chartView.highlightPerDragEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.legend.enabled = false
        
        self.addSubview(chartView)
        
        NSLayoutConstraint.activate([
            self.chartView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.chartView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.chartView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.chartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func reloadData() {
        let recordData: [RecordData] = RecordData.getArray(sortAscending: true)
        
        // No data
        if recordData.count == 0 { return }
        
        var dataEntries = [ChartDataEntry]()
        
        for data in recordData {
            let dataEntry = ChartDataEntry(x: Double(Calendar.current.dateComponents([.day], from: recordData[0].date!, to: data.date!).day!), y: Double(data.record))
        
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "SampleDataChart")
        
        chartDataSet.lineWidth = 3.0
        chartDataSet.circleRadius = 6.0
        chartDataSet.valueTextColor = UIColor.pink
        chartDataSet.setCircleColor(UIColor.pink)
        chartDataSet.setColor(UIColor.pink)
        chartDataSet.circleHoleColor = UIColor.pink
        chartDataSet.mode = .linear
        
        chartView.data = LineChartData(dataSet: chartDataSet)
        
        // set x axis 0-index value
        chartView.xAxis.valueFormatter = ChartXAxisFormatter(startDate: recordData[0].date!)
        
        chartView.animate(xAxisDuration: 1)
    }
    
    class ChartXAxisFormatter: NSObject, AxisValueFormatter {
        
        let dateFormatter = DateFormatter()
        var startDate:Date
         
        init(startDate: Date) {
            self.startDate = startDate
        }
     
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            let modifiedDate = Calendar.current.date(byAdding: .day, value: Int(value), to: startDate)!
            dateFormatter.dateFormat = "M/d"
            return dateFormatter.string(from: modifiedDate)
        }
    }

}
