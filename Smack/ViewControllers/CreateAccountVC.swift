//
//  CreateAccountVC.swift
//  Smack
//
//  Created by maropost on 25/01/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAccountBtnPressed(_ sender: UIButton) {
        guard let email = emailTxt.text, emailTxt.text != "" else {
            return
        }
        
        guard let password = passwordTxt.text, passwordTxt.text != "" else {
            return
        }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("User registered !")
            }
        }
    }
    
    
    @IBAction func chooseAvatarBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func pickBGColorPressed(_ sender: UIButton) {
        
    }
    
}
