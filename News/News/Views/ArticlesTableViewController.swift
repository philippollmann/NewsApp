//
//  ViewController.swift
//  News
//
//  Created by Philipp Ollmann on 14.06.21.
//

import UIKit
import SDWebImage
import MaterialComponents

class ArticlesTableViewController: UIViewController {
    
    var articles: [Article] = []
    @IBOutlet weak var myTableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    var filter: Filter = Filter()
    @IBOutlet var currFilterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        myTableView.refreshControl = refreshControl
        
        self.filter.country = .america
        self.filter.category = nil
        self.filter.searchTerm = nil
        
        updateTableViewWithData()
    }
    
    private func updateTableViewWithData(){
        NewsController.shared.getNews(filter: filter, completion: { result in
            switch result {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            case .success(let articles):
                self.articles = articles
                print(articles)
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                    self.currFilterLabel.text = self.filter.getFilterString()
                    
                }
            }
        })
    }
    
    
    @IBSegueAction func makeSwipeArticlesCollectionController(_ coder: NSCoder) -> SwipeArticlesCollectionViewController? {
        return SwipeArticlesCollectionViewController(coder: coder, articles: self.articles)
    }
    
    @IBSegueAction func makeFilterViewController(_ coder: NSCoder) -> FilterViewController? {
        return FilterViewController(coder: coder, currFilter: self.filter, callBack: applyFilter)
    }
    
    @IBSegueAction func makeArticleDetailController(_ coder: NSCoder) -> ArticleDetailViewController? {
        guard let selectedIndexPath = self.myTableView.indexPathForSelectedRow else {
            return nil
        }
        self.myTableView.deselectRow(at: selectedIndexPath, animated: true)
        return ArticleDetailViewController(coder: coder, article: self.articles[selectedIndexPath.row])
    }
    
    func applyFilter(filter: Filter){
        self.filter = filter
        print("Filter applied in ArticlesTableViewController: Category: \(filter.category?.rawValue ?? "nil") Country: \(filter.country) SearchTerm: \(filter.searchTerm ?? "nil")")
        
        updateTableViewWithData()
    }
}

extension ArticlesTableViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath) as! NewsTableViewCell
        
        let article = self.articles[indexPath.row]
        cell.cellImage.sd_setImage(with: URL(string: article.urlToImage ?? "https://images.unsplash.com/photo-1504711434969-e33886168f5c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80"), placeholderImage: UIImage(systemName: "search"))
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
    
    @objc func refresh(_ sender: AnyObject) {
        print("refreshed")
        refreshControl.endRefreshing()
        
    }
    
}



