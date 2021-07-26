//
//  CategoryViewCell.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 01/06/2021.
//

import Foundation
import UIKit

class CategoryViewCell : UICollectionViewCell {
    
    var category_id: Int?
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    private func viewInit(){
        label = UILabel(frame: CGRect(x: 10, y: 10, width: 60, height: 40))
        self.addSubview(label)
    }
    
}
