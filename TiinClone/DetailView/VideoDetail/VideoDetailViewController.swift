//
//  VideoDetailViewController.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 16/06/2021.
//

import Foundation
import UIKit
import AVKit

class VideoDetailViewController: UITableViewController {
    
    let VideoDetailCellIdentifier = "VideoDetailCell"
    
    
    override func viewDidLoad() {
        self.tableView.register(VideoDetailViewCell.self, forCellReuseIdentifier: VideoDetailCellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoDetailCellIdentifier) as! VideoDetailViewCell
        if(indexPath.row == 0){
            let url = "http://medianews.netnews.vn:6868/tiin/archive/media/327/202106/20210615/12_030041811480124.mp4"
            let player = AVPlayer(url: URL(string: url)!)
            let videoPlayer = AVPlayerViewController()
            videoPlayer.view.frame = CGRect(x: 10, y: 0, width: 394, height: 240)
            videoPlayer.showsPlaybackControls = true
            cell.videoView.player = player
            videoPlayer.player = player
            player.play()
        }
        cell.selectionStyle = .none
        return cell
    }
}
