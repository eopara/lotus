//
//  ViewController_Login.swift
//  lotus
//
//  Created by Cory Dickson on 8/9/15.
//
//

import UIKit
let LOGIN_EMAIL_TAG = 1
let LOGIN_PW_TAG = 2

let IMAGE_GTHER_TAG = 3
let IMAGE_FB_TAG = 4
let IMAGE_TWITTER_TAG = 5



var user: User?

class ViewController_Login: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    @IBOutlet weak var gtherBtn: UIImageView!
    @IBOutlet weak var fbBtn: UIImageView!
    @IBOutlet weak var twitterBtn: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var emailClear: UIImageView!
    @IBOutlet weak var pwClear: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "placeholder.jpg")!.alpha(0.5))
        
        let tapGther = UITapGestureRecognizer(target: self, action: Selector("tappedG"))
        
        let tapFb = UITapGestureRecognizer(target: self, action: Selector("tappedF"))
        
        let tapTwitter = UITapGestureRecognizer(target: self, action: Selector("tappedT"))
        
        gtherBtn.addGestureRecognizer(tapGther)
        gtherBtn.userInteractionEnabled = true
        gtherBtn.tag = IMAGE_GTHER_TAG
        
        twitterBtn.addGestureRecognizer(tapTwitter)
        twitterBtn.userInteractionEnabled = true
        twitterBtn.tag = IMAGE_TWITTER_TAG
        
        fbBtn.addGestureRecognizer(tapFb)
        fbBtn.userInteractionEnabled = true
        fbBtn.tag = IMAGE_FB_TAG
        
        emailField.tag = LOGIN_EMAIL_TAG
        pwField.tag = LOGIN_PW_TAG
        //style text fields
        styleTextField(emailField, 1.5, UIColor.whiteColor().CGColor, "Email")
        styleTextField(pwField, 1.5, UIColor.whiteColor().CGColor, "Password")
        
        //hide gther login field
        emailField.hidden = true
        pwField.hidden = true
        emailClear.hidden = true
        pwClear.hidden = true
        
        //set the delagate to the view controller
        emailField.delegate = self
        pwField.delegate = self
        
        //setting next field property
        self.emailField.nextField = self.pwField
        
        // Do any additional setup after loading the view.
        
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //next field method
        if (textField == emailField) {
            textField.resignFirstResponder()
        }
        else {
            textField.nextField?.becomeFirstResponder()
        }
        
        return true
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if ((error) != nil) {
            // Process error
            println("Error: \(error)")
        }
        else if result.isCancelled {
            // Handle cancellations
            println("Cancelled")
        }
        else {
            Facebook.login()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        Facebook.logout()
    }
    
    func tappedG() {
        
        
        gtherBtn.image = UIImage(named: "gtherbtn_white.png")
        
        //enable login fields
        emailField.hidden = false
        pwField.hidden = false
        emailClear.hidden = false
        pwClear.hidden = false
    }
    
    func tappedF() {
        //custom login button for facebook
        //hide gther login field
        gtherBtn.image = UIImage(named: "gtherbtn.png")
        emailField.hidden = true
        pwField.hidden = true
        emailClear.hidden = true
        pwClear.hidden = true
        
        var fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager .logInWithReadPermissions(["email"], handler: { (result, error) -> Void in
            if (error == nil){
                var fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    fbLoginManager.logOut()
                }
            }
        })
    }
    
    
    func getFBUserData(){
        //gets the user data from the token from login
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    println(result)
                }
            })
        }
    }
    
    
    func tappedT() {
        println("t")
        //hide gther login field
        gtherBtn.image = UIImage(named: "gtherbtn.png")
        emailField.hidden = true
        pwField.hidden = true
        emailClear.hidden = true
        pwClear.hidden = true
        
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
