//
//  TextCell.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 19/05/2021.
//

import Foundation
import UIKit
class TextCell: UITableViewCell {
    
    var textView: UITextView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    private func viewInit(){
        self.textView = UITextView()
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
//        textView.backgroundColor = .blue
        self.addSubview(textView)
        self.selectionStyle = .none
//        self.addConstraintsWithFormat("H:|-8-[v0]-8-|", views: textView)
//        self.addConstraintsWithFormat("V:|-5-[v0]-5-|", views: textView)
    }
    
}
