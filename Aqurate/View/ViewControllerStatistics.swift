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

        // Do any additional setup after loading the view.
    }

    @IBAction func btnBackToHome(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "Home")
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
}
