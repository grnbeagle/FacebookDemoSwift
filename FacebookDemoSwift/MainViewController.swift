//
//  MainViewController.swift
//  FacebookDemoSwift
//
//  Created by Timothy Lee on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var feedTableView: UITableView!

    let urlString = "https://gist.githubusercontent.com/grnbeagle/e8da895d61bda941ff89/raw/a7ecacaf04858544258fc855d2a263834768c660/gistfile1.txt"
    var posts = [NSDictionary]()

    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.rowHeight = UITableViewAutomaticDimension
        feedTableView.dataSource = self
        reload()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
//        FBRequestConnection.startWithGraphPath("/me/feed", parameters: nil, HTTPMethod: "GET") { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
//            println("\(result)")
//        }
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) ->
            Void in
            let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary
            if let json = json {
                if let data = json["data"] as? [NSDictionary] {
                    self.posts = data
                    self.feedTableView.reloadData()
                }
            }
        }
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*
        If post contains "message" and a "picture" dequeue the PhotoCell
        If post only contains "message" dequeue the StatusCell
        */
        if indexPath.row >= posts.count {
            return UITableViewCell()
        }
        let post = posts[indexPath.row] // OK

        // Crashes here when it dequeues

        let statusCell = tableView.dequeueReusableCellWithIdentifier(StatusCell.reuseId, forIndexPath: indexPath) as! StatusCell

        statusCell.statusLabel.text = post["story"] as? String
        return statusCell
    }


}
