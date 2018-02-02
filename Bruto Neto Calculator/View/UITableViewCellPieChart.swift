//
//  UITableViewCellPieChart.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/2/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UITableViewCellPieChart: UITableViewCell {

    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
