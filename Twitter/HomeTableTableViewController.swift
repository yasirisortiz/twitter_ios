//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Yasiris Ortiz on 11.10.20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableTableViewController: UITableViewController {
    let tweetsAPIUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    var tweetsArray = [NSDictionary]()
    var numberOfTweet: Int!
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets(moreTweet: false)
        refresh.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = refresh

    }
    @objc func loadTweets(moreTweet: Bool) {
        if !moreTweet {
            numberOfTweet = 20
            
        } else {
            numberOfTweet = numberOfTweet + 20
            
        }
        
        let myParams = ["count": numberOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: tweetsAPIUrl, parameters: myParams as [String : Any], success: { (tweets: [NSDictionary]) in
        
        self.tweetsArray.removeAll()
            for tweet in tweets {
        self.tweetsArray.append(tweet)
                
            }
            self.tableView.reloadData()
            
            if !moreTweet {
                self.refreshControl?.endRefreshing()
            }
            
        }, failure: {(error) in
            print("Could not get any tweet, Error: \(error)")
        })
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row + 1 == tweetsArray.count {
            loadTweets(moreTweet: true)
        }
    }
    // MARK: - Table view data source
    @IBAction func onLogOut(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "isLogedIn")
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! tweetCell
        let user =  tweetsArray[indexPath.row]["user"] as! NSDictionary
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data  {
            cell.profileImage.image = UIImage(data: imageData)
        }
        
        cell.profileName.text = user["name"] as? String
        cell.tweetContent.text = tweetsArray[indexPath.row]["text"] as? String
        
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetsArray.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
