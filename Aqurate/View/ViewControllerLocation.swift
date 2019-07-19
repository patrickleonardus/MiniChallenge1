//
//  ViewControllerFreeModeSemiProLocation.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 12/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

var HighTotalScore = 0

var soccerFields1 : [String] = ["Position 1","Position 2","Position 3"]
var soccerFields2 : [String] = ["Position 4","Position 5"]
var flagPlayerLocation = 0

class ViewControllerLocation: UIViewController {
    
  // @IBOutlet weak var backgroundImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vcs = self.navigationController?.viewControllers {
            let previousVC = vcs[vcs.count - 2]
            if previousVC is ViewControllerFreeMode {
                soccerFields1 = ["Position 1","Position 2","Position 3"]
                soccerFields2 = ["Position 4","Position 5"]
                flagPlayerLocation = 0
            }
            if previousVC is ViewControllerKeeperMode {
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    func randomPlayerLocation1(){
        let randomField1 = Int.random(in: 0...(soccerFields1.count - 1))
        view.backgroundColor = UIColor(patternImage: UIImage(named: soccerFields1[randomField1])!)
      // backgroundImage.image = UIImage(named: soccerFields1[randomField1])
        soccerFields1.remove(at: randomField1)
        if (soccerFields1.count == 0) {
            soccerFields1 = ["Position 1","Position 2","Position 3"]
        }
        flagPlayerLocation+=1
    }
    
    func randomPlayerLocation2(){
        let randomField2 = Int.random(in: 0...(soccerFields2.count - 1))
        view.backgroundColor = UIColor(patternImage: UIImage(named: soccerFields2[randomField2])!)
    // backgroundImage.image = UIImage(named: soccerFields2[randomField2])
        soccerFields2.remove(at: randomField2)
        if (soccerFields2.count == 0) {
            soccerFields2 = ["Position 4","Position 5"]
        }
        flagPlayerLocation+=1
    }
    
    @IBAction func btnNext(_ sender: Any) {
        
        let checkFreeModeID = UserDefaults.standard.integer(forKey: "savedFreeModeID")
        let checkKeeperModeID = UserDefaults.standard.integer(forKey: "savedKeeperModeID")
        let checkRootID = UserDefaults.standard.integer(forKey: "savedRootID")
        
        
        if(checkRootID == 0){
            if(checkFreeModeID == 0){
                let viewController = storyboard?.instantiateViewController(withIdentifier: "FMSemi")
                self.navigationController?.pushViewController(viewController!, animated: true)
                HighTotalScore = 30
            }
            
            else if(checkFreeModeID == 1){
                let viewController = storyboard?.instantiateViewController(withIdentifier: "FMPro")
                self.navigationController?.pushViewController(viewController!, animated: true)
                HighTotalScore = 40
            }
        }
        
        else if(checkRootID == 1){
            if(checkKeeperModeID == 0){
                let viewController = storyboard?.instantiateViewController(withIdentifier: "KMSemi")
                self.navigationController?.pushViewController(viewController!, animated: true)
                HighTotalScore = 30
            }
            else if (checkKeeperModeID == 1){
                let viewController = storyboard?.instantiateViewController(withIdentifier: "KMPro")
                self.navigationController?.pushViewController(viewController!, animated: true)
                HighTotalScore = 40
            }
        }
        
        
    }
}
