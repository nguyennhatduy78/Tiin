//
//  TestCollectionViewCell.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 28/04/2021.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell {
    var color : UIColor = .clear
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        cellInit()
    }
    
    func cellInit(){
        let image: UIImageView = {
            let x  = UIImageView()
            x.contentMode = .scaleAspectFill
            x.translatesAutoresizingMaskIntoConstraints = false
            x.clipsToBounds = true
            x.backgroundColor = self.color
            return x
        }()
        image.frame = CGRect(x: 12, y: 12, width: 100, height: 100)
        self.addSubview(image)
    }
    
}
