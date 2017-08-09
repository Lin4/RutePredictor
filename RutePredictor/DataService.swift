//
//  DataServices.swift
//  iConnectFinal
//
//  Created by Lingeswaran Kandasamy on 6/14/17.
//  Copyright © 2017 Lingeswaran Kandasamy. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

//Obtains the database URL
let DB_BASE = Database.database().reference()

//The reference for the database of images from Firebase
let STORAGE_BASE = Storage.storage().reference()

class DataService {
    
    static let standard = DataService()
    
    //Database references
    fileprivate let _REF_BASE = DB_BASE
    fileprivate let _REF_POSTS = DB_BASE.child("posts")
    fileprivate let _REF_USERS = DB_BASE.child("users")
    
    //Storage references
    fileprivate var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    //
    var REF_USER_CURRENT: DatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    //Getters
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_POST_IMAGES : StorageReference {
        return _REF_POST_IMAGES
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        //Ads a new child to the users array whether it exists or not and add it's data values
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
}
                                                                                                                                                                                    
