//
//  ViewControllerStatistics.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 14/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewControllerStatistics: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

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
