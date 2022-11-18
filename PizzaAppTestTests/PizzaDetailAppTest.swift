//
//  PizzaDetailAppTest.swift
//  PizzaAppTestTests
//
//  Created by Phincon on 18/11/22.
//

import XCTest
@testable import PizzaAppTest

class PizzaDetailAppTest: XCTestCase {
    
    var controller: DetailPizzeViewController?
    
    override func setUp() {
        controller = DetailPizzeViewController()
    }
    
    override func tearDown() {
        controller = nil
    }
    
    func testImageNil(){
        XCTAssertNil(controller?.pizza?.gambar.isEmpty)
    }
    
    func test_title_nil(){
        XCTAssertNil(controller?.pizza?.nama.isEmpty)
    }
    
    func test_deskripsi_nil(){
        XCTAssertNil(controller?.pizza?.deskripsi.isEmpty)
    }
    
    func test_price_nil(){
        XCTAssertNil(controller?.pizza?.harga)
    }
    
    func test_configure_ui(){
        controller?.configureUI()
    }
    
}
