//
//  ViewController.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 12/20/17.
//  Copyright © 2017 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionViewYears: UICollectionView!
    
    @IBOutlet weak var buttonBruto: UIButtonBrutoType1!
    @IBOutlet weak var buttonNeto: UIButtonBrutoType1!
    
    public var years: [YearCell] = [
        YearCell.init(title: "2009", selected: false),
        YearCell.init(title: "2010", selected: false),
        YearCell.init(title: "2011", selected: false),
        YearCell.init(title: "2012", selected: false),
        YearCell.init(title: "2013", selected: false),
        YearCell.init(title: "2014", selected: false),
        YearCell.init(title: "2015", selected: false),
        YearCell.init(title: "2016", selected: false),
        YearCell.init(title: "2017", selected: true),
        YearCell.init(title: "2018", selected: false)
    ]
    
    @IBAction func brutoPressed(_ sender: Any) {
        buttonNeto.backgroundColor = UIColor.clear
    }
    @IBAction func netoPressed(_ sender: Any) {
        buttonBruto.backgroundColor = UIColor.clear
    }
    
    @IBAction func numpadPressed(_ sender: UIButton) {
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.collectionViewYears.reloadData()
            self.collectionViewYears.scrollToItem(at: IndexPath.init(row: 8, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
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
        DispatchQueue.main.async {
            self.collectionViewYears.reloadData()
            self.collectionViewYears.scrollToItem(at: IndexPath.init(row: 8, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return years.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewYears.dequeueReusableCell(withReuseIdentifier: "cellYear", for: indexPath) as! CollectionViewCellYear
        cell.titleLabelText = years[indexPath.row].title
        cell.cellSelected = years[indexPath.row].selected
        cell.UIButtonYear.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    private func setupUI() {
        self.view.setGradientBackground(colorOne: UIColor.init(hex: BackgroundColor.Dark), colorTwo: UIColor.init(hex: BackgroundColor.Light))
    }
    
}


extension ViewController: CollectionViewCellYearDelegate {
    func yearTagPressed(tag: Int) {
        var i = 0
        for _ in self.years {
            self.years[i].selected = false
            i += 1
        }
        self.years[tag].selected = true
        DispatchQueue.main.async {
            self.collectionViewYears.reloadData()
        }
    }
    
}

