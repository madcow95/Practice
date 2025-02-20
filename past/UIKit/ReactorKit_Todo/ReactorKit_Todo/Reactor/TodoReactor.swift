//
//  TodoReactor.swift
//  ReactorKit_Todo
//
//  Created by MadCow on 2024/10/31.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class TodoReactor: Reactor {
    let pushToAddView: ((UIViewController) -> Void)
    let initialState = State()
    
    init(pushToAddView: @escaping (UIViewController) -> Void) {
        self.pushToAddView = pushToAddView
    }
    
    enum Action {
        case moveToAddViewAction
        case addTodoAction(Todo)
        case editTodoAction(Todo)
        case deleteTodoAction(IndexPath)
    }
    
    enum Mutation {
        case addTodo(Todo)
        case editTodo(Todo)
        case deleteTodo(IndexPath)
    }
    
    struct State {
        var todos: [Todo] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .moveToAddViewAction:
            let addView = AddTodoView()
            self.pushToAddView(addView)
            return .empty()
        case let .addTodoAction(todo):
            return .just(.addTodo(todo))
        case let .editTodoAction(todo):
            return .just(.editTodo(todo))
        case let .deleteTodoAction(indexPath):
            return .just(.deleteTodo(indexPath))
        }
    }
    
//    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
//        let navigation = self.action.filter { action in
//            if case .moveToAddViewAction = action {
//                return true
//            }
//            return false
//        }
//        .map { _ in
//            let addView = AddTodoView()
//            return addView
//        }
//        .do(onNext: { [weak self] view in
//            self?.pushToAddView(view)
//        })
//        .flatMap { _ in Observable<Mutation>.empty() }
//        
//        return Observable.merge(mutation, navigation)
//    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .addTodo:
            break
        case .editTodo:
            break
        case .deleteTodo:
            break
        }
        
        return newState
    }
}
