//
//  ImageCell.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 19/05/2021.
//

import Foundation
import UIKit

class ImageCell : UITableViewCell{


    var imageViewer: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    private func viewInit(){
        self.imageViewer = UIImageView()
        imageViewer.frame = self.frame
//        self.backgroundColor = .blue
        self.addSubview(imageViewer)
        self.selectionStyle = .none
    }
}
