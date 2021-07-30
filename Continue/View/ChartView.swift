//
//  ChartView.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/24.
//

import UIKit
import Charts

class ChartView: CardView {
    
    private let chartView = LineChartView()

    override init() {
        super.init()
        
        setChartView()
        
        reloadData()
    }
    
    func setChartView() {
        self.chartView.translatesAutoresizingMaskIntoConstraints = false
        
        self.chartView.xAxis.labelPosition = .bottom
        self.chartView.xAxis.drawAxisLineEnabled = false
        self.chartView.xAxis.drawGridLinesEnabled = false
        self.chartView.xAxis.granularity = 1
        
        self.chartView.leftAxis.axisMinimum = 0
        self.chartView.leftAxis.drawAxisLineEnabled = false
        self.chartView.rightAxis.enabled = false
        
        self.chartView.highlightPerTapEnabled = false
        self.chartView.highlightPerDragEnabled = false
        self.chartView.doubleTapToZoomEnabled = false
        self.chartView.pinchZoomEnabled = false
        self.chartView.legend.enabled = false
        self.chartView.noDataText = "データがありません"
        self.chartView.noDataTextColor = UIColor.text
        
        self.addSubview(self.chartView)
        
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
        let recordData: [RecordData] = RecordData.getDataArray(sortAscending: true)
        
        // No data
        if recordData.count == 0 {
            self.chartView.data = nil
            self.chartView.animate(xAxisDuration: 1)
            return
        }
        
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
        chartDataSet.valueFormatter = ChartDataFormatter()
        chartDataSet.mode = .linear
        
        self.chartView.data = LineChartData(dataSet: chartDataSet)
        
        // set x axis 0-index value
        self.chartView.xAxis.valueFormatter = ChartXAxisFormatter(startDate: recordData[0].date!)

        self.chartView.xAxis.setLabelCount(min(7, recordData.count), force: true)
        
        self.chartView.animate(xAxisDuration: 1)
    }
    
    class ChartDataFormatter: NSObject, ValueFormatter {
        
        func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
            return String(format: "%.0f", value)
        }
        
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
