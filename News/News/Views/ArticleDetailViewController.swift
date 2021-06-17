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
    
    required init?(coder: NSCoder, article: Article) {
        self.article = article
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.articleTitle.text = article.title
        self.content.text = article.content
        self.imageView.sd_setImage(with: URL(string: article.urlToImage ?? ""), placeholderImage: UIImage(systemName: "search"))
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
