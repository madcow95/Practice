//
//  VideoPlayView.swift
//  CombineTest
//
//  Created by MadCow on 2024/5/8.
//

import UIKit
import AVFoundation

class VideoPlayView: UIViewController {
    
    var videoUrlString: String = ""    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        guard let videoUrl: URL = URL(string: self.videoUrlString) else { return }
        player = AVPlayer(url: videoUrl)
                
        // AVPlayerLayer 생성
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        
        // AVPlayerLayer를 ViewController의 view의 layer에 추가
        view.layer.addSublayer(playerLayer)
        
        // 비디오 재생
        player.play()
    }
}
