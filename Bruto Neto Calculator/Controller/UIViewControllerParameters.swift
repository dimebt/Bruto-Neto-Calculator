//
//  UIViewControllerPieChart.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 1/24/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UIViewControllerParameters: UIViewController {
    
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuView: UIViewSideMenu!    
    private var isSideMenuVisible = false
    private let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    private let blurView = UIVisualEffectView()
    @IBOutlet weak var collectionViewYears: UICollectionView!
    @IBOutlet weak var tableViewParameters: UITableView!
    
    public var years: [YearCell] = Constants.years
    
    private var parametersSections: [String] = Constants.parametersSections
    struct Parameters {
        var section: String
        var parameters: [String]
    }
    private var parameters: [Parameters] = []
    private var parametersSelected: [Parameters] = []
    
    @IBAction func sideMenuShow(_ sender: Any) {
        self.sideMenuShow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewControllerParameters.sideMenuHide), name: NSNotification.Name("sideMenuHide"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewControllerParameters.showPieChart), name: NSNotification.Name("showPieChart"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewControllerParameters.showHome), name: NSNotification.Name("showHome"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewControllerParameters.showCurrency), name: NSNotification.Name("showCurrency"), object: nil)
        
        //side menu setup
        let swipeMenu = UISwipeGestureRecognizer(target: self, action: #selector(UIViewControllerParameters.swipeMenuHandler))
        swipeMenu.direction = .left
        self.sideMenuView.addGestureRecognizer(swipeMenu)
        let tapSideMenu = UITapGestureRecognizer(target: self, action: #selector(UIViewControllerParameters.tapSideMenuHandler))
        self.blurView.addGestureRecognizer(tapSideMenu)
        
        self.parameters = [
            Parameters(section: Constants.section1, parameters: Constants.section1Parameters),
            Parameters(section: Constants.section2, parameters: Constants.section2Parameters),
            Parameters(section: Constants.section3, parameters: Constants.section3Parameters),
            Parameters(section: Constants.section4, parameters: Constants.section4Parameters)
        ]
        
        self.parametersSelected.removeAll()
        self.setYearParameters(indexPath: self.years.count - 1)
        
    }
    
    @objc private func swipeMenuHandler(gesture: UISwipeGestureRecognizer) {
        sideMenuHide()
    }
    
    @objc private func tapSideMenuHandler(gesture: UITapGestureRecognizer) {
        sideMenuHide()
    }
    
    
    @objc private func showPieChart() {
        performSegue(withIdentifier: "seguePieChart", sender: self)
    }
    
    @objc private func showHome() {
        performSegue(withIdentifier: "segueHome", sender: self)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.collectionViewYears.scrollToItem(at: IndexPath.init(row: self.years.count - 1, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
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
    
    
    private func setYearParameters(indexPath: Int) {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        numberFormater.decimalSeparator = ","
        numberFormater.maximumFractionDigits = 2
        numberFormater.alwaysShowsDecimalSeparator = false
        numberFormater.groupingSeparator = " "
        
        
        
        
        let year = Int(self.years[indexPath].title)
        for parameters in YearParameters.parameters {
            if (parameters.year == year) {
                self.parametersSelected.removeAll()
                self.parametersSelected.append(Parameters(section: Constants.section1, parameters:
                    ["\(String(parameters.pensionAndDisabilityInsuranceRate * 100)) %",
                     "\(String(parameters.healthInsuranceFundRate * 100)) %",
                     "\(String(parameters.unemploymentInsuranceFundRate * 100)) %",
                     "\(String(parameters.additionalHealthInsuranceAndPersonalInjuryInsuranceRate * 100)) %" ]))
                self.parametersSelected.append(Parameters(section: Constants.section2, parameters:
                    ["\(String(parameters.personalIncomeTaxRate * 100)) %"
                    ]))
                self.parametersSelected.append(Parameters(section: Constants.section3, parameters:
                    ["\(String(describing: numberFormater.string(from: NSNumber(value: parameters.personalIncomeTaxExemptionPerMonth * ( 1 / CurrencySelector.sharedInstance.getCurrency().rate)))!)) \(CurrencySelector.sharedInstance.getCurrency().symbol)"
                    ]))
                self.parametersSelected.append(Parameters(section: Constants.section4, parameters:
                    ["\(String(describing: numberFormater.string(from: NSNumber(value: parameters.averageSalary * ( 1 / CurrencySelector.sharedInstance.getCurrency().rate)))!)) \(CurrencySelector.sharedInstance.getCurrency().symbol)"
                    ]))
                DispatchQueue.main.async {
                    self.tableViewParameters.reloadData()
                }
                
            }
        }
    }

}


extension UIViewControllerParameters: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.parameters[section].parameters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCellParameters
        cell.parameterTitle.text = self.parameters[indexPath.section].parameters[indexPath.row]
        cell.parameterPercent.text = self.parametersSelected[indexPath.section].parameters[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.parameters.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.parameters[section].section
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterSection") as! UITableViewCellParameterSection
        cell.parameterSectionTitle.text = self.parameters[section].section
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension UIViewControllerParameters: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.years.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewYears.dequeueReusableCell(withReuseIdentifier: "cellYear", for: indexPath) as! CollectionViewCellYear
        cell.titleLabelText = years[indexPath.row].title
        cell.cellSelected = years[indexPath.row].selected
        cell.UIButtonYear.tag = indexPath.row        
        cell.delegate = self
        return cell
    }

}

extension UIViewControllerParameters: CollectionViewCellYearDelegate {
    
    func yearTagPressed(tag: Int) {
        self.setYearParameters(indexPath: tag)
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

