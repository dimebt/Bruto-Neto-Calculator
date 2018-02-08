//
//  UIViewControllerSideMenu.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 1/22/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UIViewControllerSideMenu: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var sideMenuItems = ["HOME",
                                 "YEAR PARAMETERS",
                                 "CHANGE CURRENCY",
                                 "GROSS / NET LAW",
                                 "PIE CHART",
                                 "SHARE RESULTS",
                                 "PRIVACY POLICY"]

    @IBAction func sideMenuHideButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("sideMenuHide"), object: nil)
    }
    
    private func sideMenuHide() {
        NotificationCenter.default.post(name: NSNotification.Name("sideMenuHide"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sideMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SideMenuItemTableViewCell
        cell.label.text = self.sideMenuItems[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        switch indexPath.row {
        case 0:
            sideMenuHide()
            NotificationCenter.default.post(name: NSNotification.Name("showHome"), object: nil)
        case 1:
            sideMenuHide()
            NotificationCenter.default.post(name: NSNotification.Name("showParameters"), object: nil)
        case 2:
            sideMenuHide()
            NotificationCenter.default.post(name: NSNotification.Name("showCurrency"), object: nil)
        case 3:
            sideMenuHide()
            UIApplication.shared.open(URL(string: "http://www.finance.gov.mk/files/upatstvo_bruto_plata.pdf")!, options: [:], completionHandler: { (isFinished) in
                
            })
        case 4:
            sideMenuHide()
            NotificationCenter.default.post(name: NSNotification.Name("showPieChart"), object: nil)
        case 5:
            sideMenuHide()
            let activityViewController = UIActivityViewController(activityItems: self.sideMenuItems, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: {
                
            })
        default:
            break
        }
    }
    
}
