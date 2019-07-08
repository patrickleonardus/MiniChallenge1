//
//  ViewControllerFreeModeSemiPro.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 30/06/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit
import CoreMotion

class ViewControllerFreeModeSemiPro: UIViewController {

    
    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var goalImage: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    
    var flag = 0
    
    var gameScore = 0
    var gameCycle = 0
    
    var timer = Timer()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 2.1, target: self, selector: #selector(rotate), userInfo: nil, repeats: true)
        
        goalImage.image = UIImage(named: "gawang")
        rotate()
        
        goalViewInvisible()
        
        taptap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            timer.invalidate()
            lblWarning.text = ""
            goalViewVisible()
        }
        if UIDevice.current.orientation.isPortrait{
            lblWarning.text = "Please tilt your phone to the landscape mode ↻"
           timer = Timer.scheduledTimer(timeInterval: 2.1, target: self, selector: #selector(rotate), userInfo: nil, repeats: true)
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
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(ViewControllerFreeModeSemiPro.pulseTouch1))
        view1.isUserInteractionEnabled = true
        view1.addGestureRecognizer(tap1)
        
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(ViewControllerFreeModeSemiPro.pulseTouch2))
        view2.isUserInteractionEnabled = true
        view2.addGestureRecognizer(tap2)
        
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(ViewControllerFreeModeSemiPro.pulseTouch3))
        view3.isUserInteractionEnabled = true
        view3.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(ViewControllerFreeModeSemiPro.pulseTouch4))
        view4.isUserInteractionEnabled = true
        view4.addGestureRecognizer(tap4)
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(ViewControllerFreeModeSemiPro.pulseTouch5))
        view5.isUserInteractionEnabled = true
        view5.addGestureRecognizer(tap5)
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(ViewControllerFreeModeSemiPro.pulseTouch6))
        view6.isUserInteractionEnabled = true
        view6.addGestureRecognizer(tap6)
        
    }
    
    func addPulse1(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 70, position: view1.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view1.layer)
    }
    func addPulse2(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 70, position: view2.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view2.layer)
    }
    func addPulse3(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 70, position: view3.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view3.layer)
    }
    func addPulse4(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 70, position: view4.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view4.layer)
    }
    func addPulse5(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 70, position: view5.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view5.layer)
    }
    func addPulse6(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 70, position: view6.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view6.layer)
    }
    
    @objc func pulseTouch1(){
        addPulse1()
        gameScore+=3
        lblScore.text = String(gameScore)
    }
    @objc func pulseTouch2(){
        addPulse2()
    }
    @objc func pulseTouch3(){
        addPulse3()
        gameScore+=3
        lblScore.text = String(gameScore)
    }
    @objc func pulseTouch4(){
        addPulse4()
        gameScore+=2
        lblScore.text = String(gameScore)
    }
    @objc func pulseTouch5(){
        addPulse5()
        gameScore+=1
        lblScore.text = String(gameScore)
    }
    @objc func pulseTouch6(){
        addPulse6()
        gameScore+=2
        lblScore.text = String(gameScore)
    }
    
    @objc func rotate(){
        goalImage.transform = CGAffineTransform(rotationAngle: (0 * CGFloat.pi)/180)
        
        UIView.animate(withDuration: 2.0) {
            self.goalImage.transform = CGAffineTransform(rotationAngle: (90 * CGFloat.pi)/180)
        }
    }
        
}
