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
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAccountBtnPressed(_ sender: UIButton) {
        guard let name = userNameTxt.text, userNameTxt.text != "" else {
            return
        }
        
        guard let email = emailTxt.text, emailTxt.text != "" else {
            return
        }
        
        guard let password = passwordTxt.text, passwordTxt.text != "" else {
            return
        }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("User registered !")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            } else {
                                print("Error while adding user")
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func chooseAvatarBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBGColorPressed(_ sender: UIButton) {
        
    }
    
}
