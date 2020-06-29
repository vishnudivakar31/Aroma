//
//  TableViewCell.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/29/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var uiImageView: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dislikesLabel: UILabel!
    @IBOutlet weak var postedByLabel: UILabel!
    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.borderWidth = 1.0
        cellView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cellView.layer.cornerRadius = 5.0
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOpacity = 1
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
