//
//  TestViewController.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 20/04/2021.
//

import UIKit
import Alamofire
import PromiseKit
import Kingfisher
import AVKit

class MainViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UINavigationControllerDelegate{
    
    var fetching_data : [Data] = [Data]()
    let apis: FetchAPIs = FetchAPIs()
    let group: DispatchGroup = DispatchGroup()
    let helper: Helper = Helper()
    //----------------------------
    var testBar: UINavigationBar!
    var menuBar: MenuBar!
    var navBar: NavBar!
    var pageView: UIPageViewController!
    var pages = [UIViewController]()
    
    var newsPage: CategoryTable!
    var videoPage: CategoryTable!
    var imagePage: CategoryTable!
    
    //Variable
    let firstPage = 0
    var currentIdx = 0
    
    override func viewDidLoad() {
        print("Size: ", self.view.bounds)
        super.viewDidLoad()
        viewInit()
    }
    
    func viewInit(){
        topBarInit()
        dataListViewInit()
        navBarInit()
//        menuBarInit()
    }
    
    private func topBarInit(){
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = STYLE.THEME_COLOR
        self.navigationItem.hidesBackButton = true
        
        
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        imageView.frame = view.frame
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        self.navigationItem.titleView = view
        
        let menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25 ))
        menuBtn.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        menuBtn.tintColor = .white
        menuBtn.addTarget(self, action: #selector(getMenuView), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        searchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchBtn.tintColor = .white
        searchBtn.addTarget(self, action: #selector(getSearchView), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
    }
    
    
    private func menuBarInit(){
        self.menuBar = MenuBar()
        self.view.addSubview(menuBar)
    }
    
    private func navBarInit(){
        self.navBar = NavBar()
        navBar.news.addTarget(self, action: #selector(newsView), for: .touchUpInside)
        navBar.video.addTarget(self, action: #selector(videoView), for: .touchUpInside)
        navBar.image.addTarget(self, action: #selector(imageView), for: .touchUpInside)
        self.view.addSubview(navBar)
    }
    
    private func dataListViewInit(){
        self.pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageView.view.frame = CGRect(x: 0, y: 35, width: 414, height: 840 )
        pageView.delegate = self
        pageView.dataSource = self
        
        self.newsPage = CategoryTable()
        self.videoPage = CategoryTable()
        self.imagePage = CategoryTable()
        
        newsPage.dataType = 1
        videoPage.dataType = 2
        imagePage.dataType = 3
        
        var newsData: [Data] = [Data]()
        for i in fetching_data {
            if(i.type == 1) {
                let tmp = Data(article_id: i.article_id, image: i.image, title: i.title, type: i.type)
                newsData.append(tmp)
            }
        }
        
        var videoData: [Data] = [Data]()
        for i in fetching_data {
            if(i.type == 2) {
                let tmp = Data(article_id: i.article_id, image: i.image, title: i.title, type: i.type)
                videoData.append(tmp)
            }
        }
        
        var imageData: [Data] = [Data]()
        for i in fetching_data {
            if(i.type == 3) {
                let tmp = Data(article_id: i.article_id, image: i.image, title: i.title, type: i.type)
                imageData.append(tmp)
            }
        }
        
        newsPage.fetch_data = newsData
        videoPage.fetch_data = videoData
        imagePage.fetch_data = imageData
        
        pages.append(newsPage)
        pages.append(videoPage)
        pages.append(imagePage)
        pageView.setViewControllers([pages[firstPage]], direction: .forward, animated: true, completion: nil)
        self.view.addSubview(pageView.view)
        
        
        newsPage.getArticleId = {(article_id :Int, article_title: String) in
            self.getNewsDetail(id: article_id, title: article_title)
        }
        videoPage.getArticleId = {(id: Int, title:String) in
            self.getVideoDetail(id: id, title: title)
        }
        imagePage.getArticleId = { (id: Int, title: String) in
            self.getImageDetail(id: id, title: title)
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let idx = self.pages.firstIndex(of: viewController){
            navBar.transition(next: idx)
            if idx == 0{
                return nil
            } else {
                return self.pages[idx - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let idx = self.pages.firstIndex(of: viewController) {
            navBar.transition(next: idx)
            if idx < self.pages.count - 1 {
                    return self.pages[idx + 1 ]
                }else {
                    return nil
                }
        }
        return nil
    }
    
    @objc func newsView(){
        self.pageView.setViewControllers([self.pages[0]], direction: .reverse, animated: true, completion: nil)
        self.navBar.transition(next: 0)
    }
    @objc func videoView(){
        if(self.currentIdx > 1) {
            self.pageView.setViewControllers([self.pages[1]], direction: .forward, animated: true, completion: nil)
            self.navBar.transition(next: 1)
        } else {
            self.pageView.setViewControllers([self.pages[1]], direction: .forward, animated: true, completion: nil)
            self.navBar.transition(next: 1)
        }
    }
    @objc func imageView(){
        self.pageView.setViewControllers([self.pages[2]], direction: .forward, animated: true, completion: nil)
        self.navBar.transition(next: 2)
    }
    
    
    private func getNewsDetail(id: Int, title: String){
        var titles = [String]()
        var ids = [Int]()
        ids.append(id)
        titles.append(title)
        self.apis.fetchApis(function: .getNewsRelated, queryParam: "\(id)").done { result in
            let result = result as! NSArray
            for news in result {
                let news = news as! NSDictionary
                ids.append(news.value(forKey: "id") as! Int)
                titles.append(news.value(forKey: "title") as! String)
            }
        }.catch { err in
            print(err)
        }.finally {
            let vc = NewsDetailViewController()
            vc.modalPresentationStyle = .popover
            vc.ids = ids
            vc.article_titles = titles
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func getVideoDetail(id: Int, title: String){
        print("Video: \(id), \(title)")
//        let videoDetail = VideoDetailViewController()
//        videoDetail.view.frame = self.view.bounds
//        self.navigationController?.pushViewController(videoDetail, animated: true)
        let x = UIViewController()
        x.view.frame = UIScreen.main.bounds
        let url = "http://medianews.netnews.vn:6868/tiin/archive/media/327/202106/20210615/12_030041811480124.mp4"
        let player = AVPlayer(url: URL(string: url)!)
        let videoPlayer = AVPlayerViewController()
        videoPlayer.view.frame = x.view.frame
        print(videoPlayer.videoBounds)
        videoPlayer.showsPlaybackControls = true
        videoPlayer.player = player
        player.play()
        
        x.addChild(videoPlayer)
        x.view.addSubview(videoPlayer.view)
        videoPlayer.didMove(toParent: x)
        videoPlayer.entersFullScreenWhenPlaybackBegins = true
        self.navigationController?.pushViewController(x, animated: true)
        
    }
    
    private func getImageDetail(id: Int, title:String){
        print("Image: \(id), \(title)")
    }
    
    @objc private func getMenuView (){
        let x = MenuTableView()
        x.view.frame = CGRect(x: 0, y: 20, width: 414, height: self.view.frame.height-30)
        x.modalPresentationStyle = .popover
        x.getCategoryID = { id, title in
            print("ID: ", id)
            var fetchData = [Data]()
            let query = "?category_id=\(id)&page=1&num=\(PAGE.limit)"
            self.apis.fetchApis(function: .getCategory, queryParam: query).done { result in
                let result = result as! NSArray
                for x in result {
                    let y = x as! NSDictionary
                 let news = Data(article_id: y.value(forKey: "id") as? Int, image: y.value(forKey: "image") as? String, title: y.value(forKey: "title") as? String, type: 1)
                    fetchData.append(news)
                }
            }.catch { err in
                print(err)
            }.finally {
                let tableView = CategoryTable()
                tableView.fetch_data = fetchData
                tableView.dataType = 1
                tableView.view.frame = UIScreen.main.bounds
                tableView.getArticleId = {id,title in
                    self.getNewsDetail(id: id, title: title)
                }
                x.dismiss(animated: true) {
                    self.navigationController?.pushViewController(tableView, animated: true)
                    tableView.navigationItem.backBarButtonItem?.tintColor = .white
                    tableView.navigationItem.title = title
                }
            }
        }
        self.present(x, animated: true, completion: nil)
    }
    
    @objc private func getSearchView (){
        let x = SearchPanel()
        x.view.frame = self.view.frame
        x.modalPresentationStyle = .popover
        x.getNewsId = { (id, title) in
            x.dismiss(animated: true, completion: nil)
            self.getNewsDetail(id: id, title: title)
        }
        self.present(x, animated: true, completion: nil)
    }
}
