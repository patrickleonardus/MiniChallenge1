//
//  ViewControllerSignUp.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 29/06/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewControllerSignUp: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputImageProfile: UIImageView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        inputImageProfile.image = UIImage(named: "profileicon")
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let passingData = segue.destination as! ViewController
        passingData.nameTemp = inputName.text!
        passingData.imageTemp = inputImageProfile.image!
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if(inputName.text != ""){
            if(inputName.text!.count <= 3){
                let alert = UIAlertController(title: "Warning", message: "Please check your name before continue!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            else{
              performSegue(withIdentifier: "segue1-2", sender:  self)
            }
        }
            
        else if(inputName.text == ""){
            let alert = UIAlertController(title: "Warning", message: "Please fill your name before continue!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
    }
    
    @IBAction func btnAddImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image,animated: true){
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            inputImageProfile.image = image
            roundedProfile()
        }
        else{
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func roundedProfile(){
        inputImageProfile.layer.borderWidth = 1
        inputImageProfile.layer.masksToBounds = false
        inputImageProfile.layer.borderColor = UIColor.black.cgColor
        inputImageProfile.layer.cornerRadius = inputImageProfile.frame.height/2
        inputImageProfile.clipsToBounds = true
    }
    
}
