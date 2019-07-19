//
//  ViewControllerKeeperMode.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 08/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewControllerKeeperMode: UIViewController {

    @IBOutlet weak var collectionViewCellKeeperMode: UICollectionView!
    
    let keeperModePict = [UIImage(named: "semi"),UIImage(named: "pro")]
    let difficultyName = ["Semi-Pro","Professional"]
    let difficultyDescription = ["Choose this level for the easier step, you will get a goal box divided by 6 boxes","Pick this level to be a professional shooter, the goal box will be divided by 9 boxes"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hidesBottomBarWhenPushed = true
        self.tabBarController?.tabBar.isHidden = true

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
}


extension ViewControllerKeeperMode :  UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return difficultyName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellKeeperMode", for: indexPath) as? CollectionViewCellKeeperMode
        
        cell?.mode.text = difficultyName[indexPath.row]
        cell?.image.image = keeperModePict[indexPath.row]
        cell?.detail.text = difficultyDescription[indexPath.row]
        cell?.image.layer.cornerRadius = 10.0
        cell?.contentView.layer.cornerRadius = 10
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
        
        detailedScore = []
        gameScore = 0
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "Tips")
        self.navigationController?.pushViewController(viewController!, animated: true)
        
        let ID = indexPath.row
        UserDefaults.standard.set(ID, forKey: "savedKeeperModeID")
    }
    
    
    
}
