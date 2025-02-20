//
//  ViewController.swift
//  PlayYoutubeTest
//
//  Created by MadCow on 2024/8/6.
//

import UIKit
import AVKit
import AVFoundation

//class ViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // 예시 버튼 추가
//        let button = UIButton(type: .system)
//        button.setTitle("Show Video", for: .normal)
//        button.addTarget(self, action: #selector(showVideoPopup), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(button)
//        
//        // 버튼 오토레이아웃 설정
//        NSLayoutConstraint.activate([
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//    
//    @objc private func showVideoPopup() {
//        let videoPopupVC = VideoPopupViewController()
//        // 예시 YouTube 비디오 URL (직접 mp4 파일 URL 사용)
//        if let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") {
//            videoPopupVC.videoURL = url
//        }
//        
//        videoPopupVC.modalPresentationStyle = .popover
//        if let popoverPresentationController = videoPopupVC.popoverPresentationController {
//            popoverPresentationController.sourceView = self.view
//            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
//            popoverPresentationController.permittedArrowDirections = []
//            popoverPresentationController.delegate = self
//        }
//        
//        present(videoPopupVC, animated: true, completion: nil)
//    }
//}
//
//// PopoverPresentationControllerDelegate를 확장하여 필요한 델리게이트 메서드를 구현
//extension ViewController: UIPopoverPresentationControllerDelegate {
//    private func adaptivePresentationStyle(for controller: UIPopoverPresentationController) -> UIModalPresentationStyle {
//        return .none // 팝오버 스타일을 유지
//    }
//}


class ViewController: UIViewController {
    
    // var videoURL: URL? // YouTube URL을 전달받을 프로퍼티
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") {
            let player = AVPlayer(url: url)
            let controller=AVPlayerViewController()
            controller.player=player
            controller.view.frame = self.view.frame
            self.view.addSubview(controller.view)
            //            self.addChildViewController(controller)

            player.play()
        }
    }
}
