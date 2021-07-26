//
//  VideoDetailViewCell.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 16/06/2021.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class VideoDetailViewCell: UITableViewCell {
    
    var videoDetail: VideoDetail!
    
    var title: UITextView!
    var sapo: UITextView!
    
    var videoView: AVPlayerLayer!
    var videoPlayer: AVPlayerViewController!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewInit(){
        self.title = UITextView()
        self.sapo = UITextView()
        //height: 400
        title.frame = CGRect(x: 10, y: 250, width: 394, height: 70)
        sapo.frame = CGRect(x: 10, y: 330, width: 394, height: 60)
        
        self.videoView = AVPlayerLayer()
        self.videoView.frame = CGRect(x: 10, y: 0, width: 394, height: 240)
//        self.videoPlayer = AVPlayerViewController()
//        videoPlayer.view.frame = CGRect(x: 10, y: 0, width: 394, height: 240)
//        videoPlayer.showsPlaybackControls = true
        
        
        title.backgroundColor = .blue
        sapo.backgroundColor = .green
        
        self.addSubview(title)
        self.addSubview(sapo)
        self.layer.addSublayer(self.videoView)
//        self.contentView.addSubview(videoPlayer.view)
    }
    
}
