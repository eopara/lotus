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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTextField(fnTextField, 3.0, UIColor.blackColor().CGColor)
        
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
