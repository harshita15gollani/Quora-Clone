//
//  SignUpViewController.swift
//  Quora
//
//  Created by Harshita Gollani on 07/08/22.
//

import UIKit
import UniformTypeIdentifiers
class SignUpViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    
    @IBOutlet weak var name: UITextField!
    
   
    
    @IBOutlet weak var userImage: UIButton!
    
    @IBOutlet weak var userDescription: UITextView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    
    @IBOutlet weak var male: UIButton!
    
    @IBOutlet weak var female: UIButton!
    
    
    @IBOutlet weak var publicAccount: UIButton!
    
    @IBOutlet weak var privateAccount: UIButton!
    
    
    @IBOutlet weak var corporateAccount: UIButton!
    
    
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var phoneError: UILabel!
    @IBOutlet weak var signUp: UIButton!
    
    var gender: String = "Male"
    var accountTypeUser: String = "Public"
    @IBAction func male(_ sender: Any) {
        male.setTitleColor(.red, for:.normal)
        female.setTitleColor(.systemGray, for:.normal)
        gender = "Male"
    }
    
    
    @IBAction func female(_ sender: Any) {
        
        female.setTitleColor(.red, for:.normal)
        male.setTitleColor(.systemGray, for:.normal)
        gender = "Female"
    }
    @IBAction func userImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
                pickerController.sourceType = .photoLibrary
                pickerController.mediaTypes = [UTType.video.identifier, UTType.image.identifier]
                pickerController.allowsEditing = true
                pickerController.delegate = self
                present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
            print(mediaType)
            switch mediaType {
            case "public.image":
                print("image selected")
                let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
                self.userImage.setBackgroundImage(editedImage, for: .normal)
            default:
                print("asdasdasd")
            }
            picker.dismiss(animated: true, completion: nil)
        }
    
    @IBAction func publicAccount(_ sender: Any) {
        publicAccount.setTitleColor(.red, for:.normal)
        privateAccount.setTitleColor(.systemGray, for:.normal)
        corporateAccount.setTitleColor(.systemGray, for:.normal)
        accountTypeUser = "Public"
    }
    
    
    @IBAction func privateAccount(_ sender: Any) {
        privateAccount.setTitleColor(.red, for:.normal)
        publicAccount.setTitleColor(.systemGray, for:.normal)
        corporateAccount.setTitleColor(.systemGray, for:.normal)
        accountTypeUser = "Private"
    }
    
    @IBAction func corporateAccount(_ sender: Any) {
        corporateAccount.setTitleColor(.red, for:.normal)
        publicAccount.setTitleColor(.systemGray, for:.normal)
        privateAccount.setTitleColor(.systemGray, for:.normal)
        accountTypeUser = "Corporate"
    }
    
    
    @IBAction func emailField(_ sender: Any) {
        if let emailValue = email.text{
            if let errorMessage = invalidEmail(emailValue){
                emailError.text = errorMessage
                emailError.isHidden = false
            }
            else{
                emailError.isHidden = true
            }
        }
        checkValidForm()
    }
    func invalidEmail(_ value: String) -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: value){
            return nil
        }
        return "Invalid email"
    }
    @IBAction func passwordField(_ sender: Any) {
        if let passwordValue = password.text
        {
            if let errorMessage = invalidPassword(passwordValue){
                passwordError.text = errorMessage
                passwordError.isHidden = false
            }
            else{
                passwordError.isHidden = true
            }
        }
        checkValidForm()
    }
    func invalidPassword(_ value: String) -> String?
    {
        if value.count < 8 {
            return "Must be atleast 8 characters"
        }
        if containsDigit(value){
            return "Must contain atleast 1 digit"
        }
        if containsLowerCase(value){
            return "Must contain atleast 1 lowercase character"
        }
        if containsUpperCase(value){
            return "Must contain atleast 1 uppercase character"
        }
        return nil
    }
    func containsDigit(_ value: String) -> Bool{
        let passwordRegEx = ".*[0-9]+.*"
            let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return !passwordPred.evaluate(with: value)
        
    }
    func containsLowerCase(_ value: String) -> Bool{
        let passwordRegEx = ".*[a-z]+.*"
            let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return !passwordPred.evaluate(with: value)
        
    }
    func containsUpperCase(_ value: String) -> Bool{
        let passwordRegEx = ".*[A-Z]+.*"
            let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return !passwordPred.evaluate(with: value)
        
    }
    func invalidPhoneNumber(_ value: String) -> String? {
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set){
            return "Must contain only digits"
        }
        if value.count != 10 {
            return "Must be 10 digits"
        }
        return nil
    }
    
    @IBAction func phoneField(_ sender: Any) {
        if let phoneNumber = phoneNum.text{
            if let errorMessage = invalidPhoneNumber(phoneNumber){
                phoneError.text = errorMessage
                phoneError.isHidden = false
            }
            else{
                phoneError.isHidden = true
            }
        }
        checkValidForm()
    }
    
    func checkValidForm() {
        if  emailError.isHidden && passwordError.isHidden && phoneError.isHidden {
            signUp.isEnabled = true
        } else {
            signUp.isEnabled = false
        }
    }
    
    @IBAction func signUpField(_ sender: Any) {
        
        guard let url = URL(string: "http://10.20.4.131:8080/account/createAccount/") else {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let body: [String: String] = [
                    //"accountId":"1",
                    "userName" : name.text!,
                    "email": email.text!,
                    "password": password.text!,
                    "phoneNumber":phoneNum.text!,
                    "gender": gender,
                    "accountType": accountTypeUser,
                    "profileImage":"https://avatars.githubusercontent.com/u/69767?v=4",
                    "description": userDescription.text
                    
                ]
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
                //request.setValue("application/json", forHTTPHeaderField: "Authorization")
                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    guard let data = data,error == nil else{
                        return
                    }
                    do{
                        let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        print("Success: \(response)")
                    }
                    catch {
                        print(error)
                    }
                }
                task.resume()

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
        self.navigationController?.isNavigationBarHidden = false
        signUp.layer.cornerRadius = 5
        signUp.layer.borderColor = UIColor.black.cgColor
        signUp.layer.borderWidth = 1.0
        name.delegate = self
        email.delegate = self
        password.delegate = self
        phoneNum.delegate = self
        //userImage.layer.cornerRadius = 25.0

    }
    
    func resetForm(){
        signUp.isEnabled = false
        emailError.isHidden = false
        phoneError.isHidden = false
        passwordError.isHidden = false
        emailError.text = "Required"
        phoneError.text = "Required"
        passwordError.text = "Required"
        email.text = ""
        password.text = ""
        phoneNum.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
