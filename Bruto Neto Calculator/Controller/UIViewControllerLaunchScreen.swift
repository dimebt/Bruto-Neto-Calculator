//
//  UIViewControllerLaunchScreen.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/14/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UIViewControllerLaunchScreen: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        for layer in self.view.layer.sublayers! {
            if layer.name == "GradientLayer" {
                layer.frame = CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateLogo()
    }
    
    private func setupUI() {
        self.view.setGradientBackground(colorOne: UIColor.init(hex: BackgroundColor.Dark), colorTwo: UIColor.init(hex: BackgroundColor.Light))
    }
    
    private func animateLogo() {
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.5, options: .curveEaseIn, animations: {
            self.logo.frame.size.width = self.logo.frame.size.width * 0.6
            self.logo.frame.size.height = self.logo.frame.size.height * 0.6
            self.logo.center = self.view.center
            self.view.layoutIfNeeded()
        }) { (isFinished) in
            if (isFinished) {
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    //self.logo.frame.origin.y = self.view.bounds.height + self.logo.frame.height
                    self.logo.alpha = 0
                    self.view.layoutIfNeeded()
                }, completion: { (isFinished) in
                    self.performSegue(withIdentifier: "segueHome", sender: self)
                })
                
            }
        }
        
    }
}
