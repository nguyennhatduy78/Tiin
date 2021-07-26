//
//  NewsCategoryCell.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 01/06/2021.
//

import Foundation
import UIKit

class NewsCategoryCell: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var getCategoryID : ((_ category_id: Int, _ category_title: String) -> Void)?
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.collectionView.register(CategoryViewCell.self, forCellWithReuseIdentifier: "Category")
//        self.collectionView.backgroundColor = .lightGray
//    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        self.register(CategoryViewCell.self, forCellWithReuseIdentifier: "Category")
        self.backgroundColor = .lightGray
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category", for: indexPath) as! CategoryViewCell
        cell.category_id = CATEGORY.CATEGORY_ITEM[indexPath.row].1
        cell.label.text = CATEGORY.CATEGORY_ITEM[indexPath.row].0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.getCategoryID!(CATEGORY.CATEGORY_ITEM[indexPath.row].1, CATEGORY.CATEGORY_ITEM[indexPath.row].0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 197, height: 40)
    }
    
    
}
