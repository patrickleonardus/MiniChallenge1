//
//  ViewControllerTips.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 03/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewControllerTips: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    

}
