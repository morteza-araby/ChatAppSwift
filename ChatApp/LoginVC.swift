//
//  ViewController.swift
//  ChatApp
//
//  Created by Morteza Araby on 25/09/16.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController {

    @IBOutlet weak var welcomelbl: UILabel!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginBtn_click(_ sender: AnyObject) {
        
        PFUser.logInWithUsername(inBackground: usernameTxt.text!, password: passwordTxt.text!, block: { (user: PFUser?, error: Error?) in
            
            // some your code
            if error == nil {
                print("logged in")
                self.performSegue(withIdentifier: "goToUsersVC", sender: self)
            } else {
                print("Error in login")
            }
            
        })
        
        /*
        PFUser.logInWithUsername(inBackground: usernameTxt.text!, password: passwordTxt.text!, block: {
            (user:PFUser?, logInError:NSError?) -> Void in
            if logInError == nil {
                print("logged in")
            } else {
                print("Error in login")
            }
        })*/
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

