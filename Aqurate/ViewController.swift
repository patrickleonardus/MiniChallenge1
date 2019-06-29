//
//  ViewController.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 29/06/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var nameTemp : String = ""
    var imageTemp : UIImage?
   
    let gameMode = ["Free Mode","Keeper Mode","Hint"]
    let gameDetail = ["You are free to shoot, shoot the ball to the corner of the goal to get higher score","There are a simulation of keeper, you need to avoid the keeper by shooting away from keeper","You can improve your futsal knowledge here"]
    let gamePict = [    UIImage(named: "Free Mode"),
                        UIImage(named: "Keeper Mode"),
                        UIImage(named: "Hint")]
    
    let gameID = ["A","B","C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        lblName.text = "Hi, " + nameTemp
        imageProfile.image = imageTemp
        roundedProfile()
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func roundedProfile(){
        imageProfile.layer.borderWidth = 1
        imageProfile.layer.masksToBounds = false
        imageProfile.layer.borderColor = UIColor.black.cgColor
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
        
        cell?.contentView.layer.cornerRadius = 5.0
        cell?.contentView.layer.borderWidth = 2.0
        cell?.contentView.layer.borderColor = UIColor.clear.cgColor
        cell?.contentView.layer.masksToBounds = false
        cell?.layer.shadowColor = UIColor.gray.cgColor
        cell?.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell?.layer.shadowRadius = 4.0
        cell?.layer.shadowOpacity = 1.0
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

