//
//  Category.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 20/04/2021.
//

import Foundation

class Category  {
    var category : String?
    var category_alias: String?
    var parent_category: String?
    var parent_category_alias: String?
    
    init(category: String?, category_alias: String?, parent_category: String?, parent_category_alias: String?) {
        if let x = category {
            self.category = x
        }
        if let x = category_alias{
            self.category_alias = x
        }
        if let x = parent_category {
            self.parent_category = x
        }
        if let x = parent_category_alias {
            self.parent_category_alias = x
        }
    }
}
