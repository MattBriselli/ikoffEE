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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .userFriends, .email ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
            print("good")
        } else {
            print("bad")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

