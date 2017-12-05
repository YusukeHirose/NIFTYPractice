//
//  Root TableViewController.swift
//  NIFTYPractice
//
//  Created by User on 2017/11/28.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    let tweetManager = TweetManager.sharedInstance

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //セルの登録
        tableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        
        tweetManager.fetchTweets { () in
            self.tableView.reloadData()
        }
        
    }
    
    //セクション数
//    override func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
//        return 1
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "投稿", style: .plain, target: self, action: #selector(TimeLineTableViewController.post))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(TimeLineTableViewController.logout))
    }
    
    @objc func post() {
//        print("投稿ボタンをタップしました")
        let tweet = Tweet(text: textField.text!)
        tweet.save { () in
            self.tweetManager.fetchTweets { ()  in
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func logout() {
        NCMBUser.logOut()
        performSegue(withIdentifier: "modalLoginViewController", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if NCMBUser.current() == nil {
            performSegue(withIdentifier: "modalLoginViewController", sender: self)
        }
    }

    
//    UIBarButtonItem(title: "RightBtn", style: .Plain, target: self, action: "onClickMyButton:")

    
    //セルの高さ
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 75
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    //セル数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tweetManager.tweets.count
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath)as! TweetTableViewCell
        let tweet = tweetManager.tweets[indexPath.row]
        cell.nameLabel.text = tweet.user?.name
        cell.tweetLabel.text = tweet.text

        return cell
    }
    

    
//     Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//         Return false if you do not want the specified item to be editable.
//        return true
//    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
