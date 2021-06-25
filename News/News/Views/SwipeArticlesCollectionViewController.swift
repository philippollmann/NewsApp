//
//  SwipeArticlesCollectionViewController.swift
//  News
//
//  Created by Philipp Ollmann on 25.06.21.
//

import UIKit
import SDWebImage

class SwipeArticlesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let articles: [Article]
    var currentPage = 0
    
    init?(coder: NSCoder, articles: [Article]) {
        self.articles = articles
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        // Register cell classes
        self.collectionView!.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        self.collectionView.isPagingEnabled = true
    }
    
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return articles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let article = self.articles[indexPath.row]
        cell.imageView.sd_setImage(with: URL(string: article.urlToImage ?? "https://images.unsplash.com/photo-1504711434969-e33886168f5c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80"), placeholderImage: UIImage(systemName: "search"))
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        
        //cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        currentPage = indexPath.row
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       if gesture.direction == .up {
            guard let url = URL(string: self.articles[currentPage].url ?? "https://www.google.com/") else { return }
            UIApplication.shared.open(url)
       }
    }
}



//PAGE CELL
class PageCell :UICollectionViewCell {
    
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
