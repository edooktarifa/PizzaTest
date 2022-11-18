//
//  ViewController.swift
//  PizzaAppTest
//
//  Created by Phincon on 17/11/22.
//

import UIKit
import SnapKit
import RxSwift

class PizzaViewController: UIViewController{
    
    let viewModel = PizzaViewModel()
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(cell: PizzaCell.self)
        return table
    }()
    
    let disposeBag = DisposeBag()
    var router: Router?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Food"
        configTable()
        router = Router(view: self)
    }
    
    func configTable(){
        view.addSubview(tableView)
        
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getPizza()
        
        viewModel.pizza.drive(onNext: {
            [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.error.drive(onNext: {
            [weak self] error in
            guard let self = self, let error = error else { return }
            self.router?.showAlert(message: error)
        }).disposed(by: disposeBag)
    }
}

extension PizzaViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cell: PizzaCell.self)
        if let pizzaData = viewModel.pizzaData[indexPath.row] {
            cell.setContent(data: pizzaData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !viewModel.pizzaData.isEmpty {
           showDataDidSelect(data: viewModel.pizzaData[indexPath.row]!)
        }
    }
    
    func showDataDidSelect(data: PizzaMenu){
        self.router?.moveToDetail(pizza: data)
    }
}

