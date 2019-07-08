//
//  ViewControllerProfiles.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 04/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewControllerProfiles: UIViewController {

    
    var image : UIImage?
    var name : String = ""
    var check = false
    
    let firstCheck : Bool = UserDefaults.standard.bool(forKey: "check")
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var viewHead: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = Colors.orange
        self.navigationController?.navigationBar.tintColor = UIColor.white
        viewHead.backgroundColor = Colors.orange
        
        
        if(firstCheck == true){
            let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            imageProfile.image = UIImage(data: data as Data)
            nameProfile.text = UserDefaults.standard.object(forKey: "savedName") as! String
            roundedProfile()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
     
    @IBAction func btnEditProfile(_ sender: Any) {
         performSegue(withIdentifier: "editProfile", sender: self)
    }
    
    
    @IBAction func unwindToProfile(_ sender: UIStoryboardSegue){
    
        check = true
        
        let picture = image
        let namePerson = name.capitalizingFirstLetter()
        let imageData:NSData = picture!.pngData()! as NSData
        
        UserDefaults.standard.set(imageData, forKey: "savedImage")
        UserDefaults.standard.set(namePerson, forKey: "savedName")
        
        let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
        
        imageProfile.image = UIImage(data: data as Data)
        nameProfile.text = UserDefaults.standard.object(forKey: "savedName") as! String
        UserDefaults.standard.set(check, forKey: "check")
        
        roundedProfile()
        
    }
    
    func roundedProfile(){
        imageProfile.layer.borderWidth = 1
        imageProfile.layer.masksToBounds = false
        imageProfile.layer.borderColor = UIColor.white.cgColor
        imageProfile.layer.borderWidth = 2.5
        imageProfile.layer.cornerRadius = imageProfile.frame.height/2
        imageProfile.clipsToBounds = true
        imageProfile.transform = CGAffineTransform(rotationAngle: (90 * CGFloat.pi)/180)
    }
    
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
