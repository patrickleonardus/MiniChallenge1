//
//  ViewControllerLogin.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 09/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController {

    
    @IBOutlet weak var inputUsername: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    
    let generator = UINotificationFeedbackGenerator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = Colors.orange
        self.navigationController?.navigationBar.tintColor = UIColor.white

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    override func viewWillDisappear(_ animated: Bool) {
       
    }
    
    
    @IBAction func btnRegister(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "profileEdit")
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        let checkUser = UserDefaults.standard.string(forKey: "savedName")
        let checkPass = UserDefaults.standard.string(forKey: "savedPassword")
        var errorCheck = false
        
        if(inputUsername.text == ""){
            let placeholder = NSAttributedString(string: "This field must be filled", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            inputUsername.attributedPlaceholder = placeholder
            
            inputUsername.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            
            generator.notificationOccurred(.error)
            
            errorCheck = true
        }
        if(inputPassword.text == ""){
            let placeholder = NSAttributedString(string: "This field must be filled", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            inputPassword.attributedPlaceholder = placeholder
            
            inputPassword.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            
            generator.notificationOccurred(.error)
            
                
            errorCheck = true
        }
        if(errorCheck == false){
            if(inputUsername.text != checkUser){
                let placeholder = NSAttributedString(string: "Check your username again", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
                inputUsername.attributedPlaceholder = placeholder
                generator.notificationOccurred(.error)
                
                inputUsername.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            }
            if(inputPassword.text != checkPass){
                let placeholder = NSAttributedString(string: "Check your password again", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
                inputPassword.attributedPlaceholder = placeholder
                generator.notificationOccurred(.error)
                
                inputPassword.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            }
            if(inputUsername.text == checkUser && inputPassword.text == checkPass){
                let check = true
                UserDefaults.standard.set(check, forKey: "check")
                
                let viewController = storyboard?.instantiateViewController(withIdentifier: "Home")
                self.navigationController?.pushViewController(viewController!, animated: true)
            }
        }
        
    }
    
  

}
