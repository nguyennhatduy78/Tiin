//
//  DetailView.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 05/05/2021.
//

import Foundation
import UIKit

class NewsDetailViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UINavigationControllerDelegate {
   
    let apis = FetchAPIs()
    //-------------------
    
    var id : Int!
    var ids : [Int]!
    var article_titles: [String]!
    //-------------------
    var navBar: NewsDetailNavBar!
    var pageView: UIPageViewController!
    var pages = [UIViewController]()
    var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        viewInit()
    }
    
    private func viewInit(){
        self.view.backgroundColor = .white
//        navbarInit()
        navigationInit()
        newsViewInit()
    }
    
    private func navigationInit(){
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.hidesBackButton = true

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 28))
        self.pageControl = UIPageControl(frame: view.frame)
        pageControl.backgroundStyle = .automatic
        pageControl.autoresizesSubviews = true
        pageControl.numberOfPages = ids.count
        pageControl.isEnabled = false
        view.addSubview(self.pageControl)
        self.navigationItem.titleView = view

        let shareBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        shareBtn.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        shareBtn.tintColor = .white
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: shareBtn), animated: true)
        
        let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        backBtn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backBtn.tintColor = .white
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: backBtn), animated: true)
        
    }
    
    private func navbarInit(){
        self.navBar = NewsDetailNavBar()
        navBar.backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        navBar.pageControl.numberOfPages = ids.count
        self.view.addSubview(navBar)
    }
    
    private func newsViewInit(){
        self.pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageView.view.frame = CGRect(x: 0, y: 0, width: 414, height: 865)
        pageView.delegate = self
        pageView.dataSource = self
        for i in 0..<ids.count{
            let vc = NewsDetailView()
            vc.test_id = ids[i]
            vc.article_title = article_titles[i]
            vc.getArticleId = { (id, title) in
                self.getNewsDetail(id: id, title: title)
            }
            pages.append(vc)
        }
        pageView.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        self.view.addSubview(pageView.view)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let idx = self.pages.firstIndex(of: viewController){
//            self.navBar.pageControl.currentPage = idx
            self.pageControl.currentPage = idx
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
//            self.navBar.pageControl.currentPage = idx
            self.pageControl.currentPage = idx
            if idx < self.pages.count - 1 {
                    return self.pages[idx + 1 ]
                }else {
                    return nil
                }
        }
        return nil
    }
    
    @objc private func back() {
        self.navigationController?.popViewController(animated: true)
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
}
