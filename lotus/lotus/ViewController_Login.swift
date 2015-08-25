//
//  ViewController_Login.swift
//  lotus
//
//  Created by Cory Dickson on 8/9/15.
//
//

import UIKit

var user: User?

class ViewController_Login: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //User.logout()
        
        if(User.isLoggedIn().status) {
            user = User()
            //Skip login screen
            println("already logged in")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func twitterButtonPressed(sender: AnyObject) {
        if(User.isLoggedIn().status) {//TEMP: won't need logout function on this page
            Twitter.logout()
        }
        else {
            Twitter.login()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
