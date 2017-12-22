//
//  CollectionViewCellYear.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 12/21/17.
//  Copyright © 2017 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class CollectionViewCellYear: UICollectionViewCell {
    
    @IBOutlet weak var UIButtonYear: UIButton!    
    
    public var titleLabelText: String! {
        didSet{
            self.UIButtonYear.setTitle(self.titleLabelText, for: UIControlState.normal)
        }
    }
}
