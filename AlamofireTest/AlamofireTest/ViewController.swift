//
//  ViewController.swift
//  AlamofireTest
//
//  Created by MadCow on 2024/7/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    private lazy var testButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2).isActive = true
        btn.heightAnchor.constraint(equalToConstant: self.view.frame.height / 3).isActive = true
        btn.setTitle("Alamofire 테스트", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(testButton)
        
        NSLayoutConstraint.activate([
            testButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        // 축구 K리그 API
        // 이미지 저장 -> AR로 보이기
        // 술게임 앱
        // 술 관련, 안주 조합 추천(편의점 ver)
        testButton.addAction(UIAction { _ in
            guard let url = URL(string: "https://microsoftedge.github.io/Demos/json-dummy-data/64KB.json") else { return }
            AF.request(url).response { response in
                guard let data = response.data else { return }
                print(String(decoding: data, as: UTF8.self))
            }
//            AF.request(url).responseJSON { response in
//                switch response.result {
//                case .success(let data):
//                    print("Success with JSON: \(data)")
//                case .failure(let error):
//                    print("Request failed with error: \(error)")
//                }
//            }
//            Task {
//                do {
//                    let (data, response) = try await URLSession.shared.data(from: url)
//                    
//                    guard let res = response as? HTTPURLResponse else { return }
//                    
//                    if res.statusCode == 200 {
//                        print(String(decoding: data, as: UTF8.self))
//                    } else {
//                        print("error")
//                    }
//                } catch {
//                    print("error \(error.localizedDescription)")
//                }
//            }
        }, for: .touchUpInside)
    }
}

