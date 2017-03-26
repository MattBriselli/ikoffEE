//
//  ViewController.swift
//  koffEE
//
//  Created by Matt Briselli on 3/25/17.
//  Copyright © 2017 Matt Briselli. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FacebookCore
import FacebookLogin
import FacebookShare

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        let auth = FIRAuth.auth()
        
        let loginButton = UIButton(type: .custom)
        loginButton.backgroundColor = UIColor.darkGray
        loginButton.center = view.center
        loginButton.frame = CGRect(x: view.center.x-90, y: view.center.y, width: 180, height: 45)
        loginButton.setTitle("FB Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonClicked(button:)), for: .touchUpInside)
        
        view.addSubview(loginButton)
    }
    
    @objc func loginButtonClicked(button: UIButton) {
        let loginManager = LoginManager()
        loginManager.loginBehavior = LoginBehavior.systemAccount
        loginManager.logIn([ .publicProfile, .email, .userFriends ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                print(credential)
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

