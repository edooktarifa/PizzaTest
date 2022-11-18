//
//  PizzaAppTestTests.swift
//  PizzaAppTestTests
//
//  Created by Phincon on 17/11/22.
//

import XCTest
import RxSwift
@testable import PizzaAppTest

class PizzaAppTestTests: XCTestCase {
    
    var controller: PizzaViewController?
    var viewModel: PizzaViewModel?
    let disposeBag = DisposeBag()
    var router: Router?
    
    override func setUp() {
        controller = PizzaViewController()
        controller?.tableView.register(cell: PizzaCell.self)
        router = Router(view: controller!)
    }
    
    override func tearDown() {
        controller = nil
        viewModel = nil
        router = nil
    }
    
    func testRecycle() {
        XCTAssert(((controller?.viewWillAppear(true)) != nil))
        XCTAssert(((controller?.viewDidAppear(true)) != nil))
        XCTAssert(((controller?.viewDidDisappear(true)) != nil))
        XCTAssert(((controller?.viewWillDisappear(true)) != nil))
        XCTAssert(((controller?.viewDidLayoutSubviews()) != nil))
    }
    
    func test_numberOfRow(){
        let appServerClient = MockAppServerClient()
        
        appServerClient.getPizzaResult = .success([])
        
        viewModel = PizzaViewModel(appServerClient: appServerClient)
        viewModel?.getPizza()
        
        XCTAssertNotNil(viewModel?.numberOfRowInSection)
    }
    
    func test_numberOfRow_nil(){
        let appServerClient = MockAppServerClient()
        
        appServerClient.getPizzaResult = .failure(AppServerClient.FailureReason.notFound)
        
        viewModel = PizzaViewModel(appServerClient: appServerClient)
        viewModel?.getPizza()
        
        XCTAssertEqual(0, viewModel?.numberOfRowInSection)
    }
    
    func test_empty_pizza(){
        let appServerClient = MockAppServerClient()
        
        appServerClient.getPizzaResult = .failure(AppServerClient.FailureReason.notFound)
        
        viewModel = PizzaViewModel(appServerClient: appServerClient)
        viewModel?.getPizza()
        
        let expectEmptyPizza = expectation(description: "Pizza api failed and show error")
        
        viewModel?.error.drive(onNext: {
            error in
            
            if (error != nil) {
                expectEmptyPizza.fulfill()
            }
            
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_not_empty_pizza(){
        let appServerClient = MockAppServerClient()
        
        appServerClient.getPizzaResult = .success([])
        
        viewModel = PizzaViewModel(appServerClient: appServerClient)
        viewModel?.getPizza()
        
        let expectNotEmptyPizza = expectation(description: "Pizza api not failed and show data")
        
        viewModel?.error.drive(onNext: {
            error in
            
            if (error == nil) {
                expectNotEmptyPizza.fulfill()
            }
            
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    
    func test_router_detail(){
        router?.moveToDetail(pizza: PizzaMenu(["kategori": "nasi",
                                               "nama": "Meatballs Beef Mushroom",
                                               "deskripsi": "Bola daging sapi dengan saus daging sapi cincang dan jamur.",
                                               "harga": 40000,
                                               "gambar": "meatballs-beef-mushroom"]))
    }
    
    func test_show_alert(){
        router?.showAlert(message: "error")
    }
    
    func test_did_select_a_cell() {
        
        let appServerClient = MockAppServerClient()
        appServerClient.getPizzaResult = .success([])
        
        let didSelect = [PizzaMenu(["kategori": "nasi",
                                    "nama": "Meatballs Beef Mushroom",
                                    "deskripsi": "Bola daging sapi dengan saus daging sapi cincang dan jamur.",
                                    "harga": 40000,
                                    "gambar": "meatballs-beef-mushroom"])]
        
        
        viewModel?._pizza.accept(didSelect)
        viewModel = PizzaViewModel(appServerClient: appServerClient)
        viewModel?.getPizza()
        
        // when
        if let tableView = controller?.tableView, let index = viewModel?.pizzaData.startIndex {
            controller?.tableView(tableView , didSelectRowAt: IndexPath(row: index, section: 0))
        }
        
        // then
        XCTAssertNotNil(controller?.tableView)
    }
    
    func test_show_did_select() {
        let selected: ()? = controller?.showDataDidSelect(data: PizzaMenu(["kategori": "nasi",
                                                       "nama": "Meatballs Beef Mushroom",
                                                       "deskripsi": "Bola daging sapi dengan saus daging sapi cincang dan jamur.",
                                                       "harga": 40000,
                                                       "gambar": "meatballs-beef-mushroom"]))
        XCTAssertNotNil(selected)
    }
}
