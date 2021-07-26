//
//  LaunchViewController.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 05/05/2021.
//

import UIKit
import PromiseKit
import Alamofire

class LaunchViewController: UIViewController {

    let helper: Helper = Helper()
    let apis: FetchAPIs = FetchAPIs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImageView(frame: CGRect(x: 104, y: 330, width: 206, height: 177))
        image.image = UIImage(named: "LaunchScreen")
        image.contentMode = .scaleAspectFit
        self.view.addSubview(image)
        viewInit()
    }
    
    private func viewInit(){
        let loading = UIActivityIndicatorView(frame: CGRect(x: 104, y: 520, width: 200, height: 70))
        loading.hidesWhenStopped = true
        loading.style = .large
        self.view.addSubview(loading)
        loading.startAnimating()
        var fetchData: [Data] = [Data]()
           firstly{
               self.apis.fetchApis(function: .getNewsPage, queryParam: "1").done { (newsData) in
                   let result = newsData as! NSArray
                   for x in result {
                       let y = x as! NSDictionary
                    let news = Data(article_id: y.value(forKey: "id") as? Int, image: y.value(forKey: "image") as? String, title: y.value(forKey: "title") as? String, type: 1)
                       fetchData.append(news)
                   }
               }
           }.then {
               self.apis.fetchApis(function: .getVideo, queryParam: "1").done { (data) in
                   let res = data as! NSArray
                   for x in res {
                       let y = x as! NSDictionary
                       let video = Data(article_id: y.value(forKey: "id") as? Int, image: y.value(forKey: "image") as? String, title: y.value(forKey: "title") as? String, type: 2)
                      fetchData.append(video)
                   }
               }
           }.then{
               self.apis.fetchApis(function: .getImage, queryParam: "1").done { (data) in
                   let res = data as! NSArray
                   for x in res {
                       let y = x as! NSDictionary
                       let image = Data(article_id: y.value(forKey: "id") as? Int, image: y.value(forKey: "image") as? String, title: y.value(forKey: "title") as? String, type: 3)
                       fetchData.append(image)
                   }
               }
           }.catch { (err) in
               print("err: ",err)
           }.finally {
            let mainView = MainViewController()
            mainView.fetching_data = fetchData
            let navbar = UINavigationController(rootViewController: mainView)
            navbar.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainView, animated: true)
           }
    }

}
