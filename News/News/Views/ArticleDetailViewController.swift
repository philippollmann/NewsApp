//
//  ArticleDetailViewController.swift
//  News
//
//  Created by Philipp Ollmann on 16.06.21.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    let article: Article
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var content: UILabel!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var labelDate: UILabel!
    
    required init?(coder: NSCoder, article: Article) {
        self.article = article
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .label

        
        articleTitle.sizeToFit()
        content.sizeToFit()

        self.articleTitle.text = article.title
        self.content.text = article.content
        
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 12
        self.imageView.layer.masksToBounds = true
        self.imageView.sd_setImage(with: URL(string: article.urlToImage ?? "https://images.unsplash.com/photo-1504711434969-e33886168f5c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80"), placeholderImage: UIImage(systemName: "search"))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        if let date = article.date {
            self.labelDate.text = dateFormatter.string(from: date)
        } else {
            self.labelDate.text =  "----"
        }
    }

    
    @IBAction func readArticleClick(_ sender: Any) {
        guard let url = URL(string: self.article.url ?? "https://www.google.com/") else { return }
        UIApplication.shared.open(url)        
    }
    
}
