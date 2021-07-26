//
//  HeaderCell.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 06/05/2021.
//

import Foundation
import UIKit

class HeaderCell : UITableViewCell {
    
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
    
    private func cellInit() {
        self.frame = CGRect(x: 0, y: 0, width: 414, height: 270)
        self.separatorInset = .init(top: 0, left: 10, bottom: 10, right: 10)
        self.image = UIImageView()
        self.title = UILabel()
        image.frame = CGRect(x: 8, y: 10, width: self.frame.width-16, height: 180)
        title.frame = CGRect(x: 8, y: 180, width: self.frame.width-16, height: 80)
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 3
        self.addSubview(image)
        self.addSubview(title)
    }
}
