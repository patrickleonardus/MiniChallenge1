//
//  ViewControllerProfiles.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 04/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewControllerProfiles: UIViewController{
    
    var image : UIImage?
    var name : String = ""
    var email : String = ""
    var gender : String = ""
    var DOB : String = ""
    var number : String = ""
    var pass : String = ""
    var check = false
    
    
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var emailProfile: UILabel!
    @IBOutlet weak var phoneProfile: UILabel!
    @IBOutlet weak var dobProfile: UILabel!
    @IBOutlet weak var genderProfile: UILabel!
    
    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var viewFormProfile: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstCheck : Bool = UserDefaults.standard.bool(forKey: "check")
        
//        self.navigationController?.navigationBar.backgroundColor = Colors.orange
//        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
        viewHeadAttribute()
        
        if(firstCheck == true){
            let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            imageProfile.image = UIImage(data: data as Data)
            nameProfile.text = (UserDefaults.standard.object(forKey: "savedName") as! String)
            emailProfile.text = (UserDefaults.standard.object(forKey: "savedEmail") as! String)
            dobProfile.text = (UserDefaults.standard.object(forKey: "savedDOB") as! String)
            genderProfile.text = (UserDefaults.standard.object(forKey: "savedGender") as! String)
            phoneProfile.text = (UserDefaults.standard.object(forKey: "savedNumber") as! String)
            roundedProfile()
        }
        
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.backgroundColor = Colors.orange
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.backgroundColor = Colors.orange
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//    }
    
    @IBAction func btnEditProfile(_ sender: Any) {
         performSegue(withIdentifier: "editProfile", sender: self)
    }
    
    @IBAction func btnSignOut(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure you want to log out?", message: nil , preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (UIAlertAction) in
            self.check = false
            UserDefaults.standard.set(self.check, forKey: "check")
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Home")
            self.navigationController?.pushViewController(viewController!, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    
    @IBAction func unwindToProfile(_ sender: UIStoryboardSegue){
    
        check = true
        
        let picture = image
        let imageData:NSData = picture!.pngData()! as NSData
        let namePerson = name.capitalizingFirstLetter()
        let emailPerson = email
        let dobPerson = DOB
        let genderPerson = gender
        let numberPerson = number
        let passPerson = pass
        
        UserDefaults.standard.set(imageData, forKey: "savedImage")
        UserDefaults.standard.set(namePerson, forKey: "savedName")
        UserDefaults.standard.set(emailPerson, forKey: "savedEmail")
        UserDefaults.standard.set(dobPerson, forKey: "savedDOB")
        UserDefaults.standard.set(genderPerson, forKey: "savedGender")
        UserDefaults.standard.set(numberPerson, forKey: "savedNumber")
        UserDefaults.standard.set(passPerson, forKey: "savedPassword")
        
        
        let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
        imageProfile.image = UIImage(data: data as Data)
        nameProfile.text = (UserDefaults.standard.object(forKey: "savedName") as! String)
        emailProfile.text = (UserDefaults.standard.object(forKey: "savedEmail") as! String)
        dobProfile.text = (UserDefaults.standard.object(forKey: "savedDOB") as! String)
        genderProfile.text = (UserDefaults.standard.object(forKey: "savedGender") as! String)
        phoneProfile.text = (UserDefaults.standard.object(forKey: "savedNumber") as! String)
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
    
    func viewHeadAttribute(){
        //viewHead.backgroundColor = Colors.orange
        viewHead.layer.shadowColor = UIColor.gray.cgColor
        viewHead.layer.shadowOffset = CGSize(width: 0, height: 10)
        viewHead.layer.shadowRadius = 8
        viewHead.layer.shadowOpacity = 0.5
        viewHead.layer.masksToBounds = false
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
