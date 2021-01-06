//
//  ViewController.swift
//  LineChartSample
//
//  Created by Kyaw Kyaw Khing on 06/01/2021.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {

    @IBOutlet var chartView: LineChartView!
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderY: UISlider!
    @IBOutlet var sliderTextX: UITextField!
    @IBOutlet var sliderTextY: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Line Chart 1"

        chartView.delegate = self

        chartView.chartDescription?.enabled = false
        
        //we can change actions here
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false

        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 10, label: "Index 10")
        llXAxis.lineWidth = 4
        llXAxis.lineDashLengths = [10, 10, 0]
        llXAxis.labelPosition = .bottomRight
        llXAxis.valueFont = .systemFont(ofSize: 10)

        chartView.xAxis.gridLineDashLengths = [10, 10]
        chartView.xAxis.gridLineDashPhase = 0

        //we can open if we want to show limit line
//        let ll1 = ChartLimitLine(limit: 150, label: "Upper Limit")
//        ll1.lineWidth = 4
//        ll1.lineDashLengths = [5, 5]
//        ll1.labelPosition = .topRight
//        ll1.valueFont = .systemFont(ofSize: 10)
//
//        let ll2 = ChartLimitLine(limit: -30, label: "Lower Limit")
//        ll2.lineWidth = 4
//        ll2.lineDashLengths = [5,5]
//        ll2.labelPosition = .bottomRight
//        ll2.valueFont = .systemFont(ofSize: 10)

        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
//        leftAxis.addLimitLine(ll1)//we can open if we want to show limit line
//        leftAxis.addLimitLine(ll2)
//        leftAxis.axisMaximum = 200//we can open if we want to limit maximum
        leftAxis.axisMinimum = 0
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true

        chartView.rightAxis.enabled = false

        //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
        //[_chartView.viewPortHandler setMaximumScaleX: 2.f];

        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker
//        let aml = chartView.xAxis.lable
            chartView.xAxis.setLabelCount(10, force: true)
        let formato:BarChartFormatter = BarChartFormatter()
        let xaxis:XAxis = XAxis()
        (0..<10).map { (i)  in
            formato.stringForValue(Double(i), axis: xaxis)
            xaxis.valueFormatter = formato
            chartView.xAxis.valueFormatter = xaxis.valueFormatter
        }
        
        chartView.legend.form = .line

        sliderX.value = 45
        sliderY.value = 100
        updateChartData()

        chartView.animate(xAxisDuration: 2.5)
    }

     func updateChartData() {
//        if self.shouldHideData {
//            chartView.data = nil
//            return
//        }

        self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
    }

    func setDataCount(_ count: Int, range: UInt32) {
        
            let infoList = (0..<10).map { (i) -> InfoData in
                let val = Double(arc4random_uniform(100) + 3)*3
                let cde =  InfoData(xValue: Double(i), yValue: val)
                return cde
            }
            let values = infoList.map { (data) -> ChartDataEntry in
                let cde =  ChartDataEntry(x: data.xValue, y: data.yValue, icon: nil)
                return cde
            }

        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        set1.drawIconsEnabled = false
        setup(set1)

        let value = ChartDataEntry(x: Double(6), y: 6)
//        set1.addEntryOrdered(value)
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        set1.fillAlpha = 1
//        set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set1.fill = Fill.init(linearGradient: gradient, angle: 90)
        set1.drawFilledEnabled = true

        let data = LineChartData(dataSet: set1)

        chartView.data = data
    }

    private func setup(_ dataSet: LineChartDataSet) {
//        if dataSet.isDrawLineWithGradientEnabled {
//        if dataSet.isDrawFilledEnabled {
//            dataSet.lineDashLengths = nil
//            dataSet.highlightLineDashLengths = nil
//            dataSet.setColors(.black, .red, .white)
//            dataSet.setCircleColor(.black)
////            dataSet.gradientPositions = [0, 40, 100]
//            dataSet.lineWidth = 1
//            dataSet.circleRadius = 3
//            dataSet.drawCircleHoleEnabled = false
//            dataSet.valueFont = .systemFont(ofSize: 9)
//            dataSet.formLineDashLengths = nil
//            dataSet.formLineWidth = 1
//            dataSet.formSize = 15
//        } else {
            dataSet.lineDashLengths = [5, 2.5]
            dataSet.highlightLineDashLengths = [5, 2.5]
            dataSet.setColor(.black)
            dataSet.setCircleColor(.black)
//            dataSet.gradientPositions = nil
            dataSet.lineWidth = 1
            dataSet.circleRadius = 3
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = [5, 2.5]
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
//        }
    }

}
struct InfoData {
    var xValue:Double = 0.0
    var yValue:Double = 0.0
}
