//
//  NavBar.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 04/05/2021.
//

import Foundation
import UIKit

@IBDesignable class NavBar: UIView {
    
    var news: UIButton!
    var video: UIButton!
    var image: UIButton!
    var selectView: UIStackView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    func viewInit(){
        self.frame = CGRect(x: 0, y: 0, width: 414, height: 35)
        self.backgroundColor = STYLE.THEME_COLOR
        self.news = UIButton(frame: CGRect(x: 0, y: 0, width: 138, height: 35))
        self.video = UIButton(frame: CGRect(x: 138, y: 0, width: 138, height: 35))
        self.image = UIButton(frame: CGRect(x: 276, y: 0, width: 138, height: 35))
        self.selectView = UIStackView(frame: CGRect(x: 0, y: 33, width: 414, height: 2))
        news.setTitle("News", for: .normal)
        video.setTitle("Video", for: .normal)
        image.setTitle("Image", for: .normal)
        self.addSubview(news)
        self.addSubview(video)
        self.addSubview(image)
        self.addSubview(selectView)
        menuInit()
    }
    
    
    func transition(next: Int) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.transitionFlipFromLeft], animations: {
            self.active.backgroundColor = UIColor(red: 221/255, green: 34/255, blue: 107/255, alpha: 1)
            self.selectView.arrangedSubviews[next].backgroundColor = .white
            self.active = self.selectView.arrangedSubviews[next]
        }, completion: nil)
    }
    
    private lazy var active: UIView! = {
        return self.selectView.arrangedSubviews.first
    }()
    
    private func menuInit(){
        self.selectView.distribution = .fillEqually
        for _ in 0..<3 {
            let view = UIView(frame: self.selectView.frame)
            self.selectView.addArrangedSubview(view)
        }
        active.backgroundColor = .white
    }
}
