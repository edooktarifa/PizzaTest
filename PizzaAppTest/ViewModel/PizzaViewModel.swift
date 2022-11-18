//
//  PizzaViewModel.swift
//  PizzaAppTest
//
//  Created by Phincon on 17/11/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol PizzaProtocol {
    var numberOfRowInSection: Int { get }
    var pizza: Driver<[PizzaMenu?]> { get }
    var error: Driver<String?> { get }
}

class PizzaViewModel: PizzaProtocol  {
    
    let _pizza = BehaviorRelay<[PizzaMenu?]>(value: [])
    private let _error = BehaviorRelay<String?>(value: nil)
    
    var pizza: Driver<[PizzaMenu?]>{
        return _pizza.asDriver()
    }
    
    var error: Driver<String?>{
        return _error.asDriver()
    }
    
    private let appServerClient: AppServerClient
    let dispobag = DisposeBag()
    
    var numberOfRowInSection: Int { _pizza.value.count }
    
    var pizzaData: [PizzaMenu?] {
        _pizza.value
    }
    
    private var pizzaList = [PizzaMenu]()
    
    init(appServerClient: AppServerClient = AppServerClient()){
        self.appServerClient = appServerClient
    }
    
    func getPizza() {
        appServerClient.getPizza().subscribe(onNext: {
            [weak self] pizza in
            guard let self = self else { return }
            
            self._pizza.accept(pizza)
            
        }, onError: {
            [weak self] error in
            guard let self = self else { return }
            
            self._error.accept(error.localizedDescription)
        }).disposed(by: dispobag)
    }
}
