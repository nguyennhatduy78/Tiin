//
//  CategoryTestTable.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 06/05/2021.
//

import Foundation
import UIKit
import Alamofire
import PromiseKit

class CategoryTable : UITableViewController {
    
    var dataType: Int = 0
    let apis: FetchAPIs = FetchAPIs()
    let helper : Helper = Helper()
    //--------------------------------
    let HeaderIdentifier = "Header"
    let BodyIdentifier = "Body"
    var isLoading = false
    var currentPage = 1
    var loading: UIActivityIndicatorView!
    
    //--------------------------------
    var fetch_data = [Data]()
    var getArticleId:((_ article_id: Int, _ article_title: String) -> Void)?
    
    
    override func viewDidLoad() {
        print("Data: \(self.fetch_data.count)")
        self.tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderIdentifier)
        self.tableView.register(BodyCell.self, forCellReuseIdentifier: BodyIdentifier)
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 1))
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderIdentifier) as! HeaderCell
            if(!self.fetch_data.isEmpty) {
                if(fetch_data[indexPath.row].type == self.dataType){
                    cell.image.kf.setImage(with: URL(string: fetch_data[indexPath.row].image!)!)
                    cell.title.text = fetch_data[indexPath.row].title
                    cell.article_id = fetch_data[indexPath.row].article_id!
                }
            }
            return cell
        }
        if(indexPath.row == fetch_data.count) {
            let cell = UITableViewCell()
            cell.frame = CGRect(x: 0, y: 0, width: 414, height: 50)
            self.loading = UIActivityIndicatorView(frame: cell.frame)
            loading.hidesWhenStopped = true
            loading.style = .medium
            cell.addSubview(loading)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: BodyIdentifier) as! BodyCell
        if(!self.fetch_data.isEmpty) {
            if(fetch_data[indexPath.row].type == self.dataType){
                cell.image.kf.setImage(with: URL(string: fetch_data[indexPath.row].image!)!)
                cell.title.text = fetch_data[indexPath.row].title
                cell.title.numberOfLines = .max
                cell.title.sizeToFit()
                cell.article_id = fetch_data[indexPath.row].article_id!
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 270
        }
        if(indexPath.row == fetch_data.count) {
            return 50
        }
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetch_data.count+1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            if let cell = tableView.cellForRow(at: indexPath) as? HeaderCell {
                self.getArticleId!(cell.article_id, cell.title.text!)
            }
        } else {
            if let cell = tableView.cellForRow(at: indexPath) as? BodyCell {
                self.getArticleId!(cell.article_id, cell.title.text!)
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height) && !isLoading {
            loadmoreNews()
        }
    }
    
    
    
    private func loadmoreNews(){
        if !self.isLoading {
            self.loading.startAnimating()
            currentPage += 1
            self.isLoading = true
            self.apis.fetchApis(function: .getNewsPage, queryParam: "\(currentPage)").done { result in
                let result = result as! NSArray
                for news in result {
                    let news = news as! NSDictionary
                    let newsFeed = Data(article_id: news.value(forKey: "id") as? Int, image: news.value(forKey: "image") as? String, title: news.value(forKey: "title") as? String, type: 1)
                    self.fetch_data.append(newsFeed)
                }
            }.catch { err in
                print(err)
            }.finally {
                self.isLoading = false
                self.loading.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    @objc func refresh(){
        self.fetch_data.removeAll()
        firstly{
            self.apis.fetchApis(function: .getNewsPage, queryParam: "1").done { (newsData) in
                let result = newsData as! NSArray
                for x in result {
                    let y = x as! NSDictionary
                 let news = Data(article_id: y.value(forKey: "id") as? Int, image: y.value(forKey: "image") as? String, title: y.value(forKey: "title") as? String, type: 1)
                    self.fetch_data.append(news)
                }
            }
        }.then {
            self.apis.fetchApis(function: .getVideo, queryParam: "").done { (data) in
                let res = data as! NSArray
                for x in res {
                    let y = x as! NSDictionary
                    let video = Data(article_id: y.value(forKey: "id") as? Int, image: y.value(forKey: "image") as? String, title: y.value(forKey: "title") as? String, type: 2)
                    self.fetch_data.append(video)
                }
            }
        }.then{
            self.apis.fetchApis(function: .getImage, queryParam: "").done { (data) in
                let res = data as! NSArray
                for x in res {
                    let y = x as! NSDictionary
                    let image = Data(article_id: y.value(forKey: "id") as? Int, image: y.value(forKey: "image") as? String, title: y.value(forKey: "title") as? String, type: 3)
                    self.fetch_data.append(image)
                }
            }
        }.catch { (err) in
            print("err: ",err)
        }.finally {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    
}
