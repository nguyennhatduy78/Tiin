//
//  BodyCell.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 06/05/2021.
//

import Foundation
import UIKit

class BodyCell : UITableViewCell {
    
    var article_id: Int = 0
    var image: UIImageView!
    var title: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        cellInit()
    }
    
    private func cellInit(){
        self.frame = CGRect(x: 0, y: 0, width: 414, height: 100)
        self.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        self.title = UILabel()
        self.image = UIImageView()
        image.frame = CGRect(x: 8, y: 5, width: 132, height: self.frame.height-10)
        title.frame = CGRect(x: 142, y: 5, width: self.frame.width-8-142 , height: self.frame.height-10)
        title.lineBreakMode = .byWordWrapping
        title.contentMode = .top
//        title.sizeToFit()
//        title.numberOfLines = 0
        self.addSubview(image)
        self.addSubview(title)
    }
}
