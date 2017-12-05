//
//  Tweet.swift
//  NIFTYPractice
//
//  Created by User on 2017/11/28.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String
    var user: User?
    
    init(text: String) {
        self.text = text

    }
    
    func save(callback: @escaping () -> Void) {
        let tweetObject = NCMBObject(className: "Tweet")
        tweetObject?.setObject(NCMBUser.current(), forKey: "user")
        tweetObject?.setObject(text, forKey: "text")
        tweetObject?.saveInBackground { (error) in
            if error == nil {
                print("保存完了！")
                callback()
            }
        }
    }
    
}
