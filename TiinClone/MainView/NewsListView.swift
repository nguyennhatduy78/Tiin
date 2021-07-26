//
//  NewsList.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 04/05/2021.
//

import UIKit

class DataViewController: UIScrollView {
    
    var fetch_data = [Data]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    private func viewInit(){
        let headerView = HeaderView()
        self.addSubview(headerView)
        var y: CGFloat = 270
        var height = headerView.frame.height
        for _ in 0..<20 {
            let x = bodyViewInit(y: y)
            height += (x.frame.height+10)
            y += x.frame.height+10
            self.addSubview(x)
        }
        self.contentSize = CGSize(width: 414, height: height)
    }
    
    private func bodyViewInit(y: CGFloat) -> UIView {
        let x = UIView()
        x.frame = CGRect(x: 8, y: y, width: 398, height: 80)
        let image = UIImageView()
        let title = UITextView()
        image.frame = CGRect(x: 0, y: 0, width: 140, height: 80)
        image.backgroundColor = .red
        title.frame = CGRect(x: 140, y: 0, width: 258, height: 80)
        title.backgroundColor = .lightGray
        title.isEditable = false
        x.addSubview(image)
        x.addSubview(title)
        return x
    }
}
