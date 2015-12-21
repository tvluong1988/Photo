//
//  CatsTableViewController.swift
//  Photo
//
//  Created by Thinh Luong on 12/21/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

import Parse
import ParseUI

class CatsTableViewController: PFQueryTableViewController {
  
  // MARK: Lifecycle
  override init(style: UITableViewStyle, className: String?) {
    
    super.init(style: style, className: className)
    
    pullToRefreshEnabled = true
    paginationEnabled = false
    objectsPerPage = 25
    
    parseClassName = className
    
    tableView.registerNib(UINib(nibName: "CatsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    tableView.rowHeight = 350
    tableView.allowsSelection = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }
  
  // MARK: Properties
  let cellIdentifier = "CatCell"
}

// MARK: - PFTableView
extension CatsTableViewController {
  override func queryForTable() -> PFQuery {
    let query = PFQuery(className: parseClassName!)
    
    if objects?.count == 0 {
      query.cachePolicy = PFCachePolicy.CacheThenNetwork
    }
    
    query.orderByAscending(ParseAPI.Schema.name)
    
    return query
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
    
    var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? CatsTableViewCell
    
    if cell == nil {
      cell = CatsTableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
    }
    
    if let pfObject = object {
      cell?.parseObject = pfObject
      
      cell?.nameLabel?.text = pfObject[ParseAPI.Schema.name] as? String
      
      var votes = pfObject[ParseAPI.Schema.votes] as? Int
      
      if votes == nil {
        votes = 0
      }
      
      cell?.votesLabel?.text = "\(votes!) votes"
      
      let credit = pfObject[ParseAPI.Schema.cc_by] as? String
      if let credit = credit {
        cell?.creditLabel?.text = "\(credit) / CC 2.0"
      }
      
      cell?.catImageView?.image = nil
      if let urlString = pfObject["url"] as? String {
        let url = NSURL(string: urlString)
        
        if let url = url {
          let request = NSURLRequest(URL: url, cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 5)
          
          NSOperationQueue.mainQueue().cancelAllOperations()
          
          NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            response, imageData, error in
            cell?.catImageView?.image = UIImage(data: imageData!)
          }
        }
      }
    }
    
    return cell
  }
}





























