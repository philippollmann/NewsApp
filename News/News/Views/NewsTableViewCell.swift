//
//  NewsTableViewCell.swift
//  News
//
//  Created by Philipp Ollmann on 14.06.21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var view: UIView!
    @IBOutlet var title: UILabel!
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellImage.layer.cornerRadius = 12
        cellImage.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
