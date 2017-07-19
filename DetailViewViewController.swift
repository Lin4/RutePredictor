//
//  DetailViewViewController.swift
//  RutePredictor
//
//  Created by Lingeswaran Kandasamy on 7/17/17.
//  Copyright © 2017 Lingeswaran Kandasamy. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
import GoogleMaps

class DetailViewViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    @IBAction func signOutTapped(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: "KEY_UID")
        print("Lin:\(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "gotoSignin", sender: nil)
    }
    
}

