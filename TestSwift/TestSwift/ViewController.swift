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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let recognizer =  UITapGestureRecognizer(target:self, action: #selector(changePasswordField))
        recognizer.numberOfTapsRequired = 1
        passwordImage.addGestureRecognizer(recognizer)
        
        
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
        
        print("test ok ")
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

