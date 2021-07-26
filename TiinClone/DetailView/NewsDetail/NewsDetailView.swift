//
//  DetailView.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 05/05/2021.
//

import Foundation
import UIKit
import WebKit

class NewsDetailView: UITableViewController {
    
    let helper: Helper = Helper()
    let apis = FetchAPIs()
    let TextCellIdentifier = "TextCell"
    let ImageCellIdentifier = "ImageCell"
    let RelatedNewsCellIdentifier = "BodyCell"
    let DefaultCellIdentifier = "BasicCell"
    let blockHeight: CGFloat = 35
    let sapoHeight: CGFloat = 37
    let titleHeight: CGFloat = 50
    //---------------------
    var article_title: String!
    var newsDetail: NewsDetail!
    var blocks: [NewsBlock]!
    var relatedNews: [Data]!
    var test_id : Int?
    //--------------------
    var loading: UIActivityIndicatorView!

    var getArticleId: ((_ id: Int, _ title: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .singleLine
        self.fetch_data(id: test_id!)
//        self.tableView.estimatedRowHeight = 44
//        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(TextCell.self, forCellReuseIdentifier: TextCellIdentifier)
        self.tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCellIdentifier)
        self.tableView.register(BodyCell.self, forCellReuseIdentifier: RelatedNewsCellIdentifier)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: DefaultCellIdentifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let x = relatedNews {
            if(x.count != 0){
                return 2
            } else {
                return 1
            }
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            if let x = blocks {
                return x.count + 3
            }
        } else {
            if let x = relatedNews {
                return x.count
            }
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 1){
            return "Related News"
        } else {
            return nil
        }
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let newsDetail = newsDetail {
            if(indexPath.section == 1) {
                return 100
            } else {
                switch indexPath.row {
                case 0:
                    if(self.article_title.count < 33){
                        return titleHeight
                    } else {
                        return CGFloat((self.article_title.count / 33))*titleHeight
                    }
                case 1:
                    return 45
                case 2:
                    if(newsDetail.sapo!.count < 45) {
                        return sapoHeight
                    } else {
                        return CGFloat(newsDetail.sapo!.count / 45) * sapoHeight
                    }
                default:
                    if(blocks[indexPath.row-3].type == 1){
                        if ( blocks[indexPath.row-3].length! < 50) {
                            return blockHeight
                        } else {
                            return CGFloat(blocks[indexPath.row-3].length! / 50) * blockHeight
                        }
                    } else {
                        let height = (blocks[indexPath.row-3].height! / blocks[indexPath.row-3].width!)*414
                        return CGFloat(height)
                    }
                }
            }
        } else {
            return 140
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let x = newsDetail {
            if(indexPath.section == 0) {
                switch indexPath.row {
                case 0:
                    let cell = TextCell()
                    var height: CGFloat
                    if(self.article_title.count < 33){
                        height = titleHeight
                    } else {
                        height = CGFloat(self.article_title.count / 33) * titleHeight
                    }
                    cell.textView.frame = CGRect(x: 0, y: 0, width: 414, height: height)
                    cell.textView.font = UIFont(name: "Helvetica", size: 25)
                    cell.textView.text = self.article_title
                    return cell
                case 1:
                    let cell = TextCell()
                    cell.textView.frame = CGRect(x: 0, y: 0, width: 414, height: 54)
                    cell.textView.font = UIFont(name: "Helvetica", size: 15)
                    cell.textView.textColor = .black
                    let date = helper.dateConverter(dateNum: x.datePub!)
                    cell.textView.text = date
                    return cell
                case 2:
                    let cell = TextCell()
                    var height: CGFloat
                    if(x.sapo!.count < 45) {
                        height = sapoHeight
                    } else {
                        height = CGFloat(x.sapo!.count / 45) * sapoHeight
                    }
                    cell.textView.frame = CGRect(x: 0, y: 0, width: 414, height: height)

                    cell.textView.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
                    cell.textView.text = x.sapo
                    return cell
                default:
                    if(blocks[indexPath.row-3].type == 1){
                        let cell = TextCell()
                        var height = CGFloat(blocks[indexPath.row-3].length! / 50) * blockHeight
                        if(height == 0){
                            height = blockHeight
                        }
                        cell.textView.frame = CGRect(x: 0, y: 0, width: 414, height: height)
                        let content = blocks[indexPath.row-3].content?.htmlToAttributedString
                        content?.addAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 17)!], range: NSRange(location: 0, length: content!.length))
                        cell.textView.attributedText = content
                        return cell
                    } else {
                        let cell = ImageCell()
                        let height = CGFloat((blocks[indexPath.row-3].height! / blocks[indexPath.row-3].width!)*414)
                        cell.imageViewer.frame = CGRect(x: 0, y: 0, width: 414, height: height)
                        cell.imageViewer.kf.setImage(with: URL(string: blocks[indexPath.row-3].image!)!)
                        cell.imageViewer.backgroundColor = .blue
                        return cell
                    }
                }
            } else {
                let cell = BodyCell()
                cell.article_id = relatedNews[indexPath.row].article_id!
                cell.title.text = relatedNews[indexPath.row].title
                cell.title.numberOfLines = .max
                cell.sizeToFit()
                cell.image.kf.setImage(with: URL(string: relatedNews[indexPath.row].image!)!)
                return cell
            }
        } else {
            switch indexPath.row {
            case 0:
                let cell = TextCell()
                var height: CGFloat
                if(self.article_title.count < 33){
                    height = titleHeight
                } else {
                    height = CGFloat(self.article_title.count / 33) * titleHeight
                }
                cell.textView.frame = CGRect(x: 0, y: 0, width: 414, height: height)
                cell.textView.font = UIFont(name: "Helvetica", size: 25)
                cell.textView.text = self.article_title
                return cell
            default:
                let cell = UITableViewCell()
                self.loading = UIActivityIndicatorView(frame: CGRect(x: 110, y: 50, width: 200, height: 70))
                loading.hidesWhenStopped = true
                loading.style = .large
                loading.startAnimating()
                cell.addSubview(loading)
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1){
            if let cell = tableView.cellForRow(at: indexPath) as? BodyCell {
                self.getArticleId!(cell.article_id, cell.title.text!)
            }
        }
    }
    
    
    private func fetch_data(id: Int){
        var newsRelated = [Data]()
        var newsDetail: NewsDetail!
        self.apis.fetchApis(function: .getNewsRelated, queryParam: "\(id)").done { result in
            let result = result as! NSArray
            for news in result {
                let news = news as! NSDictionary
                let relatedNews = Data(article_id: news.value(forKey: "id") as? Int,
                                       image: news.value(forKey: "image") as? String,
                                       title: news.value(forKey: "title") as? String,
                                       type: 1)
                newsRelated.append(relatedNews)
            }
        }.then{
            self.apis.fetchApis(function: .getNewsDetail, queryParam: "\(id)").done { result in
                let result = result as! NSDictionary
                var blocks = [NewsBlock]()
                let tmp = result.value(forKey: "blocks") as! NSArray
                for x in tmp {
                    let x = x as! NSDictionary
                    let block = NewsBlock(type: x.value(forKey: "type") as? Int,
                                      content: x.value(forKey: "content") as? String,
                                      length: x.value(forKey: "length") as? Int,
                                      video: x.value(forKey: "video") as? String,
                                      image: x.value(forKey: "image") as? String,
                                      width: x.value(forKey: "width") as? Int,
                                      height: x.value(forKey: "height") as? Int)
                    blocks.append(block)
                }
                newsDetail = NewsDetail(news_id: result.value(forKey: "id") as? Int,
                                            pid: result.value(forKey: "pid") as? Int,
                                            cid: result.value(forKey: "cid") as? Int,
                                            title: result.value(forKey: "title") as? String,
                                            image: result.value(forKey: "image") as? String ,
                                            image_large: result.value(forKey: "image_large") as? String,
                                            content: result.value(forKey: "content") as? String,
                                            sapo: result.value(forKey: "sapo") as? String,
                                            datePub: result.value(forKey: "datePub") as? CGFloat,
                                            category: Category(category: result.value(forKey: "category") as? String,
                                                               category_alias: result.value(forKey: "category_alias") as? String,
                                                               parent_category: result.value(forKey: "parent_category") as? String,
                                                               parent_category_alias: result.value(forKey: "parent_category_alias") as? String),
                                            author: result.value(forKey: "author") as? String,
                                            source: result.value(forKey: "source") as? String,
                                            blockNum: result.value(forKey: "total_blocks") as? Int,
                                            blocks:blocks, relatedNews: newsRelated)
            }
        }.catch { err in
            print(err)
        }.finally {
            self.blocks = newsDetail.blocks
            self.relatedNews = newsDetail.relatedNews
            self.newsDetail = newsDetail
           self.tableView.reloadData()
        }
    }
    
}
