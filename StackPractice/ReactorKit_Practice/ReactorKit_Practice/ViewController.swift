//
//  ViewController.swift
//  ReactorKit_Practice
//
//  Created by MadCow on 2024/10/31.
//

import UIKit
import RxSwift
import ReactorKit
import SnapKit

class ViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    let increaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("+", for: .normal)
        return button
    }()
    let decreaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("-", for: .normal)
        return button
    }()
    let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.textAlignment = .center
        label.text = "0"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = ViewReactor()
        setupUI()
    }
    
    // MARK: - UI Function
    func setupUI() {
        view.addSubview(increaseButton)
        increaseButton.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
            $0.width.height.equalTo(20)
        }
        view.addSubview(decreaseButton)
        decreaseButton.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(increaseButton.snp.bottom).offset(20)
            $0.width.height.equalTo(20)
        }
        view.addSubview(numberLabel)
        numberLabel.snp.makeConstraints {
            $0.top.equalTo(decreaseButton.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(40)
            $0.height.equalTo(20)
        }
    }
}

extension ViewController: View {
    func bind(reactor: ViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: ViewReactor) {
        increaseButton.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: ViewReactor) {
        reactor.state
            .map { String($0.value) }
            .distinctUntilChanged()
            .bind(to: numberLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
