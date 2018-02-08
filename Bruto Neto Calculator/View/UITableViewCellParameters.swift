//
//  UITableViewCellParameters.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/5/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UITableViewCellParameters: UITableViewCell {

    @IBOutlet weak var parameterTitle: UILabel!
    @IBOutlet weak var parameterPercent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
