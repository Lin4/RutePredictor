//
//  DatePickerController.swift
//  RutePredictor
//
//  Created by Lingeswaran Kandasamy on 7/29/17.
//  Copyright © 2017 Lingeswaran Kandasamy. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {
    @IBOutlet weak var show_Time_lbl: UILabel!
    @IBOutlet weak var show_date_lbl: UILabel!
    var callback : ((String) -> Void)?
    var callback1 : ((String) -> Void)?
    var dateFormatter, timeFormatter : DateFormatter!
    
override func viewDidLoad() {
        super.viewDidLoad()
     self.navigationController?.navigationBar.backItem?.title = " "
        show_Time_lbl.isHidden = true
        show_date_lbl.isHidden = true
        let datePicker : UIDatePicker = UIDatePicker(frame: CGRect(x: 0,y: 200,width: self.view.frame.size.width,height: 250))
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        self.view.addSubview(datePicker)
        datePicker.addTarget(self, action: #selector(DatePickerController.date_picker_change_action(_:)), for: UIControlEvents.valueChanged)
     
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "M/dd/yyyy,  h:mm a"
        timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"

    }
    
@IBAction func date_picker_change_action(_ sender : UIDatePicker){
        show_date_lbl.text = dateFormatter.string(from: sender.date)
    // Alarm time with date
        show_Time_lbl.text = dateFormatter.string(from: sender.date)
    }
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
@IBAction func done(sender: AnyObject){
        callback?( show_date_lbl.text! )
        callback1?( show_Time_lbl.text! )
        self.navigationController!.popViewController(animated: true)
    }
   
}

