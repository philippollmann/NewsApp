//
//  ViewController.swift
//  News
//
//  Created by Philipp Ollmann on 14.06.21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var articles: [Article] = []
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        
        NewsController.shared.getNews(completion: { result in
            switch result {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            case .success(let articles):
                self.articles = articles
                print(articles)
                DispatchQueue.main.async {self.myTableView.reloadData()}
            }
        })
    }
    
    @IBSegueAction func makeArticleDetailController(_ coder: NSCoder) -> ArticleDetailViewController? {
        guard let selectedIndexPath = self.myTableView.indexPathForSelectedRow else {
            return nil
        }
        self.myTableView.deselectRow(at: selectedIndexPath, animated: true)
        return ArticleDetailViewController(coder: coder, article: self.articles[selectedIndexPath.row])
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath) as! NewsTableViewCell
        
        let article = self.articles[indexPath.row]
        cell.cellImage.sd_setImage(with: URL(string: article.urlToImage ?? ""), placeholderImage: UIImage(systemName: "search"))
        cell.title.text = article.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        if let date = article.date {
            cell.date.text = dateFormatter.string(from: date)
        } else {
            cell.date.text =  "----"
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.myTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showArticleDetail", sender: self)
    }
    
}

