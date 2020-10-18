//
//  tweetCell.swift
//  Twitter
//
//  Created by Yasiris Ortiz on 11.10.20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {
    
    var tweetId:Int = -1
    var favorited:Bool = false
    var retweeted: Bool = false
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var favButton: UIButton!
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorite = !favorited
        
        if (toBeFavorite){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favorite did not success: \(Error)")
            })
            
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Unfavorite did not success: \(Error)")
            })
            
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        let toBeRetweet = !retweeted
        
        if (toBeRetweet){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setRetweet(true)
            }, failure: { (Error) in
                print("Favorite did not success: \(Error)")
            })
            
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setRetweet(false)
            }, failure: { (Error) in
                print("Unfavorite did not success: \(Error)")
            })
            
        }
        
        
    }
        func setFavorite(_ isFavorited:Bool){
            favorited = isFavorited
            if (favorited){
                favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
                
            }
            else {
                favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
            }
        }
    
    func setRetweet(_ isRetweeted:Bool){
        if (isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
            
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
