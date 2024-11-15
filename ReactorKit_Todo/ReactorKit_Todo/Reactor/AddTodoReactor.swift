//
//  AddTodoReactor.swift
//  ReactorKit_Todo
//
//  Created by MadCow on 2024/11/12.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class AddTodoReactor: Reactor {
    let initialState = State()
    
    enum Action {
        case saveTodoAction(Todo)
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .saveTodoAction(let todo):
            // MARK: TODO - CoreData / SwiftData / Firebase에 저장
            // 아이고..
            return .empty()
        }
    }
}
