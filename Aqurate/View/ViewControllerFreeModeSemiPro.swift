//
//  ViewControllerFreeModeSemiPro.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 30/06/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit
import CoreMotion

var flagSession = 0
var gameScore = 0
var detailedScore: [Int] = []

class ViewControllerFreeModeSemiPro: UIViewController {

    
    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var goalImage: UIImageView!
    @IBOutlet weak var tiltPhone: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    var gameCycle = 0
    
    
    var flagConfirmation1 = 0
    var flagConfirmation2 = 0
    var flagConfirmation3 = 0
    var flagConfirmation4 = 0
    var flagConfirmation5 = 0
    var flagConfirmation6 = 0
    
    //var flagCheck = 0
    
    var timer = Timer()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(flagSession == 10){
            flagSession = 0
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.6, target: self, selector: #selector(rotate), userInfo: nil, repeats: true)
        
        tiltPhone.image = UIImage(named: "tiltPhone")
        goalImage.image = UIImage(named: "gawang-6box")
        goalImage.alpha = 0
        rotate()
        
        goalViewInvisible()
        
        taptap()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if(flagSession > 0){
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //flagCheck = 0
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.enableAllOrientation = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.enableAllOrientation = false
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape{
            goalImage.transform = CGAffineTransform(rotationAngle: (0 * CGFloat.pi)/180)
            goalImage.alpha = 1
            tiltPhone.alpha = 0
            timer.invalidate()
            lblWarning.text = ""
            goalViewVisible()
            
            
            
        }
        if UIDevice.current.orientation.isPortrait{
            goalImage.alpha = 0
            tiltPhone.alpha = 1
            lblWarning.text = "Please tilt your phone to the landscape mode ↻"
            timer = Timer.scheduledTimer(timeInterval: 1.6, target: self, selector: #selector(rotate), userInfo: nil, repeats: true)
            goalViewInvisible()
        }
    }
    func goalViewInvisible(){
        view1.alpha = 0
        view2.alpha = 0
        view3.alpha = 0
        view4.alpha = 0
        view5.alpha = 0
        view6.alpha = 0
    }
    
    func goalViewVisible(){
        view1.alpha = 1
        view2.alpha = 1
        view3.alpha = 1
        view4.alpha = 1
        view5.alpha = 1
        view6.alpha = 1
    }
    
    func taptap(){
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(pulseTouch(_:)))
        view1.isUserInteractionEnabled = true
        view1.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(pulseTouch(_:)))
        view2.isUserInteractionEnabled = true
        view2.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(pulseTouch(_:)))
        view3.isUserInteractionEnabled = true
        view3.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(pulseTouch(_:)))
        view4.isUserInteractionEnabled = true
        view4.addGestureRecognizer(tap4)
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(pulseTouch(_:)))
        view5.isUserInteractionEnabled = true
        view5.addGestureRecognizer(tap5)
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(pulseTouch(_:)))
        view6.isUserInteractionEnabled = true
        view6.addGestureRecognizer(tap6)
        
    }
   
    func addPulse(for subView: UIView){
        let pulse = Pulsing(numberOfPulses: 1, radius: 70, position: subView.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        self.view.layer.insertSublayer(pulse, above: subView.layer)
    }
    
    @objc func pulseTouch(_ gesture: UITapGestureRecognizer){
        resetButton()
        
        switch gesture.view?.tag {
        case 1:
            view1.backgroundColor = Colors.green
            if flagConfirmation1 == 0 {
                resetFlag()
                flagConfirmation1 = 1
            } else {
                addPulse(for: view1)
                gameScore+=3
                detailedScore.append(3)
                lblScore.text = String(gameScore)
                UserDefaults.standard.set(gameScore, forKey: "savedScore")
                view1.backgroundColor = Colors.greenActive
                flagSession+=1
                
                moveTo()
            }
        case 2:
            view2.backgroundColor = Colors.green
            if flagConfirmation2 == 0 {
                resetFlag()
                flagConfirmation2 = 1
            } else {
                addPulse(for: view2)
                gameScore+=2
                detailedScore.append(2)
                lblScore.text = String(gameScore)
                UserDefaults.standard.set(gameScore, forKey: "savedScore")
                view2.backgroundColor = Colors.greenActive
                flagSession+=1
                moveTo()
            }
        case 3:
            view3.backgroundColor = Colors.green
            if flagConfirmation3 == 0 {
                resetFlag()
                flagConfirmation3 = 1
            } else {
                addPulse(for: view3)
                gameScore+=3
                detailedScore.append(3)
                lblScore.text = String(gameScore)
                UserDefaults.standard.set(gameScore, forKey: "savedScore")
                view3.backgroundColor = Colors.greenActive
                flagSession+=1
                moveTo()
            }
        case 4:
            view4.backgroundColor = Colors.green
            if flagConfirmation4 == 0 {
                resetFlag()
                flagConfirmation4 = 1
            } else {
                addPulse(for: view4)
                gameScore+=2
                detailedScore.append(2)
                lblScore.text = String(gameScore)
                UserDefaults.standard.set(gameScore, forKey: "savedScore")
                view4.backgroundColor = Colors.greenActive
                flagSession+=1
                moveTo()
            }
        case 5:
            view5.backgroundColor = Colors.green
            if flagConfirmation5 == 0 {
                resetFlag()
                flagConfirmation5 = 1
            } else {
                addPulse(for: view5)
                gameScore+=1
                detailedScore.append(1)
                lblScore.text = String(gameScore)
                UserDefaults.standard.set(gameScore, forKey: "savedScore")
                view5.backgroundColor = Colors.greenActive
                flagSession+=1
                moveTo()
            }
        case 6:
            view6.backgroundColor = Colors.green
            if flagConfirmation6 == 0 {
                resetFlag()
                flagConfirmation6 = 1
            } else {
                addPulse(for: view6)
                gameScore+=2
                detailedScore.append(2)
                lblScore.text = String(gameScore)
                UserDefaults.standard.set(gameScore, forKey: "savedScore")
                view6.backgroundColor = Colors.greenActive
                flagSession+=1
                moveTo()
            }
        default:
            print("view not detected")
        }
        
    }
    
    private func moveTo(){
        if(flagSession == 10){
            let viewController = storyboard?.instantiateViewController(withIdentifier: "Statistics")
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
        if(flagSession != 10){
            if(flagSession%2 == 0){
                let viewController = storyboard?.instantiateViewController(withIdentifier: "Location")
                self.navigationController?.pushViewController(viewController!, animated: true)
            }
        }
    }
    
    private func resetButton(){
        view1.backgroundColor = UIColor.clear
        view2.backgroundColor = UIColor.clear
        view3.backgroundColor = UIColor.clear
        view4.backgroundColor = UIColor.clear
        view5.backgroundColor = UIColor.clear
        view6.backgroundColor = UIColor.clear
    }
    
    private func resetFlag(){
        flagConfirmation1 = 0
        flagConfirmation2 = 0
        flagConfirmation3 = 0
        flagConfirmation4 = 0
        flagConfirmation5 = 0
        flagConfirmation6 = 0
    }
    
    @objc func rotate(){
        tiltPhone.transform = CGAffineTransform(rotationAngle: (0 * CGFloat.pi)/180)
        
        UIView.animate(withDuration: 1.5) {
            self.tiltPhone.transform = CGAffineTransform(rotationAngle: (90 * CGFloat.pi)/180)
        }
    }
        
}
