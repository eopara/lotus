//
//  ViewController_Profile.swift
//  lotus
//
//  Created by Cory Dickson on 8/9/15.
//
//

import UIKit

class ViewController_Profile: UIViewController {

    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var fnTextField: UITextField!
    @IBOutlet weak var lnTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "profile_background.jpg")!) //not using imageview
        styleTextField(fnTextField, 1.5, UIColor.whiteColor().CGColor)
        styleTextField(lnTextField, 1.5, UIColor.whiteColor().CGColor)
        styleTextField(zipTextField, 1.5, UIColor.whiteColor().CGColor)
        styleTextField(dayTextField, 1.5, UIColor.whiteColor().CGColor)
        styleTextField(monthTextField, 1.5, UIColor.whiteColor().CGColor)
        styleTextField(yearTextField, 1.5, UIColor.whiteColor().CGColor)
        fnTextField.attributedPlaceholder = NSAttributedString(string:"First Name",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        lnTextField.attributedPlaceholder = NSAttributedString(string:"Last Name",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        zipTextField.attributedPlaceholder = NSAttributedString(string:"Zip",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        dayTextField.attributedPlaceholder = NSAttributedString(string:"Day",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        monthTextField.attributedPlaceholder = NSAttributedString(string:"Month",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        yearTextField.attributedPlaceholder = NSAttributedString(string:"Year",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
