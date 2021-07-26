//
//  NewsDetail.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 22/04/2021.
//

import Foundation
import UIKit
class NewsDetail {
    var news_id: Int?
    var pid: Int?
    var cid: Int?
    var title: String?
    var image: String?
    var image_large: String?
    var content : String?
    var sapo: String?
    var datePub: CGFloat?
    var category: Category?
    var author: String?
    var source: String?
    var blockNum: Int?
    var blocks: [NewsBlock]?
    var relatedNews: [Data]?
    
    init(news_id: Int?, pid: Int?, cid: Int?, title: String?, image: String?, image_large: String?,
         content: String?, sapo: String?, datePub: CGFloat?, category: Category?, author: String?, source: String?, blockNum : Int?,
         blocks: [NewsBlock]?, relatedNews: [Data]?) {
        if let x = news_id {
            self.news_id = x
        }
        if let x = pid {
            self.pid = x
        }
        if let x = cid {
            self.cid = x
        }
        if let x = title {
            self.title = x
        }
        if let x = image {
            self.image = x
        }
        if let x = image_large{
            self.image_large = x
        } else {
            self.image_large = ""
        }
        if let x = content {
            self.content = x
        }
        if let x = sapo {
            self.sapo = x
        } else {
            self.sapo = ""
        }
        if let x = datePub {
            self.datePub = x
        } else {
            self.datePub = 0
        }
        if let x = category {
            self.category = x
        }
        if let x = author {
            self.author = x
        }
        if let x = source {
            self.source = x
        }
        if let x = blockNum {
            self.blockNum = x
        }
        if let x = blocks {
            self.blocks = x
        }
        
        if let x = relatedNews {
            self.relatedNews = x
        } else {
            self.relatedNews = []
        }
    }
    
}
