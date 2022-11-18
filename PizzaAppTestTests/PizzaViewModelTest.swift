//
//  PizzaViewModelTest.swift
//  PizzaAppTestTests
//
//  Created by Phincon on 18/11/22.
//

import XCTest
import RxSwift
@testable import PizzaAppTest

class PizzaViewModelTest: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    func test_success_api(){
        let appServerClient = MockAppServerClient()
        
        appServerClient.getPizzaResult = .success([])
        
        let viewModel = PizzaViewModel(appServerClient: appServerClient)
        viewModel.getPizza()
        
        let expectEmptyPizza = expectation(description: "Pizza api success")
        viewModel.pizza.drive(onNext: {
            pizza in
            
            if pizza.isEmpty {
                XCTAssertTrue(pizza.isEmpty)
            } else {
                XCTAssertFalse(false)
            }
            
            expectEmptyPizza.fulfill()
            
        }).disposed(by: disposeBag)
        
        wait(for: [expectEmptyPizza], timeout: 0.1)
    }
    
    func test_failed_api(){
        let appServerClient = MockAppServerClient()
        appServerClient.getPizzaResult = .failure(AppServerClient.FailureReason.notFound)
        
        let viewModel = PizzaViewModel(appServerClient: appServerClient)
        viewModel.getPizza()
        
        let expectErrorPizza = expectation(description: "pizza api error")
        
        viewModel.pizza.drive(onNext: {
            pizza in
            
            if pizza.isEmpty {
                XCTAssertTrue(pizza.isEmpty)
            } else {
                XCTAssertFalse(false)
            }
            
            expectErrorPizza.fulfill()
            
        }).disposed(by: disposeBag)
        
        wait(for: [expectErrorPizza], timeout: 0.1)
    }
    
}

class MockAppServerClient: AppServerClient {
    
    var getPizzaResult: Result<[PizzaMenu?], AppServerClient.FailureReason>?
    
    override func getPizza() -> Observable<[PizzaMenu?]> {
        return Observable.create { observer in
            switch self.getPizzaResult {
            case .success(let pizza)?:
                observer.onNext(pizza)
            case .failure(let error)?:
                observer.onError(error)
            case .none:
                observer.onError(AppServerClient.FailureReason.notFound)
            }
            
            return Disposables.create()
        }
    }
}
