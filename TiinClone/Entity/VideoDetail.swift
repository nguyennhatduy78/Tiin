//
//  VideoDetail.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 16/06/2021.
//

import Foundation
class VideoDetail {
    var id: Int?
    var title: String?
    var sapo: String?
    var author: String?
    var source: String?
    var video_url: String?
    var video_thumb: String?
        
    init(id: Int?, title: String?, sapo: String?, author: String?, source: String? , video_url:String?, video_thumb: String? ) {
        if let x = id {
            self.id = x
        }
        
        if let x = title {
            self.title = x
        }
        if let x = sapo {
            self.sapo = x
        }
        if let x = author {
            self.author = x
        }
        if let x = source {
            self.source = x
        }
        if let x = video_url{
            self.video_url = x
        }
        if let x = video_thumb {
            self.video_thumb = x
        }
    }
    
}
