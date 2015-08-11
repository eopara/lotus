//
//  ViewController_Profile.swift
//  lotus
//
//  Created by Cory Dickson on 8/9/15.
//
//

import UIKit

class ViewController_Profile: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var fnTextField: UITextField!
    @IBOutlet weak var lnTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //style text fields
        styleTextField(fnTextField, 1.5, UIColor.whiteColor().CGColor, "First Name")
        styleTextField(lnTextField, 1.5, UIColor.whiteColor().CGColor, "Last Name")
        styleTextField(zipTextField, 1.5, UIColor.whiteColor().CGColor, "Zip")
        styleTextField(dayTextField, 1.5, UIColor.whiteColor().CGColor, "Day")
        styleTextField(monthTextField, 1.5, UIColor.whiteColor().CGColor, "Month")
        styleTextField(yearTextField, 1.5, UIColor.whiteColor().CGColor, "Year")
        
        
        //set delagates to the view controller
        fnTextField.delegate = self
        lnTextField.delegate = self
        zipTextField.delegate = self
        dayTextField.delegate = self
        monthTextField.delegate = self
        yearTextField.delegate = self
        
        //setting the next field property
        self.fnTextField.nextField = self.lnTextField
        self.lnTextField.nextField = self.zipTextField
        self.zipTextField.nextField = self.dayTextField
        self.dayTextField.nextField = self.monthTextField
        self.monthTextField.nextField = self.yearTextField
        
        
        dayTextField.inputView = UIView(frame: CGRectZero)
        monthTextField.inputView = UIView(frame: CGRectZero)
        yearTextField.inputView = UIView(frame: CGRectZero)
    
        
        //set datepicker attributes
        datePicker.backgroundColor = UIColor.whiteColor()
        datePicker.maximumDate = NSDate()
        datePicker.hidden = true
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func textFieldShouldBegin(sender: UITextField) {
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
        textField.nextField?.becomeFirstResponder()
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
