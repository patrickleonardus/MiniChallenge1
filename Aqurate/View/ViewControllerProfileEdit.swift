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
    @IBOutlet weak var emailProfile: UITextField!
    @IBOutlet weak var dobProfile: UITextField!
    @IBOutlet weak var genderProfile: UITextField!
    @IBOutlet weak var phoneProfile: UITextField!
    @IBOutlet weak var passwordProfile: UITextField!
    
    var errorCheck = false
    var check = false
    
    var datePicker = UIDatePicker()
    var genderPicker = UIPickerView()
    
    let genderData = ["Male","Female"]
    
    let generator = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = Colors.orange
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewControllerProfileEdit.tapFunction))
        imageProfile.isUserInteractionEnabled = true
        imageProfile.addGestureRecognizer(tap)
        
        dobDatePicker()
        genderPick()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        
        errorCheck = false
        
        if(nameProfile.text == ""){
            
            let placeholder = NSAttributedString(string: "This field must be filled", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            nameProfile.attributedPlaceholder = placeholder
            generator.notificationOccurred(.error)
            nameProfile.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            errorCheck = true
        }
        
        if(emailProfile.text == ""){
            
            let placeholder = NSAttributedString(string: "This field must be filled", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            emailProfile.attributedPlaceholder = placeholder
            generator.notificationOccurred(.error)
            emailProfile.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            errorCheck = true
        }
        if(dobProfile.text == ""){
            let placeholder = NSAttributedString(string: "This field must be filled", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            dobProfile.attributedPlaceholder = placeholder
            generator.notificationOccurred(.error)
            dobProfile.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            errorCheck = true
        }
        if(genderProfile.text == ""){
            let placeholder = NSAttributedString(string: "This field must be filled", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            genderProfile.attributedPlaceholder = placeholder
            generator.notificationOccurred(.error)
            genderProfile.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            errorCheck = true
        }
        
        if(phoneProfile.text == ""){
            let placeholder = NSAttributedString(string: "This field must be filled", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            phoneProfile.attributedPlaceholder = placeholder
            generator.notificationOccurred(.error)
            phoneProfile.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            errorCheck = true
        }
        if(passwordProfile.text == ""){
            let placeholder = NSAttributedString(string: "This field must be filled", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            passwordProfile.attributedPlaceholder = placeholder
            generator.notificationOccurred(.error)
            passwordProfile.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            errorCheck = true
        }
        
        if(errorCheck == false){
            if let vcs = self.navigationController?.viewControllers {
                let previousVC = vcs[vcs.count - 2]
                if previousVC is ViewControllerProfiles {
                    performSegue(withIdentifier: "unwindFromProfile", sender: self)
                }
                if previousVC is ViewControllerLogin {
                    check = true
                    let picture = imageProfile.image
                    let imageData:NSData = picture!.pngData()! as NSData
                    let namePerson = nameProfile.text?.capitalizingFirstLetter()
                    let emailPerson = emailProfile.text
                    let dobPerson = dobProfile.text
                    let genderPerson = genderProfile.text
                    let numberPerson = phoneProfile.text
                    let passwordPerson = passwordProfile.text
                    
                    UserDefaults.standard.set(imageData, forKey: "savedImage")
                    UserDefaults.standard.set(namePerson, forKey: "savedName")
                    UserDefaults.standard.set(emailPerson, forKey: "savedEmail")
                    UserDefaults.standard.set(dobPerson, forKey: "savedDOB")
                    UserDefaults.standard.set(genderPerson, forKey: "savedGender")
                    UserDefaults.standard.set(numberPerson, forKey: "savedNumber")
                    UserDefaults.standard.set(passwordPerson, forKey: "savedPassword")
                    UserDefaults.standard.set(check, forKey: "check")
                    
                    performSegue(withIdentifier: "backToProfile", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewControllerProfiles
        destination.image = imageProfile.image
        destination.name = nameProfile.text!
        destination.email = emailProfile.text!
        destination.DOB = dobProfile.text!
        destination.gender = genderProfile.text!
        destination.pass = passwordProfile.text!
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
    
    func dobDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(ViewControllerProfileEdit.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewControllerProfileEdit.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        
        dobProfile.inputView = datePicker
    }
    
    @objc func dateChanged(datePicker : UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dobProfile.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func genderPick(){
        genderProfile.inputView = genderPicker
        genderPicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewControllerProfileEdit.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
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

extension ViewControllerProfileEdit : UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderProfile.text = genderData[row]
    }
    
}

extension UITextField {
    func setBottomBorderOnlyWith(color: CGColor) {
        self.borderStyle = .none
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 1
    }
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")
        
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
}
