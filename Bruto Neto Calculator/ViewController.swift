//
//  ViewController.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 12/20/17.
//  Copyright © 2017 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionViewYears: UICollectionView!
    public var years: [String] = ["2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.collectionViewYears.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {        
        // Because CALayers are not resiziable in UIView.layer snippet for auto resizing
        for layer in self.view.layer.sublayers! {
            if layer.name == "GradientLayer" {
                layer.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            }
        }

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return years.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewYears.dequeueReusableCell(withReuseIdentifier: "cellYear", for: indexPath) as! CollectionViewCellYear
        cell.titleLabelText = years[indexPath.row]
        return cell
    }
    
    private func setupUI() {
        self.view.setGradientBackground(colorOne: UIColor.init(hex: BackgroundColor.Dark), colorTwo: UIColor.init(hex: BackgroundColor.Light))
    }

}

