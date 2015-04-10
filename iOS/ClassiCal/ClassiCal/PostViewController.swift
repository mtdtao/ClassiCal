//
//  PostViewController.swift
//  ClassiCal
//
//  Created by 曾 锦涛 on 3/6/15.
//  Copyright (c) 2015 CS 307 Team 8. All rights reserved.
//

import Foundation
import UIKit

class PostViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var postReply: UITableView!
    
    
    
    var pContent = ""
    var postDetail: Post!

    
    override func viewDidLoad() {
        filterList()
        super.viewDidLoad()
        showContent(postDetail)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showContent(post: Post) {
        postContent.text = post.content
        postTitle.text = post.title
    }
   
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postDetail.replyList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as CustomTableViewCell
        
        cell.replyContent!.text = self.postDetail.replyList[indexPath.row].content
        cell.name!.text = self.postDetail.replyList[indexPath.row].name
        cell.number!.text = String(self.postDetail.replyList[indexPath.row].like)
        
        //cell.upClicked
        //cell.upClicked.addTarget(self.postDetail.replyList, action: "someAction", forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    @IBAction func unwindToPost(segue: UIStoryboardSegue) {
        if segue.identifier == "DoneReply" {
            let addReply = segue.sourceViewController as AddReply
            if let newReply = addReply.newReply {
                self.postDetail.replyList.append(newReply)
                println("done")
                //let indexPath = NSIndexPath(forRow: self.postDetail.replyList.count - 1, inSection: 0)
                //tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    
    
    @IBAction func upButton(sender: AnyObject) {
        //let cell = self.postReply.dequeueReusableCellWithIdentifier("cell") as CustomTableViewCell
        //let indexPath = self.postReply.indexPathForCell(cell)
        //println("indexPath is \(indexPath) and \(indexPath!.row)")
        self.postDetail.replyList[0].like++
        self.postReply.reloadData()
        //self.reloadData()
    }
   
    func filterList() { // should probably be called sort and not filter
        self.postDetail.replyList.sort() { $0.like > $1.like } // sort the fruit by name
        //reloadData(); // notify the table view the data has changed
    }
    
    
}