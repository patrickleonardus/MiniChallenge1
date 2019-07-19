//
//  ViewControllerKeeperModeSemiPro.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 16/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerKeeperModeSemiPro: UIViewController {

    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet weak var tiltPhone: UIImageView!
    @IBOutlet weak var goalImage: UIImageView!
    @IBOutlet weak var peopleImage1: UIImageView!
    @IBOutlet weak var peopleImage2: UIImageView!
    @IBOutlet weak var lblRemainingShoot: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    @IBOutlet weak var maskingView1: UIView!
    @IBOutlet weak var maskingView2: UIView!
    
    
    var flagConfirmation1 = 0
    var flagConfirmation2 = 0
    var flagConfirmation3 = 0
    var flagConfirmation4 = 0
    var flagConfirmation5 = 0
    var flagConfirmation6 = 0
    
    var timer = Timer()
    
    var round = 0
    var trainingData : [Training]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taptap()
        
        if(flagSession == 10){
            flagSession = 0
        }
        
        if(remainingShoot == 0){
            remainingShoot = 10
        }
        lblRemainingShoot.text = String(remainingShoot)
        
        peopleInvisible()
        goalViewInvisible()
        goalImage.alpha = 0
        tiltPhone.image = UIImage(named: "tiltPhone")
        
         timer = Timer.scheduledTimer(timeInterval: 1.6, target: self, selector: #selector(rotate), userInfo: nil, repeats: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.enableAllOrientation = true
        
        maskingView1.alpha = 0
        maskingView2.alpha = 0
        
        randomKeeper()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
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
            maskingView1.alpha = 1
            maskingView2.alpha = 1
            goalViewVisible()
            
            if(flagSession == 0){
                funcAlert()
            }
            
            UIView.animate(withDuration: 0.6) {
                self.view.backgroundColor = .black
            }
           
        }
        if UIDevice.current.orientation.isPortrait{
            lblWarning.text = "Please tilt your phone to the landscape mode ↻"
            goalImage.alpha = 0
            tiltPhone.alpha = 1
            goalViewInvisible()
            maskingView1.alpha = 0
            maskingView2.alpha = 0
            timer = Timer.scheduledTimer(timeInterval: 1.6, target: self, selector: #selector(rotate), userInfo: nil, repeats: true)
            
            UIView.animate(withDuration: 0.6) {
                self.view.backgroundColor = .white
            }
           
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if(flagSession > 0){
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
    }
    
    @objc func rotate(){
        tiltPhone.transform = CGAffineTransform(rotationAngle: (0 * CGFloat.pi)/180)
        
        UIView.animate(withDuration: 1.5) {
            self.tiltPhone.transform = CGAffineTransform(rotationAngle: (90 * CGFloat.pi)/180)
        }
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
    
    @objc func pulseTouch(_ gesture : UITapGestureRecognizer){
        resetButton()
        
        var tempScore = 0
        
        switch gesture.view?.tag {
        case 1:
            view1.backgroundColor = Colors.green
            if flagConfirmation1 == 0 {
                resetFlag()
                flagConfirmation1 = 1
            } else {
                if peopleImage1.alpha == 0 {
                    tempScore = 3
                } else {
                    tempScore = 0
                }
                addPulse(for: view1)
                gameScore+=tempScore
                detailedScore.append(tempScore)
                UserDefaults.standard.set(gameScore, forKey: "savedScore")
                view1.backgroundColor = Colors.greenActive
                flagSession+=1
                remainingShoot-=1
                lblRemainingShoot.text = String(remainingShoot)
                moveTo()
            }
        case 2:
            view2.backgroundColor = Colors.green
            if flagConfirmation2 == 0 {
                resetFlag()
                flagConfirmation2 = 1
            } else {
                tempScore = 2
                addPulse(for: view2)
                gameScore+=tempScore
                detailedScore.append(tempScore)
                UserDefaults.standard.set(gameScore, forKey: "savedScore")
                view2.backgroundColor = Colors.greenActive
                flagSession+=1
                remainingShoot-=1
                lblRemainingShoot.text = String(remainingShoot)
                moveTo()
            }
        case 3:
            view3.backgroundColor = Colors.green
            if flagConfirmation3 == 0 {
                resetFlag()
                flagConfirmation3 = 1
            } else {
                if peopleImage1.alpha == 0 {
                    tempScore = 0
                } else {
                    tempScore = 3
                }
                addPulse(for: view3)
                gameScore+=tempScore
                detailedScore.append(tempScore)
                UserDefaults.standard.set(gameScore, forKey: "savedScore")
                view3.backgroundColor = Colors.greenActive
                flagSession+=1
                remainingShoot-=1
                lblRemainingShoot.text = String(remainingShoot)
                moveTo()
            }
        case 4:
            view4.backgroundColor = Colors.green
            if flagConfirmation4 == 0 {
                resetFlag()
                flagConfirmation4 = 1
            } else {
                if peopleImage1.alpha == 0 {
                    tempScore = 2
                } else {
                    tempScore = 0
                }
                addPulse(for: view4)
                gameScore+=tempScore
                detailedScore.append(tempScore)
                UserDefaults.standard.set(gameScore, forKey: "savedScore")
                view4.backgroundColor = Colors.greenActive
                flagSession+=1
                remainingShoot-=1
                lblRemainingShoot.text = String(remainingShoot)
                moveTo()
            }
        case 5:
            view5.backgroundColor = Colors.green
            if flagConfirmation5 == 0 {
                resetFlag()
                flagConfirmation5 = 1
            } else {
                tempScore = 1
                addPulse(for: view5)
                gameScore+=tempScore
                detailedScore.append(tempScore)
                UserDefaults.standard.set(gameScore, forKey: "savedScore")
                view5.backgroundColor = Colors.greenActive
                flagSession+=1
                remainingShoot-=1
                lblRemainingShoot.text = String(remainingShoot)
                moveTo()
            }
        case 6:
            view6.backgroundColor = Colors.green
            if flagConfirmation6 == 0 {
                resetFlag()
                flagConfirmation6 = 1
            } else {
                if peopleImage1.alpha == 0 {
                    tempScore = 0
                } else {
                    tempScore = 2
                }
                addPulse(for: view6)
                gameScore+=tempScore
                detailedScore.append(tempScore)
                UserDefaults.standard.set(gameScore, forKey: "savedScore")
                view6.backgroundColor = Colors.greenActive
                flagSession+=1
                remainingShoot-=1
                lblRemainingShoot.text = String(remainingShoot)
                moveTo()
            }
        default:
             print("view not detected")
        }
    }
    
    
    func addPulse(for subView : UIView){
        
        let pulse = Pulsing(numberOfPulses: 1, radius: 70, position: subView.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.orange.cgColor
        self.view.layer.insertSublayer(pulse, above: subView.layer)
    }
    
    private func moveTo(){
        if(flagSession == 10){
            let viewController = storyboard?.instantiateViewController(withIdentifier: "Statistics")
            self.navigationController?.pushViewController(viewController!, animated: true)
            saveTraining(arrScores: detailedScore)
        }
        if(flagSession != 10){
            if(flagSession%2 == 0){
                let viewController = storyboard?.instantiateViewController(withIdentifier: "Location")
                self.navigationController?.pushViewController(viewController!, animated: true)
            }
        }
    }
    
    func saveTraining(arrScores: [Int]){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YYYY"
        let date = formatter.string(from: Date.init() as Date)
        
        let training = Training(context: self.context)
        let round = getRound() + 1
        
        training.date = date
        training.difficulty = "Semi-Pro"
        training.mode = "Keeper Mode"
        training.rating = getGrade()
        training.round = round
        
        var scoreInput : [Score] = []
        var id = getRound() * 10
        for scoreFor in arrScores {
            let scoreContext = Score(context: self.context)
            id += 1
            scoreContext.id = id
            scoreContext.round = round
            scoreContext.score = Int16(scoreFor)
            scoreInput.append(scoreContext)
        }
        
        training.addToScores(NSOrderedSet(array: scoreInput))
        trainingData?.append(training)
        
        do {
            try context.save()
        } catch {
            print("Error 001 : Context not saved.")
        }
    }
    
    func getGrade() -> String {
        let rate = gameScore * 100 / HighTotalScore
        if rate >= 80 {
            return "A"
        } else if rate >= 60 {
            return "B"
        } else if rate >= 40 {
            return "C"
        } else if rate >= 20 {
            return "D"
        } else {
            return "E"
        }
    }
    
    func getRound() -> Int16{
        let roundTemp: Int16
        let request : NSFetchRequest = Training.fetchRequest()
        
        do {
            trainingData = try context.fetch(request)
        } catch  {
            print("error")
        }
        
        roundTemp = trainingData?.last?.round ?? 0
        
        return roundTemp
    }
    
    func randomKeeper(){
        let flagKeeper = Int.random(in: 0...1)
        peopleInvisible()
        
        if(flagKeeper == 0){
            peopleImage1.alpha = 1
        }
        else if(flagKeeper == 1){
            peopleImage2.alpha = 1
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
    
    func peopleInvisible(){
        peopleImage1.alpha = 0
        peopleImage2.alpha = 0
    }
    
    func peopleVisible(){
        peopleImage1.alpha = 1
        peopleImage2.alpha = 1
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
    
    func funcAlert(){
        let alert = UIAlertController(title: "\n Double Tap to the Area of Your Shooting",message: "", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(dismissAction)
        alert.preferredAction = dismissAction
        self.present(alert, animated: true, completion:  nil)
    }
    
}
