//
//  ViewController.swift
//  koffEE
//
//  Created by Matt Briselli on 3/25/17.
//  Copyright © 2017 Matt Briselli. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FacebookCore
import FacebookLogin
import FacebookShare
import SocketIO

class ViewController: UIViewController {
    
    @IBOutlet var emailLogin: UIButton!
    @IBOutlet var fbLogin: UIButton!
    @IBOutlet var emailSignUp: UIButton!
    
    
    override func viewDidLoad() {
        FIRApp.configure()
        
        if (loggedIn()) {
            
        } else {
            emailLogin.layer.cornerRadius = 10
            fbLogin.layer.cornerRadius = 10
            emailSignUp.layer.cornerRadius = 10
        
            fbLogin.backgroundColor = UIColor.init(red: 59, green: 89, blue: 152, alpha: 1)
            fbLogin.center = view.center
        }
    }
    
    func loggedIn() -> Bool {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        //3
        do {
            let people = try managedContext.fetch(fetchRequest)
            print(people[0].value(forKey: "username"), people[0].value(forKey: "password"))
            return true
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    @IBAction func loginButtonClickedFB(_ sender: Any) {
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
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainView")
                self.present(mainViewController, animated:true, completion:nil)
            }
        }
    }
    
//    @IBAction func signInPrssed(_ sender: Any) {
//        guard let appDelegate =
//            UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//            
//        // 1
//        let managedContext =
//            appDelegate.persistentContainer.viewContext
//            
//        // 2
//        let entity =
//            NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
//            
//        let person = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
//            
//        // 3
////        person.setValue(userName.text, forKeyPath: "username")
////        person.setValue(password.text, forKeyPath: "password")
//        
//        // 4
//        do {
//            try managedContext.save()
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainView")
//            self.present(mainViewController, animated:true, completion:nil)
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

