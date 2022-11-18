//
//  AppServerClient.swift
//  PizzaAppTest
//
//  Created by Phincon on 17/11/22.
//

import Foundation
import RxSwift

class AppServerClient {
    enum FailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }

    func getPizza() -> Observable<[PizzaMenu?]> {
        return Observable.create { observer -> Disposable in
            do {
                if let file = Bundle.main.url(forResource: "Pizza", withExtension: "json") {
                    let data = try Data(contentsOf: file)
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let object = json as? [String: Any] {
                        let pizza = PizzaModel(object)
                        observer.onNext(pizza.menu)
                    } else {
                        print("JSON is invalid")
                    }
                } else {
                    print("no file")
                }
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
