//
//  ViewController.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 29/06/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblName: UILabel!
    
    
    var imageTemp : UIImage?
   
    let gameMode = ["Free Mode","Keeper Mode"]
    let gameDetail = ["You are free to shoot, shoot the ball to the corner of the goal to get higher score","There are a simulation of keeper, you need to avoid the keeper by shooting away from keeper"]
    let gamePict = [    UIImage(named: "Free Mode"),
                        UIImage(named: "Keeper Mode")]
    
    let gameID = ["A","B"]

    override func viewDidLoad() {
        super.viewDidLoad()
 
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = Colors.orange
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = Colors.orange
        self.tabBarController?.tabBar.isHidden = false
        
        let firstCheck : Bool = UserDefaults.standard.bool(forKey: "check")
     
        imageTemp = UIImage(named: "profileTap")
        imageProfile.image = imageTemp
        roundedProfile()
        lblName.text = ""
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
        imageProfile.isUserInteractionEnabled = true
        imageProfile.addGestureRecognizer(tap)
        
        if(firstCheck == true){
            
            let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            imageProfile.image = UIImage(data: data as Data)
            imageProfile.transform = CGAffineTransform(rotationAngle: (90 * CGFloat.pi)/180)
            lblName.text = "Hi, " + (UserDefaults.standard.object(forKey: "savedName") as! String)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let firstCheck : Bool = UserDefaults.standard.bool(forKey: "check")
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = Colors.orange
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
        imageProfile.layer.borderColor = UIColor.orange.cgColor
        imageProfile.layer.borderWidth = 2.0
        imageProfile.layer.cornerRadius = imageProfile.frame.height/2
        imageProfile.clipsToBounds = true
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
        
        UserDefaults.standard.set(ID, forKey: "savedRootID")
        
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

class snappingLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        var offsetAdjusment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + (collectionView.bounds.width / 2)
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemHorizontalCenter = layoutAttributes.center.x
            
            if abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjusment) {
                if abs(velocity.x) < 10 { // minimum velocityX to trigger the snapping effect
                    offsetAdjusment = itemHorizontalCenter - horizontalCenter
                } else if velocity.x > 0 {
                    offsetAdjusment = itemHorizontalCenter - horizontalCenter + layoutAttributes.bounds.width
                } else { // velocity.x < 0
                    offsetAdjusment = itemHorizontalCenter - horizontalCenter - layoutAttributes.bounds.width
                }
            }
        })
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjusment, y: proposedContentOffset.y)
    }
}

