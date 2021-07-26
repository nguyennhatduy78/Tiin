//
//  Block.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 19/05/2021.
//

import Foundation
class NewsBlock {
    var type : Int?
    var content: String?
    var length: Int?
    var video : String?
    var image: String?
    var width: Int?
    var height: Int?
    
    init(type: Int?, content: String?, length: Int?, video: String?, image: String?, width: Int?, height: Int?) {
        if let x = type {
            self.type = x
        } else{
            self.type = 0
        }
        
        if let x = content {
            self.content = x
        } else {
            self.content = ""
        }
        
        if let x = length {
            self.length = x
        } else {
            self.length = 0
        }
        if let x = video {
            self.video = x
        } else {
            self.video = ""
        }
        if let x = image {
            self.image = x
        } else  {
            self.image = ""
        }
        
        if let x = width {
            self.width = x
        } else {
            self.width = 0
        }
        if let x = height {
            self.height = x
        } else {
            self.height = 0
        }
    }
}
