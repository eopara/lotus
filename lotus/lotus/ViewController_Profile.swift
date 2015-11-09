//
//  ViewController_Profile.swift
//  lotus
//
//  Created by Cory Dickson on 8/9/15.
//
//

import UIKit

let FIELD_FN_TAG = 1
let FIELD_LN_TAG = 2
let FIELD_ZIP_TAG = 3
let FIELD_DAY_TAG = 4
let FIELD_MON_TAG = 5
let FIELD_YEAR_TAG = 6
let FIELD_EMAIL_TAG = 7

class ViewController_Profile: UIViewController, UITextFieldDelegate {
    
    //Outlet References
    
    @IBOutlet weak var buttonNext: UIButton!
    
    @IBOutlet weak var fnTextField: UITextField!
    @IBOutlet weak var lnTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "placeholder.jpg")!.alpha(0.5))
        
        //set tags for TextViewDelegate
        fnTextField.tag = FIELD_FN_TAG
        lnTextField.tag = FIELD_LN_TAG
        zipTextField.tag = FIELD_ZIP_TAG
        dayTextField.tag = FIELD_DAY_TAG
        monthTextField.tag = FIELD_MON_TAG
        yearTextField.tag = FIELD_YEAR_TAG
        emailTextField.tag = FIELD_EMAIL_TAG
        
        
        //style text fields
        styleTextField(fnTextField, borderWidth: 1.5, borderColor: UIColor.whiteColor().CGColor, placeHolderText: "First Name")
        styleTextField(lnTextField, borderWidth: 1.5, borderColor: UIColor.whiteColor().CGColor, placeHolderText: "Last Name")
        styleTextField(zipTextField, borderWidth: 1.5, borderColor: UIColor.whiteColor().CGColor, placeHolderText: "Zip")
        styleTextField(dayTextField, borderWidth: 1.5, borderColor: UIColor.whiteColor().CGColor, placeHolderText: "Day")
        styleTextField(monthTextField, borderWidth: 1.5, borderColor: UIColor.whiteColor().CGColor, placeHolderText: "Month")
        styleTextField(yearTextField, borderWidth: 1.5, borderColor: UIColor.whiteColor().CGColor, placeHolderText: "Year")
        styleTextField(emailTextField, borderWidth: 1.5, borderColor: UIColor.whiteColor().CGColor, placeHolderText: "Email")
        
        
        //set delagates to the view controller
        fnTextField.delegate = self
        lnTextField.delegate = self
        zipTextField.delegate = self
        dayTextField.delegate = self
        monthTextField.delegate = self
        yearTextField.delegate = self
        emailTextField.delegate = self
        
        //setting the next field property
        self.fnTextField.nextField = self.lnTextField
        self.lnTextField.nextField = self.zipTextField
        self.zipTextField.nextField = self.dayTextField
        self.dayTextField.nextField = self.monthTextField
        self.monthTextField.nextField = self.yearTextField
        self.yearTextField.nextField = self.emailTextField
        
        
        dayTextField.inputView = UIView(frame: CGRectZero)
        monthTextField.inputView = UIView(frame: CGRectZero)
        yearTextField.inputView = UIView(frame: CGRectZero)
        
        
        //set datepicker attributes
        datePicker.backgroundColor = UIColor.whiteColor()
        datePicker.maximumDate = NSDate()
        datePicker.hidden = true
        
        //defaulted to false, is set to true after text fields are validated
        buttonNext.enabled = false
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dayFieldShouldBegin(sender: UITextField) {
        datePicker.hidden = false
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        datePicker.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    @IBAction func yearFieldShouldBegin(sender: UITextField) {
        datePicker.hidden = false
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        datePicker.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    @IBAction func monthFieldShouldBegin(sender: UITextField) {
        datePicker.hidden = false
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        datePicker.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        dayTextField.text = getDayFromDate(sender.date)
        yearTextField.text = getYearFromDate(sender.date)
        monthTextField.text = getMonthFromDate(sender.date)
    }
    
    @IBAction func dayEndEditing(sender: UITextField) {
        datePicker.hidden = true
    }
    
    @IBAction func monthEndEditing(sender: UITextField) {
        datePicker.hidden = true
    }
    
    @IBAction func yearEndEditing(sender: UITextField) {
        datePicker.hidden = true
    }
    
    //UI Flow methods
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //next field method
        if (textField == emailTextField) {
            textField.resignFirstResponder()
        }
        else {
            textField.nextField?.becomeFirstResponder()
        }
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        _ = NSLocale.currentLocale().objectForKey(NSLocaleDecimalSeparator) as! String
        let testText = (text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        
        if(textField.tag == FIELD_ZIP_TAG) {
            _ = text.utf16.count + string.utf16.count - range.length
            return isNumeric(testText)
        }
        
        return true
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