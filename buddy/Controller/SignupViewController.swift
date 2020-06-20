//
//  SigninViewController.swift
//  buddy
//
//  Created by Maggie Guan on 6/19/20.
//  Copyright © 2020 Maggie Guan. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class SignupViewController: UIViewController {

    
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet weak var LoginToggle: UILabel!

    @IBOutlet weak var fbSignin: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loginButton(_ fbSignin: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
      if let error = error {
        print(error.localizedDescription)
        return
      } else {
        performSegue(withIdentifier: "SignupToHabits", sender: self)
    }
      // ...
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print("error creating user, \(e)")
                } else{
                    self.performSegue(withIdentifier: "SignupToCode", sender: self)
                }
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
