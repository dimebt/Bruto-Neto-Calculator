//
//  UIViewControllerParameters.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 1/14/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UIViewControllerPieChart: UIViewController {

    @IBOutlet weak var sideMenuView: UIViewSideMenu!
    private var isSideMenuVisible = false
    private let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    private let blurView = UIVisualEffectView()
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pieChart: UIViewPieChart!
    
    @IBAction func sideMenuShow(_ sender: Any) {
        self.sideMenuShow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = true;
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewControllerPieChart.sideMenuHide), name: NSNotification.Name("sideMenuHide"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewControllerPieChart.showHome), name: NSNotification.Name("showHome"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewControllerPieChart.showParameters), name: NSNotification.Name("showParameters"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewControllerPieChart.showCurrency), name: NSNotification.Name("showCurrency"), object: nil)
        
        //side menu setup
        let swipeMenu = UISwipeGestureRecognizer(target: self, action: #selector(UIViewControllerPieChart.swipeMenuHandler))
        swipeMenu.direction = .left
        self.sideMenuView.addGestureRecognizer(swipeMenu)
        let tapSideMenu = UITapGestureRecognizer(target: self, action: #selector(UIViewControllerPieChart.tapSideMenuHandler))
        self.blurView.addGestureRecognizer(tapSideMenu)
        
        // load calculation results
        let calculationResults = CalculationResults.shared.getParameters()
        self.pieChart.values = [
            Float(calculationResults.neto),
            Float(calculationResults.pensionAndDisabilityInsurance),
            Float(calculationResults.healthInsuranceFund),
            Float(calculationResults.unemploymentInsuranceFund),
            Float(calculationResults.additionalHealthInsuranceAndPersonalInjuryInsurance),
            Float(calculationResults.personalIncomeTax),
        ]
        
        
    }
    
    @objc private func swipeMenuHandler(gesture: UISwipeGestureRecognizer) {
        sideMenuHide()
    }
    
    @objc private func tapSideMenuHandler(gesture: UITapGestureRecognizer) {
        sideMenuHide()
    }
    
    @objc private func showHome() {
        performSegue(withIdentifier: "segueHome", sender: self)
    }
    
    @objc private func showParameters() {
        performSegue(withIdentifier: "segueParameters", sender: self)
    }
    
    @objc private func showCurrency() {
        performSegue(withIdentifier: "segueCurrency", sender: self)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)        
        // Because CALayers are not resiziable in UIView.layer snippet for auto resizing
        for layer in self.view.layer.sublayers! {
            if layer.name == "GradientLayer" {
                layer.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            }
        }
        
        // hide side menu
        self.sideMenuLeadingConstraint.constant = -0.6 * size.width
        
        //remove blur view
        UIView.animate(withDuration: 0.5, animations: {
            self.blurView.effect = .none
        }) { (isFinished) in
            self.blurView.removeFromSuperview()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //self.view.translatesAutoresizingMaskIntoConstraints = true;
        //self.blurView.frame = self.view.bounds
        for layer in self.view.layer.sublayers! {
            if layer.name == "GradientLayer" {
                layer.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.sideMenuLeadingConstraint.constant = -0.6 * self.view.bounds.width
        setupUI()
    }
    
    private func setupUI() {
        self.view.setGradientBackground(colorOne: UIColor.init(hex: BackgroundColor.Dark), colorTwo: UIColor.init(hex: BackgroundColor.Light))
    }
    
    private func sideMenuShow() {
        self.blurView.frame = self.view.bounds
        self.view.insertSubview(blurView, belowSubview: self.sideMenuView)
        
        self.isSideMenuVisible = true
        let menuWidth = self.view.frame.width * 0.6
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.sideMenuLeadingConstraint.constant += menuWidth
            self.blurView.effect = self.blurEffect
            self.view.layoutIfNeeded()
        }) { (isFinished) in
            
        }
    }
    
    @objc private func sideMenuHide() {
        self.isSideMenuVisible = false
        let menuWidth = self.view.frame.width * 0.6
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.sideMenuLeadingConstraint.constant = -menuWidth
            self.blurView.effect = .none
            self.view.layoutIfNeeded()
        }) { (isFinished) in
            self.blurView.removeFromSuperview()
        }
    }
   

}



extension UIViewControllerPieChart: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pieChart.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCellPieChart
        cell.backgroundColor = .clear
        
        let numberFormater = NumberFormatter()
        numberFormater.allowsFloats = true
        numberFormater.alwaysShowsDecimalSeparator = false
        numberFormater.decimalSeparator = "."
        numberFormater.maximumFractionDigits = 1
        numberFormater.minimumIntegerDigits = 1
        cell.percent.text = "\(String(describing: numberFormater.string(from: NSNumber(value: self.pieChart.valuesPercents[indexPath.row]))!)) %"
        
        cell.title.text = self.pieChart.valuesDescription[indexPath.row]
        cell.colorView.backgroundColor = UIColor.init(hex: self.pieChart.pieColors[indexPath.row])
       
        return cell
    }
    
    
}
