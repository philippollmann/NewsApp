//
//  ArticleCollectionViewCell.swift
//  News
//
//  Created by Philipp Ollmann on 25.06.21.
//

import UIKit

//PAGE CELL
class SwipeArticleCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView(frame: UIScreen.main.bounds)
        view.backgroundColor = .black
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = true
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name:"HiraMinProN-W6", size: 20.0)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    
    private let swipeUpLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont(name:"HiraMinProN-W6", size: 14)
        label.text = "Swipe up to read full article"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        imageView.layer.opacity = 0.3
        
        insertSubview(imageView, at: 0)
        addSubview(titleLabel)
        addSubview(swipeUpLabel)
        addSubview(descriptionLabel)
    }
    
    override func layoutSubviews() {
        
        //label.center = CGPoint(x: 160, y: 285)
        titleLabel.frame = CGRect(x: 20, y: self.frame.height/2 - 40, width: frame.width - 40, height: 80)
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .left
        
        descriptionLabel.frame = CGRect(x: 20, y: self.frame.height/2 + 50, width: frame.width - 40, height: 80)
        descriptionLabel.sizeToFit()
        descriptionLabel.textAlignment = .left
        
        swipeUpLabel.frame = CGRect(x: 0, y: self.frame.height - (40 + 30), width: frame.width, height: 40)
        swipeUpLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
