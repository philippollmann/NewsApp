//
//  NewsTableViewCell.swift
//  News
//
//  Created by Philipp Ollmann on 14.06.21.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet var view: UIView!
    @IBOutlet var title: UILabel!
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var date: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
