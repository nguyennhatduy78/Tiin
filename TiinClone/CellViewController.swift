//
//  CellViewController.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 04/05/2021.
//

import UIKit

class NewsViewController: UIViewController {

    var idx = 0
    var colors: [UIColor] = [
        .brown,
        .green,
        .blue,
        .cyan
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollview : UIScrollView = UIScrollView()
        scrollview.frame = self.view.frame
        let viewtest : UIView = UIView()
        viewtest.backgroundColor = colors[idx]
        viewtest.frame = scrollview.frame
        scrollview.addSubview(viewtest)
        self.view.addSubview(scrollview)
        scrollview.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
        scrollview.isPagingEnabled = true
        scrollview.bounces = false
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
