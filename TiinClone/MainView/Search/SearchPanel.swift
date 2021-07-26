//
//  SearchPanel.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 06/06/2021.
//

import Foundation
import UIKit
import Kingfisher

class SearchPanel : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    let NewsIdentifier = "News"
    let BasicIdentifier = "Basic"
    let apis : FetchAPIs = FetchAPIs()
    
    //----------------
    var tableView : UITableView!
    var searchView: UIView!
    var searchTextView : TextField!
    var searchBtn : SearchButon!
    var loading : UIActivityIndicatorView!
    var searchBar : UISearchBar!
    //----------------
    var newsSearch: [Data]!
    
    
    var getNewsId : ((_ article_id: Int, _ article_title: String) -> Void)?
    
    
    override func viewDidLoad() {
        viewInit()
    }
    
    private func viewInit(){
        self.tableView = UITableView(frame: CGRect(x: 0, y: 50, width: 414, height: self.view.frame.height-120))
        self.searchView = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 50))
        self.searchTextView = TextField(frame: CGRect(x: 20, y: 10, width: searchView.frame.width-120, height: 30))
        self.searchBtn = SearchButon(frame: CGRect(x: 316, y: 10, width: 78, height: 30))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchTextView.delegate = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: BasicIdentifier)
        self.tableView.register(BodyCell.self, forCellReuseIdentifier: NewsIdentifier)
        
        self.searchTextView.layer.cornerRadius = 5
        self.searchTextView.layer.borderWidth = 0.5
        searchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchBtn.layer.cornerRadius = 5
        searchBtn.layer.borderWidth = 0.5
        searchBtn.addTarget(self, action: #selector(getSearchData(sender:)), for: .touchUpInside)
        self.searchView.backgroundColor = STYLE.THEME_COLOR
        self.searchView.addSubview(searchTextView)
        self.searchView.addSubview(searchBtn)
        self.view.addSubview(tableView)
        self.view.addSubview(searchView)
    }
    
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("inputing: ",self.searchTextView.text!)
        if(self.searchTextView.text != ""){
//            self.getSearchData(sender: self.searchTextView.text!)
            self.searchBtn.keyword = self.searchTextView.text
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.newsSearch != nil {
            return 100
        }
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let x = self.newsSearch {
            return x.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let newsSearch = self.newsSearch {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsIdentifier) as! BodyCell
            cell.article_id = newsSearch[indexPath.row].article_id!
            cell.title.text = newsSearch[indexPath.row].title
            cell.image.kf.setImage(with: URL(string: newsSearch[indexPath.row].image!)!)
            cell.title.numberOfLines = .max
            cell.title.sizeToFit()
            return cell
        } else {
            self.tableView.separatorStyle = .none
            let cell = UITableViewCell()
            self.loading = UIActivityIndicatorView(frame: CGRect(x: 110, y: 50, width: 200, height: 70))
            loading.hidesWhenStopped = true
            loading.style = .medium
            cell.selectionStyle = .none
            cell.addSubview(loading)
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.getNewsId!(newsSearch[indexPath.row].article_id!, newsSearch[indexPath.row].title!)
    }
    
    @objc private func getSearchData(sender: SearchButon){
        self .loading.startAnimating()
        var newsSearch = [Data]()
        self.apis.fetchApis(function: .search, queryParam: sender.keyword! ).done { result in
            let result = result as! NSArray
            for news in result {
                let news = news as! NSDictionary
                let x = Data(article_id: news.value(forKey: "id") as? Int,
                                       image: news.value(forKey: "image") as? String,
                                       title: news.value(forKey: "title") as? String,
                                       type: 1)
                newsSearch.append(x)
            }
        }.catch { err in
            print(err)
        }.finally {
            self.loading.stopAnimating()
            self.newsSearch = newsSearch
            self.tableView.reloadData()
        }
    }
  
}

class SearchButon: UIButton {
    var keyword: String?
}
