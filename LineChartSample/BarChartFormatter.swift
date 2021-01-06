//
//  BarChartFormatter.swift
//  LineChartSample
//
//  Created by Kyaw Kyaw Khing on 06/01/2021.
//
import UIKit
import Foundation
import Charts

@objc(BarChartFormatter)
public class BarChartFormatter: NSObject, IAxisValueFormatter{

var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]


    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {

    return months[Int(value)]
}
}
