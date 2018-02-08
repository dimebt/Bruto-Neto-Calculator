//
//  UIViewControllerCurrency.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/7/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UIViewControllerCurrency: UIViewController {

    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuView: UIViewSideMenu!
    private var isSideMenuVisible = false
    private let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    private let blurView = UIVisualEffectView()
    
    private let currency: [String] = ["MKD ден", "EUR €", "USD $", "GBP £", "SEK kr", "CHF CHF", "DKK kr", "CAD $", "AUD $"]
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBAction func sideMenuShow(_ sender: Any) {
        self.sideMenuShow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewControllerCurrency.sideMenuHide), name: NSNotification.Name("sideMenuHide"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewControllerCurrency.showPieChart), name: NSNotification.Name("showPieChart"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewControllerCurrency.showHome), name: NSNotification.Name("showHome"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewControllerCurrency.showParameters), name: NSNotification.Name("showParameters"), object: nil)
        
        //side menu setup
        let swipeMenu = UISwipeGestureRecognizer(target: self, action: #selector(UIViewControllerCurrency.swipeMenuHandler))
        swipeMenu.direction = .left
        self.sideMenuView.addGestureRecognizer(swipeMenu)
        let tapSideMenu = UITapGestureRecognizer(target: self, action: #selector(UIViewControllerCurrency.tapSideMenuHandler))
        self.blurView.addGestureRecognizer(tapSideMenu)
        
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
    
    @objc private func showParameters() {
        performSegue(withIdentifier: "segueParameters", sender: self)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("----------viewWillTransition()")
        // Because CALayers are not resiziable in UIView.layer snippet for auto resizing
        for layer in self.view.layer.sublayers! {
            if layer.name == "GradientLayer" {
                layer.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
                print("----------viewWillTransition() GradientLayer")
            }
        }
        
        // hide side menu
        self.sideMenuLeadingConstraint.constant = -0.6 * size.width
        print("----------viewWillTransition() hide side menu")
        
        //remove blur view
        UIView.animate(withDuration: 0.5, animations: {
            self.blurView.effect = .none
            print("----------viewWillTransition() remove blur view")
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


extension UIViewControllerCurrency: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: currency[row], attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
}
