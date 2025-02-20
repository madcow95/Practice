import UIKit

class ViewController: UIViewController {
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = .date
        datePicker.frame = CGRect(x: 20, y: 100, width: 200, height: 40)
        view.addSubview(datePicker)
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc private func dateChanged() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
