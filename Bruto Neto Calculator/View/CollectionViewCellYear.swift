//
//  CollectionViewCellYear.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 12/21/17.
//  Copyright © 2017 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class CollectionViewCellYear: UICollectionViewCell {
    
    @IBOutlet weak var year: UIButton!
    
    public func addData(title: String) {        
        year.titleLabel?.text = title
    }
}
