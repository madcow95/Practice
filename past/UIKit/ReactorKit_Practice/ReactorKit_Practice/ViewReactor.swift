//
//  ViewReactor.swift
//  ReactorKit_Practice
//
//  Created by MadCow on 2024/10/31.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit

class ViewReactor: Reactor {
    let initialState = State()
    
    // 사용자 상호작용 구분
    enum Action {
        case increase
        case decrease
    }
    
    // 사용자 상호작용에 대한 처리 구분, mutate()와 reduce()의 두단계를 거쳐 Action 스트림을 State 스트림으로 변환
    enum Mutation {
        case increaseNumber
        case decreaseNumber
    }
    
    // 현재 상태, 뷰에 표시할 상태
    struct State {
        var value = 0
    }
    
    // Action을 전달받아 Observable<Mutation>을 생성
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case.increase:
            return .just(.increaseNumber)
        case .decrease:
            return .just(.decreaseNumber)
        }
    }
    
    // 기존의 State와 Mutaion을 참조하여 newState를 View에 반환
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .increaseNumber:
            newState.value += 1
        case .decreaseNumber:
            newState.value -= 1
        }
        
        return newState
    }
}
