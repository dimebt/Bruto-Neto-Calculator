//
//  CollectionViewCellYear.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 12/21/17.
//  Copyright © 2017 Dimitar Stefanovski. All rights reserved.
//

import UIKit

protocol CollectionViewCellYearDelegate {
    func yearTagPressed(tag: Int)
}

class CollectionViewCellYear: UICollectionViewCell {
    
    @IBOutlet weak var UIButtonYear: UIButtonBrutoType1!
    
    @IBAction func UIButtonYearPressed(_ sender: Any) {
        delegate?.yearTagPressed(tag: UIButtonYear.tag)
    }
    
    var delegate: CollectionViewCellYearDelegate?
    
    public var titleLabelText: String! {
        didSet{
            self.UIButtonYear.setTitle(self.titleLabelText, for: UIControlState.normal)
        }
    }
    
    public var cellSelected: Bool!{
        didSet{
            switch self.cellSelected {
            case true:
                self.UIButtonYear.backgroundColor = UIColor.init(hex: ButtonColors.Background)
            case false:
                self.UIButtonYear.backgroundColor = .clear
            default:
                break
            }
        }
    }
    
    
    
    
}
