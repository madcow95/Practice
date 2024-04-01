//
//  CommonUtil.swift
//  simpleRecord
//
//  Created by MadCow on 2024/4/1.
//

import UIKit

class CommonUtil: UIViewController {
    func showAlertBy(buttonActions: [UIAlertAction], msg: String, mainView: UIViewController) {
        let alertController = UIAlertController(title: "알림", message: msg, preferredStyle: .alert)
        
        buttonActions.forEach{ alertController.addAction($0) }
        
        mainView.present(alertController, animated: true, completion: nil)
    }
}
