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
    @IBOutlet var searchBar: UISearchBar!
    
    let countries : [Countries] = [.austria, .germany, .america, .england, .italy, .netherlands, .russia ]
    let categories : [Categories] = [.business, .entertainment, .general, .health, .science, .sports, .technology]
    
    private var filter:Filter = Filter()
    
    //CALLBACK
    private let callBack: ((_ filter: Filter)-> Void)?
    
    required init?(coder: NSCoder, currFilter: Filter, callBack: @escaping ((_ filter: Filter)-> Void)) {
        self.callBack = callBack
        self.filter = currFilter
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Filter"
        
        searchBar.delegate = self
        searchBar.text = filter.searchTerm
        
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
    
    @IBAction func onFilterButtonClick(_ sender: Any) {
        if let call = self.callBack {
            call(self.filter)
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension FilterViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filter.searchTerm = searchText.trimmingCharacters(in: .whitespaces)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.onFilterButtonClick(self)
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
        var selected: Bool = false
        if collectionView.tag == 1 {
            identifier = "countryViewCell"
            let country = countries[indexPath.row]
            title = country.rawValue
            if (self.filter.country == country){
                selected = true
            }
        } else {
            identifier = "categoryViewCell"
            let category = categories[indexPath.row]
            title =  category.rawValue
            if self.filter.category == category {
                selected = true
            }
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
        
        if selected {
            //fyi: chipView.isSelected did not work so this is my workaround
            //chipView.isSelected = selected
            chipView.setBackgroundColor(#colorLiteral(red: 0.3462112546, green: 0.6931453347, blue: 0.6249827147, alpha: 1), for: .normal)
        }
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
