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
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var submitButton: UIButton!
    
    override func viewDidLoad() {
        FIRApp.configure()
        
        submitButton.layer.cornerRadius = 10
        
        let loginButton = UIButton(type: .custom)
        loginButton.backgroundColor = UIColor.init(red: 59, green: 89, blue: 152, alpha: 1)
        loginButton.center = view.center
        loginButton.frame = CGRect(x: view.center.x-90, y: view.center.y+75, width: 180, height: 45)
        loginButton.layer.cornerRadius = 10
        loginButton.titleLabel?.textColor = UIColor.black
        loginButton.setTitle("Login with Facebook", for: .normal)
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
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    // ...
                    if let error = error {
                        // ...
                        print("error 2")
                    }
                }
                print("success")
            }
        }
    }
    
    @IBAction func signInPrssed(_ sender: Any) {
        print(userName.text)
        print(password.text)
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

