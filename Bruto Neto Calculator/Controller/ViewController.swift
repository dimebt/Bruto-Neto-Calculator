//
//  ViewController.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 12/20/17.
//  Copyright © 2017 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class CalculationUILabel: UILabel, CalculatorAnimation {
    
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionViewYears: UICollectionView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var calculationDetails: UIView!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var numPad: UIStackView!
    @IBOutlet weak var calculationBrutoView: UIView!
    private var displayText: String = "0"
    private var isNumPadOnScreen = true
    @IBOutlet weak var buttonBruto: UIButtonBrutoType1!
    @IBOutlet weak var buttonNeto: UIButtonBrutoType1!
    @IBOutlet var calculationView: UIView!
    private var caluclationMaskFrame: CGRect!
    private var caluclationMaskFrameUp: CGRect!
    private var arrowPosition: String = "down"
    @IBOutlet weak var arrowButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var calculationDetailsTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var calculationBrutoLabel: CalculationUILabel!
    @IBOutlet var sideMenuView: UIViewSideMenu!
    
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
    
    private var sideMenuItems = ["HOME",
                                 "YEAR PARAMETERS",
                                 "CHANGE CURRENCY",
                                 "GROSS / NET LAW",
                                 "PIE CHART",
                                 "SHARE RESULTS",
                                 "PRIVACY POLICY"]
    
    @IBAction func brutoPressed(_ sender: Any) {
        buttonNeto.backgroundColor = UIColor.clear
        showNumpad()
    }
    @IBAction func netoPressed(_ sender: Any) {
        buttonBruto.backgroundColor = UIColor.clear
        showNumpad()
    }
    
    @IBAction func numpadPressed(_ sender: UIButton) {
        guard let digit = sender.titleLabel?.text else { return }
        
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        numberFormater.decimalSeparator = ","
        numberFormater.maximumFractionDigits = 2
        numberFormater.alwaysShowsDecimalSeparator = false
        numberFormater.groupingSeparator = " "
        
        switch digit {
        case "C":
            self.displayText = "0"
        case "OK":
            handleOK()
        case ",":
            handleSeparator(separator: digit)
        case "←":
            handleBack()
        default:
            self.displayText = self.displayText + digit
        }
       
        digitCounterCheck()
        
        if let separatorIndex = self.displayText.index(of: ",") {
            let endIndex = self.displayText.endIndex
            let textAfterSeparator = self.displayText[separatorIndex..<endIndex]
            if textAfterSeparator.count > 3 {
                self.displayText = String(self.displayText.dropLast())
            }
        }
        
        let number = numberFormater.number(from: self.displayText)
        self.display.text = numberFormater.string(from: number!)
        print(self.displayText)
    }
    
    private func handleOK() {
        self.isNumPadOnScreen = false
        self.detailsView.addSubview(self.calculationView)
        self.calculationView.isHidden = true
        self.calculationDetails.isHidden = true
        self.calculationView.frame.size = self.detailsView.frame.size
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.detailsView.bounds.origin.y -= self.detailsView.frame.height
            self.view.layoutIfNeeded()
        }) { (isFinished) in
            self.calculationView.isHidden = false
            
            self.display.isHidden = true
            self.currency.isHidden = true
            self.numPad.isHidden = true
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
                self.detailsView.bounds.origin.y += self.detailsView.frame.height
                self.calculationDetailsTopConstraint.constant = -self.calculationDetails.frame.height
                self.view.layoutIfNeeded()
                //self.caluclationMaskFrame = self.calculationDetails.convert(self.calculationDetails.frame, to: self.view)
                //self.caluclationMaskFrame = self.calculationDetails.frame
            }, completion: { (isFinished) in
                //self.caluclationMaskFrameUp = self.calculationDetails.convert(self.calculationDetails.frame, to: self.view)
                //self.caluclationMaskFrameUp = self.calculationDetails.frame
                //self.caluclationMaskFrame = self.calculationDetails.convert(self.calculationDetails.frame, to: self.view)
            })
        }
        
//        let numpadFrame = self.detailsView.frame
//        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
//            self.detailsView.bounds.origin.y -= self.detailsView.frame.height
//            self.view.layoutIfNeeded()
//        }) { (isFinished) in
//            self.calculationView.frame.origin.y += self.detailsView.frame.height
//            self.view.addSubview(self.calculationView)
//
//            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
//                self.calculationView.frame = numpadFrame
//                self.calculationDetailsTopConstraint.constant = -self.calculationDetails.frame.height
//                self.view.layoutIfNeeded()
//                self.caluclationMaskFrame = self.calculationView.convert(self.calculationDetails.frame, to: self.view)
//            }, completion: { (isFinishedCalculationViewAnimation) in
//                self.calculationDetails.frame.origin.y = -self.calculationDetails.frame.height
//                self.view.layoutIfNeeded()
//                self.caluclationMaskFrameUp = self.calculationView.convert(self.calculationDetails.frame, to: self.view)
//
//                print(self.caluclationMaskFrame)
//                print(self.caluclationMaskFrameUp)
//
//            })
//        }
    }
   
    private func handleSeparator(separator: String) {
        if let _ = self.displayText.index(of: ",") {
        } else {
            self.displayText = self.displayText + separator
        }
    }
    
    private func handleBack() {
        if self.displayText.count > 1 {
            self.displayText = String(self.displayText.dropLast())
        }
    }
    
    private func digitCounterCheck() {
        let digitCount = self.displayText.count
        let alert = UIAlertController(title: "Wooww", message: "Are u sure u want to calculate this value!?", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Back", style: .cancel, handler: nil))
        if digitCount >= 10 {
            self.present(alert, animated: true, completion: {
            })
            self.displayText = String(self.displayText.dropLast())
        }
    }
    
    @IBOutlet weak var arrrowButton: UIButtonCircleWithArrow!
    
    @IBAction func arrowPressed(_ sender: Any) {
        
        self.calculationBrutoLabel.calculatorAnimation(with: 56213)
        
        // check up or down animation
        switch arrowPosition {
        case "down":
            maskDown()
        case "up":
            maskUp()
        default: break
        }
    
    }
    
    private func maskDown() {
        self.calculationDetails.isHidden = false
        
        let mask = UIView(frame: CGRect(x: 0, y: 0, width: self.calculationDetails.frame.width, height: self.calculationDetails.frame.height))
        mask.frame.origin.y = self.calculationDetails.frame.height
        mask.backgroundColor = .green
        mask.alpha = 1
        self.view.addSubview(mask)
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.calculationDetails.frame.origin.y += self.calculationDetails.frame.height
            mask.frame.origin.y = 0
            self.calculationDetails.mask = mask
            self.calculationDetailsTopConstraint.constant += self.calculationDetails.frame.height
            self.view.layoutIfNeeded()
        }) { (isFinished) in
            self.arrowPosition = "up"
        }
    }
    
    private func maskUp() {
        let mask = UIView(frame: CGRect(x: 0, y: 0, width: self.calculationDetails.frame.width, height: self.calculationDetails.frame.height))
        mask.backgroundColor = .gray
        mask.alpha = 1
        self.view.addSubview(mask)

        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.calculationDetails.frame.origin.y -= self.calculationDetails.frame.height
            mask.frame.origin.y = mask.frame.height
            self.calculationDetails.mask = mask
            self.calculationDetailsTopConstraint.constant -= self.calculationDetails.frame.height
            self.view.layoutIfNeeded()
        }) { (isFinished) in
            self.calculationDetails.isHidden = true
            self.arrowPosition = "down"
        }
        
        
    }
    
    private func showNumpad() {
        if(!isNumPadOnScreen) {
            self.arrrowButton.arrowRotateDown()
            self.arrowPosition = "down"
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
                self.detailsView.bounds.origin.y -= self.detailsView.frame.height
                self.view.layoutIfNeeded()
            }) { (isFinished) in
                self.display.isHidden = false
                self.currency.isHidden = false
                self.numPad.isHidden = false
                self.calculationView.removeFromSuperview()
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
                    self.detailsView.bounds.origin.y += self.detailsView.frame.height
                    self.view.layoutIfNeeded()
                }, completion: { (isFinished) in
                    
                })
            }
        }
        self.isNumPadOnScreen = true
    }
    
    @IBAction func sideMenuPressed(_ sender: Any) {
        let menuWidth = self.view.frame.width / 1.5
        self.sideMenuView.frame = CGRect(x: menuWidth * -1.2, y: 0, width: menuWidth, height: self.view.frame.height)
        self.view.addSubview(sideMenuView)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.sideMenuView.frame.origin.x += menuWidth 
            self.view.layoutIfNeeded()
        }) { (isFinished) in
            
        }
    }
    
    @IBAction func sideMenuHide(_ sender: Any) {
        print("sideMenuHide")
        let menuWidth = self.view.frame.width / 1.5
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            print("some animation")
            print(menuWidth)
            self.sideMenuView.frame.origin.x -= menuWidth
            self.view.layoutIfNeeded()
        }) { (isFinished) in
            
        }
        
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //print("viewWillLayoutSubviews()")
        self.calculationView.frame.size = self.detailsView.frame.size
        //self.caluclationMaskFrame = self.calculationDetails.frame
        //self.caluclationMaskFrameUp = self.calculationDetails.frame
        self.caluclationMaskFrame = self.calculationView.convert(self.calculationDetails.frame, to: self.view)
        self.caluclationMaskFrameUp = self.calculationView.convert(self.calculationDetails.frame, to: self.view)
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

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sideMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SideMenuItemTableViewCell
        return cell
    }
    
}

