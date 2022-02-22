//
//  TableViewCell.swift
//  SeatGeekHub
//
//  Created by elliott on 2/21/22.
//

import UIKit

protocol BookmarkDelegate: AnyObject {
    func reload()
}

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var bookmark: UIButton!
    
    weak var delegate: BookmarkDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookmark.titleLabel?.adjustsFontSizeToFitWidth = true
        bookmark.isSelected = false
        
        eventName.adjustsFontSizeToFitWidth = true
        
    }

    @IBAction func bookmarkPressed(_ sender: Any) {
        if bookmark.isSelected == false {
            bookmark.isSelected = true
            self.layer.borderWidth = 5.0
            self.layer.borderColor = CGColor.init(red: 300, green: 0, blue: 0, alpha: 1.0)
        } else if bookmark.isSelected == true {
            bookmark.isSelected = false
            self.layer.borderWidth = 0.0
            self.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.0)
        }
        delegate?.reload()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
