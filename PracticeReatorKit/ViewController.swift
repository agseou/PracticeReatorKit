//
//  ViewController.swift
//  PracticeReatorKit
//
//  Created by eunseou on 6/6/24.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

final class ViewController: UIViewController, View {
    
    typealias Reactor = ViewReactor

    // MARK: - Components
    private let number = UILabel().then {
        $0.textAlignment = .center
        $0.text = "0"
        $0.font = .systemFont(ofSize: 17)
    }
    private let plusBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    private let minusBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "minus"), for: .normal)
    }
    
    // MARK: - Properties
    var disposeBag: DisposeBag = DisposeBag()
    
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        setupLayout()
        self.reactor = .init()
    }
    
    // MARK: - Functions
    func configureHierarchy() {
        
        view.addSubview(number)
        view.addSubview(plusBtn)
        view.addSubview(minusBtn)
    }
    
    func setupLayout() {
        
        number.snp.makeConstraints {
            $0.center.equalTo(view)
        }
        plusBtn.snp.makeConstraints {
            $0.centerY.equalTo(number.snp.centerY)
            $0.right.equalTo(number.snp.left).offset(-10)
        }
        minusBtn.snp.makeConstraints {
            $0.centerY.equalTo(number.snp.centerY)
            $0.left.equalTo(number.snp.right).offset(10)
        }
    }
    
    func bind(reactor: Reactor) {
        
        // + 에 대한 Action
        plusBtn.rx.tap
            .map { Reactor.Action.countUp }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - 에 대한 Action
        minusBtn.rx.tap
            .map { Reactor.Action.countDown }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { String($0.value) }
            .distinctUntilChanged()
            .bind(to: number.rx.text)
            .disposed(by: disposeBag)
    }

}

