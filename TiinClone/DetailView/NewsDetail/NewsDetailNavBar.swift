//
//  NavBarDetail.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 05/05/2021.
//

import Foundation
import UIKit

class NewsDetailNavBar: UIView {

    var backBtn: UIButton!
    var category: UILabel!
    var pageControl: UIPageControl!
    var shareBtn : UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }

    private func viewInit(){
        self.frame = CGRect(x: 0, y: 0, width: 414, height: 50)
        self.backgroundColor = UIColor(red: 221/255, green: 34/255, blue: 107/255, alpha: 1)
        self.backBtn = UIButton(frame: CGRect(x: 5, y: 10, width: 30, height: 30))
        self.category = UILabel(frame: CGRect(x: 45, y: 10, width: 60, height: 30))
        self.shareBtn = UIButton(frame: CGRect(x: 380, y: 10, width: 30, height: 30))
        self.pageControl = UIPageControl(frame: CGRect(x: 230, y: 11, width: 150, height: 28))
        
        backBtn.tintColor = .white
        backBtn.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        category.textColor = .white
        shareBtn.tintColor = .white
        shareBtn.setBackgroundImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        pageControl.backgroundStyle = .automatic
        pageControl.autoresizesSubviews = true
        self.addSubview(backBtn)
        self.addSubview(category)
        self.addSubview(pageControl)
        self.addSubview(shareBtn)
    }
}
