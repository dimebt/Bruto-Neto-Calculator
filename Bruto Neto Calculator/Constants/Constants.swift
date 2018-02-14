//
//  Constants.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/14/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import Foundation

struct Constants {
    static let years: [YearCell] = [
        YearCell.init(title: "2008", selected: false),
        YearCell.init(title: "2009", selected: false),
        YearCell.init(title: "2010", selected: false),
        YearCell.init(title: "2011", selected: false),
        YearCell.init(title: "2012", selected: false),
        YearCell.init(title: "2013", selected: false),
        YearCell.init(title: "2014", selected: false),
        YearCell.init(title: "2015", selected: false),
        YearCell.init(title: "2016", selected: false),
        YearCell.init(title: "2017", selected: false),
        YearCell.init(title: "2018", selected: true)
    ]
    
    static let menuItems: [String] = ["HOME",
                                      "YEAR PARAMETERS",
                                      "CHANGE CURRENCY",
                                      "GROSS / NET LAW",
                                      "PIE CHART",
                                      "SHARE RESULTS",
                                      "PRIVACY POLICY"]
    
    static let lowValueTitle = "Внесениот износ е под најниската основица за пресметка!"
    static let lowValueMessage = "Внесете нов износ за пресметка."
    static let lowValueBackLabel = "Назад"
    
    static let highValueTitle = "Внесениот износ е поголем од 12 месечни просечни плати!"
    static let highValueMessage = "Внесете нов износ за пресметка."
    static let highValueBackLabel = "Назад"
    
    static let pieChartValuesDescriptions = ["Нето износ",
                                             "Пензиско и инвалидско осигурување",
                                             "Здравствено осигурување",
                                             "Осигурување во случај на невработеност",
                                             "Дополнителен придонес за здравствo",
                                             "Персонален данок на доход од плата"]
    
    static let parametersSections = ["Стапки за пресметка на придонеси", "Даночни стапки", "Даночно ослободување"]
    
    static let section1 = "Стапки за пресметка на придонеси"
    static let section2 = "Даночни стапки"
    static let section3 = "Даночно ослободување"
    static let section4 = "Месечна просечна плата"
    
    static let section1Parameters = ["Пензиско и инвалидско осигурување", "Здравствено осигурување", "Осигурување во случај на невработеност", "Дополнителен придонес за здравствo"]
    static let section2Parameters = ["Персонален данок на доход од плата"]
    static let section3Parameters = ["Месечно лично ослободување"]
    static let section4Parameters = ["Месечна просечна плата"]
    
}
