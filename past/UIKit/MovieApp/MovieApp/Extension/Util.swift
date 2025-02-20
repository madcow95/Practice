//
//  Util.swift
//  MovieApp
//
//  Created by MadCow on 2024/7/4.
//

import UIKit

extension UIViewController {
    func showAlert(msg: String) {
        let alertController = UIAlertController(title: "오류!", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
