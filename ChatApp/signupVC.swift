//
//  signupVC.swift
//  ChatApp
//
//  Created by Morteza Araby on 25/09/16.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import UIKit
import Parse

class signupVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var addImgBtn: UIButton!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var profileNameTxt: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTxt.delegate = self
        passwordTxt.delegate = self
        profileNameTxt.delegate = self
        // Do any additional setup after loading the view.
//        profileimg.center = CGPoint(x: view.frame.size.width/2, y: 140)
//        profileimg.layer.cornerRadius = profileimg.frame.size.width/2
//        profileimg.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addImgBtnClick(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = true
        self.present(image, animated: true, completion: nil)
        //self.presentedViewController(image, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        profileimg.image = (info[UIImagePickerControllerOriginalImage] as! UIImage)
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
        profileNameTxt.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        if(UIScreen.main.bounds.height == 568) { // iphon 5
            if(textField == self.profileNameTxt){
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                    self.view.center = CGPoint(x: theWidth/2, y: (theHeight/2)-40)
                    }, completion: { (finished:Bool) in
                        
                })
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        if(UIScreen.main.bounds.height == 568) { // iphon 5
            if(textField == self.profileNameTxt){
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                    self.view.center = CGPoint(x: theWidth/2, y: (theHeight/2))
                    }, completion: { (finished:Bool) in
                        
                })
            }
        }
    }
    
    
    @IBAction func signupBtn_click(_ sender: AnyObject) {
        let user = PFUser()
        user.username = usernameTxt.text
        user.password = passwordTxt.text
        user.email = usernameTxt.text
        user["profileName"] = profileNameTxt.text
        
        let imageData = UIImagePNGRepresentation(self.profileimg.image!)
        let imageFile = PFFile(name: "profilePhoto.png", data: imageData!)
        user["photo"] = imageFile
        
        
        // Signing up using the Parse API
        user.signUpInBackground {
            (success, error) -> Void in
            if let error = error as NSError? {
                let errorString = error.userInfo["error"] as? NSString
                // In case something went wrong, use errorString to get the error
                print(errorString)
            } else {
                // Everything went okay
                print("signed up")
                self.performSegue(withIdentifier: "goToUsersVC2", sender: self)
            }
        }
        

        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
