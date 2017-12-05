//
//  TweetManager.swift
//  NIFTYPractice
//
//  Created by User on 2017/11/28.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class TweetManager: NSObject {

    static let sharedInstance = TweetManager()
    var tweets: [Tweet] = []
    
//    (snapshot.value! as! NSDictionary).object(forKey: "Dogs") as? [String:AnyObject]{

    
    func fetchTweets(callback: @escaping () -> Void) {
        let query = NCMBQuery(className: "Tweet")
        query?.includeKey("user")
        query?.order(byDescending: "createDate")
        query?.findObjectsInBackground { (objects, error) in
            if error == nil {
                self.tweets = []
                for object in objects! {
                    let text = (object as AnyObject).object(forKey: "text") as! String
                    let tweet = Tweet(text: text)
                    let userObject = (object as AnyObject).object(forKey: "user") as! NCMBUser
                    print(userObject.userName!)
                    let user = User(name: userObject.userName!, password: "")
                    tweet.user = user
                    self.tweets.append(tweet)
                    callback()
                }
            }
        }
    }
    
}
