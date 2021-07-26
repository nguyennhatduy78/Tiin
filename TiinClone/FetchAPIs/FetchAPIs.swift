//
//  fetchAPIs.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 22/04/2021.
//

import Foundation
import Alamofire
import PromiseKit

class FetchAPIs{
    enum function{
        case getNews
        case getNewsPage
        case getNewsDetail
        case getNewsRelated
        case getVideo
        case getVideoDetail
        case getImage
        case getImageDetail
        case getCategory
        case search
    }
    
    enum type {
        case category
        case detail
    }
    func fetchApis(function: function, queryParam: String) -> Promise<Any> {
        switch function {
        case .getNews:
            return self.api(url: URL(string: API.GET_NEWS)!, type: .category)
        case .getNewsPage:
            return self.api(url: URL(string: API.GET_NEWS+"?page=\(queryParam)&num=\(PAGE.limit)")!, type: .category)
        case .getNewsDetail:
            return self.api(url: URL(string: API.GET_NEWS_DETAIL+"?article_id=\(queryParam)")!, type: .detail)
        case .getNewsRelated:
            return self.api(url: URL(string: API.GET_NEWS_RELATED+"?article_id=\(queryParam)")!, type: .category)
        case .getVideo:
            return self.api(url: URL(string: API.GET_VIDEO)!, type: .category)
        case .getVideoDetail:
            return self.api(url: URL(string: API.GET_VIDEO_DETAIL+"?video_id=\(queryParam)")!, type: .category)
        case .getImage:
            return self.api(url: URL(string: API.GET_IMAGE)!, type: .category)
        case .getImageDetail:
            return self.api(url: URL(string: API.GET_IMAGE)!, type: .detail)
        case .getCategory:
            return self.api(url: URL(string: API.GET_NEWS+queryParam)!, type: .category)
        case .search:
            var tmp = ""
            for x in queryParam {
                if(x != " "){
                    tmp.append(x)
                }
            }
            return self.api(url: URL(string: API.GET_SEARCH+"?keyword=\(tmp)")!, type: .category)
        }
    }
    
    private func api(url: URL, type: type) -> Promise<Any>{
        return Promise<Any>{ seal in
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = HTTPMethod.get.rawValue
            Alamofire.request(request).validate(statusCode: 200..<300).responseJSON { (response) in
                switch response.result {
                case .success(let data as NSDictionary):
                    if(type == .category) {
                        seal.fulfill(data.value(forKey: "data")!)
                    } else {
                        seal.fulfill(data)
                    }
                default:
                    print("Error in fetch_apis")
                }
            }
        }
    }
    
}
