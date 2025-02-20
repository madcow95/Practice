//
//  AddTodoView.swift
//  ReactorKit_Todo
//
//  Created by MadCow on 2024/10/31.
//

import SnapKit
import UIKit
import ReactorKit
import RxSwift

class AddTodoView: UIViewController {
    var disposeBag = DisposeBag()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    private let contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        
        return content
    }()
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "제목"
        label.textColor = .white
        label.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    private let titleTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "제목을 입력해주세요."
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tf.leftViewMode = .always
        
        return tf
    }()
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return stackView
    }()
    // MARK: TODO - 선택했을 때 날짜를 선택할 수 있도록 수정
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "날짜"
        label.textColor = .white
        label.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        
        return label
    }()
    private let dateTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false

        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tf.leftViewMode = .always
        tf.isEnabled = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        tf.text = dateFormatter.string(from: Date())
        
        return tf
    }()
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, dateTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return stackView
    }()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "내용"
        label.textColor = .white
        
        return label
    }()
    private let contentTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = .systemFont(ofSize: 16)
        tv.textColor = .white
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        tv.layer.cornerRadius = 10
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureReactor()
        configureUI()
        configureAction()
    }
    
    func configureReactor() {
        self.reactor = AddTodoReactor()
    }
    
    func configureUI() {
        configureScrollView()
        configureButton()
        configureComponents()
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
    }
    
    func configureButton() {
        contentView.addSubview(saveButton)
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.bottom).offset(-10)
            $0.left.equalTo(contentView.snp.left).offset(10)
            $0.right.equalTo(contentView.snp.right).offset(-10)
            $0.height.equalTo(40)
        }
    }
    
    func configureComponents() {
        contentView.addSubview(titleStackView)
        
        titleStackView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(10)
            $0.left.right.equalTo(saveButton)
        }
        
        contentView.addSubview(dateStackView)
        
        dateStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(10)
            $0.left.right.equalTo(titleStackView)
        }
        
        contentView.addSubview(contentLabel)
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(dateStackView.snp.bottom).offset(10)
            $0.left.equalTo(dateStackView.snp.left)
        }
        
        contentView.addSubview(contentTextView)
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(10)
            $0.left.right.equalTo(dateStackView)
            $0.bottom.equalTo(saveButton.snp.top).offset(-10)
        }
    }
    
    func configureAction() {
        saveButton.rx.tap
            .map { Reactor.Action.saveTodoAction(Todo(title: self.titleTextField.text!, content: self.contentTextView.text, imagePaths: [], date: Date(), viewCount: 0, todoReply: [])) }
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
}

extension AddTodoView: View {
    func bind(reactor: AddTodoReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: AddTodoReactor) {
        
    }
    
    private func bindState(_ reactor: AddTodoReactor) {
        
    }
}
