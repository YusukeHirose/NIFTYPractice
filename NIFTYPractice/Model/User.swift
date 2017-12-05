//
//  User.swift
//  NIFTYPractice
//
//  Created by User on 2017/12/01.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String
    var password: String
    
    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
    
    func signUp(callback: @escaping (_ message: String?) -> Void) {
        let user = NCMBUser()
        user.userName = name
        user.password = password
        user.signUpInBackground { (error) in
          
            if error == nil {
                print("ログイン成功")
            } else {
                callback((error! as NSError).userInfo["NSLocalizedDescription"] as? String)
            }
            
            }
    }
            
//            callback?(_ : ( error? as NSError).userInfo["NSLocalizedDescription"] as! String)
        
    
    func login(callback: @escaping (_ message: String?) -> Void) {
        NCMBUser.logInWithUsername(inBackground: self.name, password: self.password) { (user, error) in
            if error == nil {
                print("ログイン成功")
            } else {
                callback((error! as NSError).userInfo["NSLocalizedDescription"] as? String)
            }
            
        }
    }
    
}
