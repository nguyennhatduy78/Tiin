//
//  Player.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 16/06/2021.
//

import Foundation
import AVKit
import UIKit

class Player: AVPlayerViewController{
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
