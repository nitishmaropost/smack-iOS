//
//  CreateAccountVC.swift
//  Smack
//
//  Created by maropost on 25/01/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
