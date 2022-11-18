//
//  Router.swift
//  PizzaAppTest
//
//  Created by Phincon on 18/11/22.
//

import Foundation
import UIKit

class Router {
    
    var view: UIViewController?
    
    init(view: UIViewController){
        self.view = view
    }
    
    func moveToDetail(pizza: PizzaMenu){
        let vc = DetailPizzeViewController()
        vc.pizza = pizza
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.view?.present(alert, animated: true)
    }
}
