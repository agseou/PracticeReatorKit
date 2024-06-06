//
//  ViewReactor.swift
//  PracticeReatorKit
//
//  Created by eunseou on 6/6/24.
//

import ReactorKit

/*
 Side Effects
 Manager, Service
 -> transform
 */

class ViewReactor: Reactor {

    // 화면에서 일어나느 Event
    enum Action {
        case countUp // +
        case countDown // -
    }
    
    // State를 변경하는 단위
    enum Mutation {
        case changeNum(Int) // + & - 처리 동시에
    }
    
    
    struct State {
        var value: Int = 0
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .countUp:
            return Observable.just(.changeNum(1))
        case .countDown:
            return Observable.just(.changeNum(-1))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .changeNum(let num):
            newState.value = newState.value + num
        }
        return newState
    }
    
}
