//
//  ViewControllerFreeModeSemiProLocation.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 12/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

var soccerFields1 : [String] = ["Position 1","Position 2","Position 3"]
var soccerFields2 : [String] = ["Position 4","Position 5"]
var flagPlayerLocation = 0

class ViewControllerLocation: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vcs = self.navigationController?.viewControllers {
            let previousVC = vcs[vcs.count - 2]
            if previousVC is ViewControllerFreeMode {
                soccerFields1 = ["Position 1","Position 2","Position 3"]
                soccerFields2 = ["Position 4","Position 5"]
                flagPlayerLocation = 0
            }
        }
        
        
        if(flagPlayerLocation < 3){
            randomPlayerLocation1()
        }
            
        else if(flagPlayerLocation > 2){
            randomPlayerLocation2()
            if(flagPlayerLocation == 5){
                flagPlayerLocation = 0
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.barTintColor = Colors.orange
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func randomPlayerLocation1(){
        let randomField1 = Int.random(in: 0...(soccerFields1.count - 1))
        view.backgroundColor = UIColor(patternImage: UIImage(named: soccerFields1[randomField1])!)
        soccerFields1.remove(at: randomField1)
        if (soccerFields1.count == 0) {
            soccerFields1 = ["Position 1","Position 2","Position 3"]
        }
        flagPlayerLocation+=1
    }
    
    func randomPlayerLocation2(){
        let randomField2 = Int.random(in: 0...(soccerFields2.count - 1))
        view.backgroundColor = UIColor(patternImage: UIImage(named: soccerFields2[randomField2])!)
        soccerFields2.remove(at: randomField2)
        if (soccerFields2.count == 0) {
            soccerFields2 = ["Position 4","Position 5"]
        }
        flagPlayerLocation+=1
    }
    
    @IBAction func btnNext(_ sender: Any) {
        
        let checkID = UserDefaults.standard.integer(forKey: "savedID")
        
        if(checkID == 0){
            let viewController = storyboard?.instantiateViewController(withIdentifier: "FMSemi")
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
        
        if(checkID == 1){
            let viewController = storyboard?.instantiateViewController(withIdentifier: "FMPro")
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
       
        
    }
    

}
