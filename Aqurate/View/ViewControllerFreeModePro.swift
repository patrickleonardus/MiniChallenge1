//
//  ViewControllerFreeModePro.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 14/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewControllerFreeModePro: UIViewController {

    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet weak var goalImage: UIImageView!
    @IBOutlet weak var tiltPhone: UIImageView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view9: UIView!
    
    
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taptap()
        
        goalViewInvisible()
        goalImage.alpha = 0
        tiltPhone.image = UIImage(named: "tiltPhone")
        
        timer = Timer.scheduledTimer(timeInterval: 1.6, target: self, selector: #selector(rotate), userInfo: nil, repeats: true)
      
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
            timer.invalidate()
            lblWarning.text = ""
            goalImage.transform = CGAffineTransform(rotationAngle: (0 * CGFloat.pi)/180)
            goalImage.alpha = 1
            tiltPhone.alpha = 0
            goalViewVisible()
            
        }
        if UIDevice.current.orientation.isPortrait{
            lblWarning.text = "Please tilt your phone to the landscape mode ↻"
            goalImage.alpha = 0
            tiltPhone.alpha = 1
            goalViewInvisible()
            timer = Timer.scheduledTimer(timeInterval: 1.6, target: self, selector: #selector(rotate), userInfo: nil, repeats: true)
        }
    }
    
    @objc func rotate(){
        tiltPhone.transform = CGAffineTransform(rotationAngle: (0 * CGFloat.pi)/180)
        
        UIView.animate(withDuration: 1.5) {
            self.tiltPhone.transform = CGAffineTransform(rotationAngle: (90 * CGFloat.pi)/180)
        }
    }
    
    func taptap(){
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(touch1))
        view1.isUserInteractionEnabled = true
        view1.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(touch2))
        view2.isUserInteractionEnabled = true
        view2.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(touch3))
        view3.isUserInteractionEnabled = true
        view3.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(touch4))
        view4.isUserInteractionEnabled = true
        view4.addGestureRecognizer(tap4)
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(touch5))
        view5.isUserInteractionEnabled = true
        view5.addGestureRecognizer(tap5)
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(touch6))
        view6.isUserInteractionEnabled = true
        view6.addGestureRecognizer(tap6)
        
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(touch7))
        view7.isUserInteractionEnabled = true
        view7.addGestureRecognizer(tap7)
        
        let tap8 = UITapGestureRecognizer(target: self, action: #selector(touch8))
        view8.isUserInteractionEnabled = true
        view8.addGestureRecognizer(tap8)
        
        let tap9 = UITapGestureRecognizer(target: self, action: #selector(touch9))
        view9.isUserInteractionEnabled = true
        view9.addGestureRecognizer(tap9)
    }
    
    @objc func touch1(){
        addPulse1()
    }
    @objc func touch2(){
        addPulse2()
    }
    @objc func touch3(){
        addPulse3()
    }
    @objc func touch4(){
        addPulse4()
    }
    @objc func touch5(){
        addPulse5()
    }
    @objc func touch6(){
        addPulse6()
    }
    @objc func touch7(){
        addPulse7()
    }
    @objc func touch8(){
        addPulse8()
    }
    @objc func touch9(){
        addPulse9()
    }
    
    func addPulse1(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 45, position: view1.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view1.layer)
    }
    func addPulse2(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 45, position: view2.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view2.layer)
    }
    func addPulse3(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 45, position: view3.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view3.layer)
    }
    func addPulse4(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 45, position: view4.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view4.layer)
    }
    func addPulse5(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 45, position: view5.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view5.layer)
    }
    func addPulse6(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 45, position: view6.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view6.layer)
    }
    func addPulse7(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 45, position: view7.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view7.layer)
    }
    func addPulse8(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 45, position: view8.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view8.layer)
    }
    func addPulse9(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 45, position: view9.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        
        self.view.layer.insertSublayer(pulse, above: view9.layer)
    }
    
    func goalViewInvisible(){
        view1.alpha = 0
        view2.alpha = 0
        view3.alpha = 0
        view4.alpha = 0
        view5.alpha = 0
        view6.alpha = 0
        view7.alpha = 0
        view8.alpha = 0
        view9.alpha = 0
    }
    
    func goalViewVisible(){
        view1.alpha = 1
        view2.alpha = 1
        view3.alpha = 1
        view4.alpha = 1
        view5.alpha = 1
        view6.alpha = 1
        view7.alpha = 1
        view8.alpha = 1
        view9.alpha = 1
    }
}
