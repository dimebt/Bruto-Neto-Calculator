//
//  UIViewPieChart.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 1/29/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UIViewPieChart: UIView {
    
    public var values: [Float] = [48006.0, 12948.0, 5251.0, 360.0, 863.0, 4506.0] {
        didSet{
            calculatePieChartParameters()
        }
    }
    public var valuesDescription: [String] = ["Нето износ",
                                              "Пензиско и инвалидско осигурување",
                                              "Здравствено осигурување",
                                              "Осигурување во случај на невработеност",
                                              "Дополнителен придонес за здравствo",
                                              "Персонален данок на доход од плата"]
    public var valuesPercents: [Float] = []
    private var valuesDegrees: [Float] = []
    private var sumValues: Float = 0.0
    private var countValues = 0
    private var pieWidth = 0
    private var pieChartCenter: CGPoint!
    private var pieRadius: CGFloat!
    private let pieScale = 0.65
    private let pieCenterOffset: Double = 10
    
    public var pieColors: [String] = ["E20038", "E2D300", "00E288", "00B1E2", "9D4CC9", "666CD6", "EDBB82", "63A375"]
    private var pieFrames: [CGRect] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        print("Pie Chart awakefromnib()")
        calculatePieChartParameters()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Pie Chart override init(frame: CGRect)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Pie Chart required init?(coder aDecoder: NSCoder)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawPieChart()
    }
    
    private func calculatePieChartParameters() {
        self.sumValues = self.values.reduce(0.0, { x, y in
            x + y
        })
        self.countValues = self.values.count
        self.valuesPercents = self.values.map { ($0 * 100.0) / self.sumValues }
        self.valuesDegrees = self.values.map { ($0 * 360.0) / self.sumValues }        
        print(self.valuesPercents)
        print(self.valuesDegrees)
       
        
        // Shuffle colors
        let numberOfElements = self.pieColors.count
        var randomNumberArray: [Int] = []
        var shuffledArray: [String] = []
        var numberExist = false
        
        for _ in 1...100 {
            let randomPosition = Int(arc4random_uniform(UInt32(numberOfElements)))
            //print(randomPosition)
            
            for number in randomNumberArray {
                if number == randomPosition {
                    numberExist = true
                    break
                } else {
                    numberExist = false
                }
            }
            
            if(!numberExist) {
                randomNumberArray.append(randomPosition)
                shuffledArray.append(self.pieColors[randomPosition])
            }
           
            
        }
        
        print(self.pieColors)
        self.pieColors = shuffledArray
        print(shuffledArray)
        //-----------------
    }
    
    private func drawPieChart() {
        
        // Some logic for pie chart frame offset
        
        // 0 - 360 degrees
        
        // 0 - 90 x=5 y=5
        // 90 - 180 x=-5 y=5
        // 180 - 270 x=-5 y=-5
        // 270 - 360 x=5 y=-5
        
        // x
        // 0     5
        // 90    0
        // 180  -5
        // 270   0
        
        // cos(angle) = 1
        // cos(angle) = 0
        // cos(angle) = -1
        // cos(angle) = 0
        // cos(angle) = 1
        
        // y
        // 0     0
        // 90    5
        // 180   0
        // 270  -5
        
        // sin(angle) = 0
        // sin(angle) = 1
        // sin(angle) = 0
        // sin(angle) = -1
        // sin(angle) = 0
        
        //#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)
        
        self.pieFrames.removeAll()
        self.pieChartCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        self.pieRadius = (self.bounds.width / 2) * CGFloat(self.pieScale)
        
        var lastPieDegrees: Float = 0
        var lastPieRadians: Double = 0
        var sumPieDegrees: Float = 0
        var sumPieRadians: Double = 0
        var pieColorIndex: Int = 0
        
        self.layer.sublayers?.removeAll()
        
        for pie in self.valuesDegrees {
            sumPieDegrees += pie
            sumPieRadians = Int(sumPieDegrees).DegreesToRadians()
            lastPieRadians = Int(lastPieDegrees).DegreesToRadians()
            //print(sumPieDegrees)
            //print(lastPieDegrees)
            let chart = CAShapeLayer()
            let chartPath = UIBezierPath()
            chartPath.move(to: self.pieChartCenter)
            chartPath.addArc(withCenter: self.pieChartCenter, radius: self.pieRadius , startAngle: CGFloat(lastPieRadians), endAngle: CGFloat(sumPieRadians), clockwise: true)
            chartPath.close()
            chart.fillColor = UIColor.init(hex: self.pieColors[pieColorIndex]).cgColor
            pieColorIndex += 1
            chart.path = chartPath.cgPath
            chart.frame = chart.frame.offsetBy(dx: CGFloat(cos((lastPieRadians) + ((sumPieRadians - lastPieRadians) / 2))  * self.pieCenterOffset), dy: CGFloat(sin((lastPieRadians) + ((sumPieRadians - lastPieRadians) / 2))  * self.pieCenterOffset))
            self.pieFrames.append((chart.path?.boundingBoxOfPath)!)
            lastPieDegrees = sumPieDegrees
            chart.shadowColor = UIColor.black.cgColor
            chart.shadowOffset = CGSize(width: 2, height: 2)
            chart.shadowRadius = 4
            chart.shadowOpacity = 0.5
            self.layer.addSublayer(chart)
        }
        
        // Adding labels to pie
        var i = 0
        for frame in self.pieFrames {
            let label = UILabel(frame: frame)
            label.text = String(self.valuesPercents[i].rounded(FloatingPointRoundingRule.up))
            i += 1
            label.font = UIFont(name: "Oswald", size: 22)
            label.textAlignment = .center
            label.textColor = UIColor.black
            label.layer.shadowColor = UIColor.black.cgColor
            label.layer.shadowOffset = CGSize(width: 2, height: 2)
            label.layer.shadowRadius = 4
            label.layer.shadowOpacity = 0.5
            label.isHidden = true
            self.addSubview(label)
        }
        
        
        
       
    }
  
}
