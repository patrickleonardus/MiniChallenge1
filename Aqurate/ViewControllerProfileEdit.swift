//
//  ViewControllerProfileEdit.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 04/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class ViewControllerProfileEdit: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameProfile: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = Colors.orange
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewControllerProfileEdit.tapFunction))
        imageProfile.isUserInteractionEnabled = true
        imageProfile.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(true, animated: true)
      self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        if(nameProfile.text == ""){
            let alert = UIAlertController(title: "Warning", message: "Name must be filled!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewControllerProfiles
        destination.image = imageProfile.image
        destination.name = nameProfile.text!
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageProfile.image = image
            roundedProfile()
        }
        else{
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer){
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image,animated: true){}
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
