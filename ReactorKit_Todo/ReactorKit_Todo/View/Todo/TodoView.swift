//
//  TodoView.swift
//  ReactorKit_Todo
//
//  Created by MadCow on 2024/10/31.
//

import SnapKit
import UIKit
import ReactorKit
import RxSwift

class TodoView: UIViewController {
    var disposeBag = DisposeBag()
    private var todos: [Todo] = []
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TodoViewCell.self, forCellReuseIdentifier: "TodoViewCell")
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = TodoReactor(pushToAddView: { [weak self] view in
            guard let self = self else { return }
            self.navigationController?.pushViewController(view, animated: true)
        })
        configureUI()
    }
    
    func configureUI() {
        setNavigationComponents()
        setTable()
    }
    
    func setNavigationComponents() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = addButton
        
        addButton.rx.tap
            .map { Reactor.Action.moveToAddViewAction }
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
    
    func setTable() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.left.right.equalToSuperview()
        }
    }
}

extension TodoView: View {
    func bind(reactor: TodoReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: TodoReactor) {
        tableView.rx.itemSelected
            .withLatestFrom(reactor.state) { indexPath, state in
                state.todos[indexPath.row]
            }
            .map { Reactor.Action.editTodoAction($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: TodoReactor) {
        reactor.state
            .map { $0.todos }
            .bind(to: tableView.rx.items(cellIdentifier: "TodoViewCell", cellType: TodoViewCell.self)) { index, item, cell in
                cell.configureCell(idx: index)
            }
            .disposed(by: disposeBag)
    }
}
