//
//  Demo2Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit
import AVKit

class Demo2Controller: UIViewController {
    fileprivate lazy var player: AVPlayer? = {
        guard let path = Bundle.main.path(forResource: "login-bg-video.mp4", ofType: nil) else {return nil}
        let url = URL(fileURLWithPath: path)
        let temp = AVPlayer(url: url)
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UI
extension Demo2Controller {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        
        NotificationCenter.default.addObserver(self, selector: #selector(playFinish), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
        let avControl = AVPlayerViewController()
        avControl.player = player
        avControl.videoGravity = AVLayerVideoGravity.resizeAspectFill.rawValue
        avControl.showsPlaybackControls = false
        avControl.view.frame = view.bounds
        
        view.insertSubview(avControl.view, at: 0)
        self.addChildViewController(avControl)
        avControl.player?.play()
    }
}

extension Demo2Controller {
    @objc fileprivate func playFinish(notifyObj:NSNotification) {
        let playerItem = notifyObj.object as? AVPlayerItem
        playerItem?.seek(to: kCMTimeZero, completionHandler: nil)
        player?.play()
    }
}

