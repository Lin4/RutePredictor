//
//  ViewController.swift
//  LocationPickerDemo
//
//  Created by Almas Sapargali on 7/29/15.
//  Copyright (c) 2015 almassapargali. All rights reserved.
//

import UIKit


class ScheduleRepetController: UIViewController {
  
    var callbackAlarmTime2 : ((String) -> Void)?
    var callbackAlarmTime3 : ((String) -> Void)?
    var dateFormatter, timeFormatter : DateFormatter!

	
    override func viewDidLoad() {
        super.viewDidLoad()
 self.navigationController?.navigationBar.backItem?.title = ""
        
    }

    @IBAction func date_picker_change_action(_ sender : UIDatePicker){
      //  show_date_lbl.text = dateFormatter.string(from: sender.date)
        // Alarm time with date
       // show_Time_lbl.text = dateFormatter.string(from: sender.date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(sender: AnyObject){
      //  callbackAlarmTime2?( show_date_lbl.text! )
       // callbackAlarmTime3?( show_Time_lbl.text! )
        self.navigationController!.popViewController(animated: true)
    }
    
}


