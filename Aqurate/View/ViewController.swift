//
//  ViewController.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 29/06/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var lblQuotes: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageTemp : UIImage?
    
    var quotes : [String] = ["Good things take time","Practice makes perfect","Talk less do more"]
   
    let gameMode = ["Free Mode","Keeper Mode"]
    let gameDetail = ["You are free to shoot, shoot the ball to the corner of the goal to get higher score","There are a simulation of keeper, you need to avoid the keeper by shooting away from keeper"]
    let gamePict = [    UIImage(named: "Free Mode"),
                        UIImage(named: "Keeper Mode")]
    
    let gameID = ["A","B"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHead.setGradientBackground(colourOne: Colors.orange, colourTwo: Colors.liteRed)
        
        let firstCheck : Bool = UserDefaults.standard.bool(forKey: "check")
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        //statusBar.backgroundColor = Colors.orange
        statusBar.setGradientBackground(colourOne: Colors.orange, colourTwo: Colors.liteRed)
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
     
        lblQuotes.text = "\"" + quotes.randomElement()! + "\""
        imageTemp = UIImage(named: "profileTap")
        imageProfile.image = imageTemp
        roundedProfile()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
        imageProfile.isUserInteractionEnabled = true
        imageProfile.addGestureRecognizer(tap)
        viewHead.backgroundColor = Colors.orange
        
        if(firstCheck == true){
            
            let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            imageProfile.image = UIImage(data: data as Data)
            imageProfile.transform = CGAffineTransform(rotationAngle: (90 * CGFloat.pi)/180)
        }
        
        //viewAttribute()
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let firstCheck : Bool = UserDefaults.standard.bool(forKey: "check")
        
        lblQuotes.text = "\"" + quotes.randomElement()! + "\""
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        
        if(firstCheck == true){
            let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            imageProfile.image = UIImage(data: data as Data)
            imageProfile.transform = CGAffineTransform(rotationAngle: (90 * CGFloat.pi)/180)
        }
        
        if(firstCheck == false){
            imageProfile.image = UIImage(named: "profileTap")
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        
        let firstCheck : Bool = UserDefaults.standard.bool(forKey: "check")
        
        if(firstCheck == true){
            let viewController = storyboard?.instantiateViewController(withIdentifier: "Profile")
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
        else if(firstCheck == false){
            let viewController = storyboard?.instantiateViewController(withIdentifier: "Login")
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
        
        
    }
    
    func roundedProfile(){
        imageProfile.layer.borderWidth = 1
        imageProfile.layer.masksToBounds = false
        imageProfile.layer.borderColor = UIColor.white.cgColor
        imageProfile.layer.borderWidth = 2.0
        imageProfile.layer.cornerRadius = imageProfile.frame.height/2
        imageProfile.clipsToBounds = true
    }
    
    func viewAttribute(){
        viewHead.layer.shadowColor = UIColor.gray.cgColor
        viewHead.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewHead.layer.shadowRadius = 1.2
        viewHead.layer.shadowOpacity = 1.0
        viewHead.clipsToBounds = false
    }

}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameMode.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cells", for: indexPath) as? CollectionViewCell
        
 
        cell?.mode.text = gameMode[indexPath.row]
        cell?.detail.text = gameDetail[indexPath.row]
        cell?.image.image = gamePict[indexPath.row]
        cell?.image.layer.cornerRadius = 10.0
        cell?.image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        cell?.contentView.layer.cornerRadius = 10
        cell?.contentView.layer.borderWidth = 3.5
        cell?.contentView.layer.borderColor = UIColor.orange.cgColor
        cell?.contentView.layer.masksToBounds = false
        cell?.layer.shadowColor = UIColor.gray.cgColor
        cell?.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        cell?.layer.shadowRadius = 5.0
        cell?.layer.shadowOpacity = 1.0
        cell?.layer.cornerRadius = 10
        cell?.layer.masksToBounds = false
        cell?.layer.shadowPath = UIBezierPath(roundedRect: cell!.bounds, cornerRadius: cell!.contentView.layer.cornerRadius).cgPath
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ID = gameID[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: ID)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
}

extension UIView {
    func setGradientBackground(colourOne : UIColor, colourTwo : UIColor){
        let gradientColour = CAGradientLayer()
        gradientColour.frame = bounds
        gradientColour.colors = [colourOne.cgColor, colourTwo.cgColor]
        gradientColour.locations = [0.0, 1.0]
        gradientColour.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientColour.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientColour, at: 0)
    }
}

