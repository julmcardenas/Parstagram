//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Julianna Cardenas on 2/6/21.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()
    let refreshControl = UIRefreshControl()
    var numberOfPosts: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        loadPosts()
        refreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    @objc func loadPosts() {
        numberOfPosts = 20
        
        // make query from Parse
        let query = PFQuery(className:"Posts")
        query.order(byDescending: "createdAt")
        query.limit = numberOfPosts
        query.includeKey("author") // go fetch object
        
        query.findObjectsInBackground { (posts, error) in //get query
            if posts != nil {
                self.posts = posts! // store data
                self.tableView.reloadData() // reload tableView
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func loadMorePosts() {
        let query = PFQuery(className:"Posts")
        query.order(byDescending: "createdAt")
        numberOfPosts = numberOfPosts + 5
        
        query.includeKey("author") // go fetch object
        
        query.findObjectsInBackground { (posts, error) in //get query
            if posts != nil {
                self.posts = posts! // store data
                self.tableView.reloadData() // reload tableView
            }
        }
    
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count {
            loadMorePosts()
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        // make query from Parse
//        let query = PFQuery(className:"Posts")
//        query.includeKey("author") // go fetch object
//        query.limit = 30
//
//        query.findObjectsInBackground { (posts, error) in //get query
//            if posts != nil {
//                self.posts = posts! // store data
//                self.tableView.reloadData() // reload tableView
////                self.refreshControl.endRefreshing()
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = (post["caption"] as! String)
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.photoView.af_setImage(withURL: url)
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
