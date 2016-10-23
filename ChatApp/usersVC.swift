//
//  usersVC.swift
//  ChatApp
//
//  Created by Morteza Araby on 2016-10-23.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import UIKit
import Parse

var userName = ""

class usersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var resultsTable: UITableView!
    
    var resultsUsernameArray = [String]()
    var resultsProfileArray = [String]()
    var resultsImageFiles = [PFFile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
        userName = PFUser.current()!.username!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let predicate = NSPredicate(format: "username != '"+userName+"'")
        let query = PFQuery(className: "_User", predicate: predicate)
        
        let objects = try! query.findObjects()
        
        for object in objects {
            let us:PFUser = object as! PFUser
            self.resultsUsernameArray.append(us.username!)
            self.resultsProfileArray.append(object["profileName"] as! String)
            self.resultsImageFiles.append(object["photo"] as!PFFile)
            
            self.resultsTable.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsUsernameArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell : resultsCell = (tableView.dequeueReusableCell(withIdentifier: "Cell") as? resultsCell)!
        
        cell.usernameLbl.text = self.resultsUsernameArray[indexPath.row]
        cell.profileNameLbl.text = self.resultsProfileArray[indexPath.row]
        

        resultsImageFiles[indexPath.row].getDataInBackground(block: {
            (imageData: Data?, error: Error?) in
            if error == nil {
                let image = UIImage(data: imageData!)
                cell.profileImg.image = image
            }else{
                print("Error load image")
            }
        })
        
        
        return cell
    }
    
    
    @IBAction func logoutBtn_click(_ sender: AnyObject) {
        PFUser.logOut()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
