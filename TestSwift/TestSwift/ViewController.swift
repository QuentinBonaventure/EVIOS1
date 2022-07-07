//
//  ViewController.swift
//  TestSwift
//
//  Created by Student02 on 07/07/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var userImage:  UIImageView!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var passwordImage: UIImageView!
    @IBOutlet var loginField: UITextField!
    @IBOutlet var switchButton: UISwitch!
    @IBOutlet var downloadIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let recognizer =  UITapGestureRecognizer(target:self, action: #selector(changePasswordField))
        recognizer.numberOfTapsRequired = 1
        passwordImage.addGestureRecognizer(recognizer)
        downloadIndicator.isHidden = true
        loginField.delegate = self
        passwordField.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userImage.makeRounded()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    
    @objc func changePasswordField(){
        if(passwordField.isSecureTextEntry == true){
            passwordField.isSecureTextEntry = false
            passwordImage.image = UIImage(named: "eye_off_icon")
        }else{
            passwordField.isSecureTextEntry = true
            passwordImage.image = UIImage(named: "eye_on_icon")
        }
        
        
    }
     func showAlert() {
        if(switchButton.isOn == true){
            let alert = UIAlertController(title: "Bienvenue \(loginField.text?.uppercased() ?? "")", message: "Vous vous êtes inscrit à la newsletter", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Merci", style: .default, handler: nil))
            present(alert, animated: true)
        }else{
            let alert = UIAlertController(title: "Bienvenue \(loginField.text?.uppercased() ?? "")", message: "Vous n'êtes pas inscrit à la newsletter", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Merci", style: .default, handler: nil))
            present(alert, animated: true)
           
           
        }
        
        
        
     }
    
    
    @IBAction func saveUser(){
        print(loginField.text ?? "")
        
        print(passwordField.text ?? "")
        print("Le user : \(loginField.text ?? "") dont le mot de passe est \(passwordField.text ?? "") est il inscrit à la newsletter?  \(switchButton.isOn)")
    }
    
    func showError(){
        let alert = UIAlertController(title: "ERROR", message: "Une desconditions de saisie n'est pas respectée", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retour", style: .default, handler: nil))
        present(alert, animated: true)
        
    }
    
    @IBAction func verifyField(){
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@",  emailRegex)
        
            if(predicate.evaluate(with: loginField.text) &&  passwordField.text?.count ?? 0 >= 4 ){
          performLogin()
            }else{
                showError()
            }
        
    }
    
    func performLogin(){
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.downloadIndicator.isHidden = false
                self.downloadIndicator.startAnimating()
            }
            sleep(3)
           
            
            DispatchQueue.main.async {
                self.showAlert()
                
                self.downloadIndicator.isHidden = true
                self.downloadIndicator.stopAnimating()
            }
            
        }
        
    }
   
 

}

extension UIImageView{
    
    func makeRounded(){
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
    
    
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginField {
            passwordField.becomeFirstResponder()
        }else if textField == passwordField {
            view.endEditing(true)
        }
        return true
            
    }
}

