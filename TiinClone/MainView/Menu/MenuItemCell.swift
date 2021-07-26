//
//  MenuItemCell.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 01/06/2021.
//

import Foundation
import UIKit

class MenuItemViewCell : UITableViewCell {
    
    var icon: UIImageView!
    var title: UILabel!
    var swtBtn: UISwitch!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewInit(){
        self.backgroundColor = .lightGray
        icon = UIImageView(frame: CGRect(x: 10, y: 10, width: self.frame.height, height: self.frame.height-20))
        icon.contentMode = .scaleAspectFit
        title = UILabel(frame: CGRect(x: self.frame.height + 15, y: 10, width: 150, height: self.frame.height-20))
        swtBtn = UISwitch(frame: CGRect(x: 330, y: 5, width: 50, height: self.frame.height))
        swtBtn.isHidden = true
        self.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        self.addSubview(icon)
        self.addSubview(title)
        self.addSubview(swtBtn)
    }
    
}
