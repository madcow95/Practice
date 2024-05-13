//
//  MuscleMemoryCreateView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/13.
//

import UIKit

class MuscleMemoryCreateView: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 화면으로 이동할 때 NavigationBar를 다시 보여줍니다.
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
