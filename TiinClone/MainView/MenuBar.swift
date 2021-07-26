//
//  MenuBar.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 05/05/2021.
//

import Foundation
import UIKit
class MenuBar: UIView {
    var menuBtn: UIButton!
    var image: UIImageView!
    var searchBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    private func viewInit(){
        self.frame = CGRect(x: 0, y: 0, width: 414, height: 85)
        self.backgroundColor = UIColor(red: 221/255, green: 34/255, blue: 107/255, alpha: 1)
        self.menuBtn = UIButton()
        self.image = UIImageView()
        self.searchBtn = UIButton()
        
        menuBtn.frame = CGRect(x: 0, y: 45, width: 30, height: 30)
        menuBtn.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        menuBtn.tintColor = .white
        
        image.frame = CGRect(x: 35, y: 45, width: 80, height: 30)
        image.image = UIImage(named: "Logo")
        
        searchBtn.frame = CGRect(x: 374, y: 45, width: 30, height: 30)
        searchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchBtn.tintColor = .white
        
        self.addSubview(menuBtn)
        self.addSubview(image)
        self.addSubview(searchBtn)
        
    }
}
