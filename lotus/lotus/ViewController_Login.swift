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
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signBtn: UIButton!
    
    
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load background
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "placeholder.jpg")!.alpha(0.5))
        
        //loginBtn.titleLabel!.font =  UIFont(name: "Merriweather", size: 15)
        //ignBtn.titleLabel!.font =  UIFont(name: "Merriweater", size: 15)
        
        //add textfield elements to the gther login subview
        viewContainer.addSubview(emailField)
        viewContainer.addSubview(pwField)
        viewContainer.addSubview(emailClear)
        viewContainer.addSubview(pwClear)
        viewContainer.hidden = true
        loginBtn.hidden = true
        signBtn.hidden = true
        
        //keyboard notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardNotification:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        //set up buttons by adding gestures
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
        
        //tag text fields for identification
        emailField.tag = LOGIN_EMAIL_TAG
        pwField.tag = LOGIN_PW_TAG
        
        //style text fields
        styleTextField(emailField, 1.5, UIColor.whiteColor().CGColor, "Email")
        styleTextField(pwField, 1.5, UIColor.whiteColor().CGColor, "Password")
        
        
        //set the delagate to the view controller
        emailField.delegate = self
        pwField.delegate = self
        
        //setting next field property
        self.emailField.nextField = self.pwField
        
        //dismiss keyboard
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
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
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func keyboardNotification(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomViewConstraint.constant = keyboardFrame.size.height + 30
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomViewConstraint.constant = 173
        })
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //next field method
        if (textField == pwField) {
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
        
        viewContainer.hidden = false
        loginBtn.hidden = false
        signBtn.hidden = false
    }
    
    func tappedF() {
        //custom login button for facebook
        //hide gther login field
        gtherBtn.image = UIImage(named: "gtherbtn.png")
        viewContainer.hidden = true
        loginBtn.hidden = true
        signBtn.hidden = true

        
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
        viewContainer.hidden = true
        loginBtn.hidden = true
        signBtn.hidden = true
       
        
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
