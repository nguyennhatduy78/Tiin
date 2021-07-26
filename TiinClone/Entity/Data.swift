//
//  Data.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 22/04/2021.
//

import Foundation
class Data {
    var article_id: Int?
    var image: String?
    var title: String?
    var type: Int?
    init(article_id: Int?, image: String?, title: String?, type: Int?) {
        if let x = article_id {
            self.article_id = x
        }
        if let x = image {
            self.image = x
        }
        if let x = title{
            self.title = x
        }
        if let x = type {
            self.type = x
        }
    }
}
