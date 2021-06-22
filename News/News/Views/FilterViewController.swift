//
//  FilterViewController.swift
//  News
//
//  Created by Philipp Ollmann on 21.06.21.
//

import UIKit
import MaterialComponents.MaterialChips



class FilterViewController: UIViewController {
    
    
    @IBOutlet var countryCollectionView: UICollectionView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    
    let countries : [Countries] = [.austria, .germany, .america, .england, .italy, .netherlands, .russia ]
    let categories : [Categories] = [.business, .entertainment, .general, .health, .science, .sports, .technology]
    
    var filter:Filter = Filter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Filter"
        
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        let layout = MDCChipCollectionViewFlowLayout()
        countryCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        categoryCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }
    
    
    override func loadView() {
        super.loadView()
        
        let nib = UINib(nibName: "UICollectionElementKindCell", bundle:nil)
        self.categoryCollectionView.register(nib, forCellWithReuseIdentifier: "categoryViewCell")
        
        categoryCollectionView.register(
            MDCChipCollectionViewCell.self,
            forCellWithReuseIdentifier: "categoryViewCell")
        
        countryCollectionView.register(
            MDCChipCollectionViewCell.self,
            forCellWithReuseIdentifier: "countryViewCell")
    }
    
}


extension FilterViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if collectionView.tag == 1 {
            return countries.count
        } else {
            return categories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var identifier: String
        var title: String
        if collectionView.tag == 1 {
            identifier = "countryViewCell"
            title = countries[indexPath.row].rawValue
        } else {
            identifier = "categoryViewCell"
            title =  categories[indexPath.row].rawValue
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MDCChipCollectionViewCell else {
            return UICollectionViewCell()
        }
        let chipView = cell.chipView
        chipView.titleLabel.text = title
        chipView.setTitleColor(.white, for: .normal)
        chipView.setBackgroundColor(.gray, for: .normal)
        chipView.setTitleColor(.white, for: .selected)
        chipView.setBackgroundColor(#colorLiteral(red: 1, green: 0.5662645698, blue: 0.5804488659, alpha: 1), for: .selected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            filter.country = countries[indexPath.row]
            print("Selected Country: \(filter.country.rawValue)")
        } else {
            filter.category = categories[indexPath.row]
            print("Selected Category: \(filter.category?.rawValue ?? "none")")
        }
    }
}
