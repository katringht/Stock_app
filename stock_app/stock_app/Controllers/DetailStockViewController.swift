//
//  DetailStockViewController.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 08.08.2021.
//

import UIKit
import Charts

class DetailStockViewController: UIViewController, ChartViewDelegate {

    @IBOutlet var chartView: LineChartView!
    @IBOutlet var symbolStock: UILabel!
    @IBOutlet var longNameStock: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.rightAxis.enabled = false
        chartView.xAxis.enabled = false
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        chartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
    

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Line Chart
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData() {
        let set = LineChartDataSet(entries: entryValue, label: "Regular Market Day Range")
        set.drawCirclesEnabled = false
        set.mode = .cubicBezier
        set.lineWidth = 5
        set.fillColor = .black
        set.fillAlpha = 0.4
        set.drawFilledEnabled = true
        set.setColor(.black)
        
        let set2 = LineChartDataSet(entries: entryValue2, label: "Fifty Two Week Range")
        set2.drawCirclesEnabled = false
        set2.mode = .cubicBezier
        set2.lineWidth = 5
        set2.fillColor = .gray
        set2.fillAlpha = 0.2
        set2.drawFilledEnabled = true
        set2.setColor(.gray)
        
        let data = LineChartData()
        data.append(set)
        data.append(set2)
        chartView.data = data
    }
    
    let entryValue: [ChartDataEntry] = [ ChartDataEntry(x: 0, y: 15.5), ChartDataEntry(x: 1 , y: 17.4)]
    
    let entryValue2: [ChartDataEntry] = [ChartDataEntry(x: 0, y: 4.3), ChartDataEntry(x: 1 , y: 38.5)]
}
