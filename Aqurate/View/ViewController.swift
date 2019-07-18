//
//  ViewController.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 29/06/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
   
    let gameMode = ["Free Mode","Keeper Mode"]
    let gameDetail = ["You are free to shoot, shoot the ball to the corner of the goal to get higher score","There are a simulation of keeper, you need to avoid the keeper by shooting away from keeper"]
    let gamePict = [    UIImage(named: "Free Mode"),
                        UIImage(named: "Keeper Mode")]
    
    let gameID = ["A","B"]
    
    var data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
    var infoImage : UIImageView!
    
    
    struct Const {
        static let ImageSizeForLargeState: CGFloat = 48
        static let ImageRightMargin: CGFloat = 20
        static let ImageBottomMarginForLargeState: CGFloat = 9
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
//        profileImageButton()
        
//        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
      //  statusBar.backgroundColor = Colors.orange
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        self.navigationController?.navigationBar.backgroundColor = Colors.orange
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileImageButton()
        
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        self.navigationController?.navigationBar.backgroundColor = Colors.orange
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       infoImage.isHidden = true
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
    
    func profileImageButton(){
        
        let firstCheck : Bool = UserDefaults.standard.bool(forKey: "check")
        
        if(firstCheck == true){
            
            data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            infoImage = UIImageView(image: UIImage(data: data as Data))
            navigationController?.navigationBar.addSubview(infoImage)
            infoImage.tag = 10
            infoImage.layer.cornerRadius = Const.ImageSizeForLargeState/2
            infoImage.clipsToBounds = true
            infoImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                infoImage.rightAnchor.constraint(equalTo: (navigationController?.navigationBar.rightAnchor)!, constant: -Const.ImageRightMargin),
                infoImage.bottomAnchor.constraint(equalTo: navigationController!.navigationBar.bottomAnchor,
                                                  constant: -Const.ImageBottomMarginForLargeState),
                infoImage.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
                infoImage.widthAnchor.constraint(equalToConstant: 53)
                ])
            infoImage.transform = CGAffineTransform(rotationAngle: (90 * CGFloat.pi)/180)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
            infoImage.isUserInteractionEnabled = true
            infoImage.addGestureRecognizer(tap)
            
        
        }
        
        if(firstCheck == false){
            infoImage.image = UIImage(named: "profileTap")
        }
    }
    
    @IBAction func unwindToHome(_ sender : UIStoryboardSegue) {
        
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
//        cell?.contentView.layer.borderWidth = 3.5
        //cell?.contentView.layer.borderColor = UIColor.orange.cgColor
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
        let IDs = indexPath.row
        let viewController = storyboard?.instantiateViewController(withIdentifier: ID)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
        UserDefaults.standard.set(IDs, forKey: "savedRootID")
        UserDefaults.standard.set(10, forKey: "savedFreeModeID")
        UserDefaults.standard.set(10, forKey: "savedKeeperModeID")
        
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

