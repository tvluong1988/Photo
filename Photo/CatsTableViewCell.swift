//
//  CatsTableViewCell.swift
//  Photo
//
//  Created by Thinh Luong on 12/21/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

import Parse
import ParseUI

/// Display cat photo with labels.
class CatsTableViewCell: PFTableViewCell {
  // MARK: Outlets
  @IBOutlet weak var catImageView: UIImageView?
  @IBOutlet weak var catPawIcon: UIImageView?
  @IBOutlet weak var nameLabel: UILabel?
  @IBOutlet weak var votesLabel: UILabel?
  @IBOutlet weak var creditLabel: UILabel?
  
  // MARK: Functions
  func onDoubleTap(sender: AnyObject) {
    if let parseObject = parseObject {
      let key = ParseAPI.Schema.votes
      if var votes = parseObject.objectForKey(key) as? Int {
        votes += 1
        
        parseObject.setObject(votes, forKey: key)
        parseObject.saveInBackground()
        
        votesLabel?.text = "\(votes) votes"
      }
    }
    
    catPawIcon?.hidden = false
    catPawIcon?.alpha = 1
    
    UIView.animateWithDuration(1, delay: 1, options: .CurveEaseOut, animations: {
      self.catPawIcon?.alpha = 0
      }, completion: {
        _ in
        self.catPawIcon?.hidden = true
    })
  }
  
  // MARK: Lifecycle
  override func awakeFromNib() {
    let gesture = UITapGestureRecognizer(target: self, action: "onDoubleTap:")
    gesture.numberOfTapsRequired = 2
    contentView.addGestureRecognizer(gesture)
    
    catPawIcon?.hidden = true
    
    super.awakeFromNib()
    // Initialization code
  }
  
  // MARK: Properties
  var parseObject: PFObject?
  
}














