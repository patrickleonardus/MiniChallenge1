//
//  ViewControllerStatistics.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 14/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewControllerStatistics: UIViewController {

    
    @IBOutlet weak var btnRetryOutlet: Button!
    @IBOutlet weak var btnBackOutlet: Button!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vcs = self.navigationController?.viewControllers {
            let previousVC = vcs[vcs.count - 2]
            if previousVC is ViewControllerHistory {
                btnRetryOutlet.isHidden = true
                btnBackOutlet.isHidden = true
            }
            if !(previousVC is ViewControllerHistory) {
                btnRetryOutlet.isHidden = false
                btnBackOutlet.isHidden = false
            }
        }
        

    }


    @IBAction func btnBackToHome(_ sender: Any) {        
        performSegue(withIdentifier: "goHome", sender: self)
    }
    
    @IBAction func btnRetry(_ sender: Any) {
        detailedScore = []
        gameScore = 0
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "Location")
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
    
}
