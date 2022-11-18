//
//  DetailPizzeViewController.swift
//  PizzaAppTest
//
//  Created by Phincon on 18/11/22.
//

import UIKit
import SnapKit

class DetailPizzeViewController: UIViewController {
    
    lazy var detailImg: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var detailTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    lazy var detailPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var detailDesc: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    var pizza: PizzaMenu?{
        didSet {
            detailTitle.text = pizza?.nama
            detailDesc.text = pizza?.deskripsi
            detailPrice.text = "\(pizza?.harga ?? 0)".currencyFormatting()
            detailImg.image = UIImage(named: pizza?.gambar ?? "")
            title = pizza?.nama
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [detailImg, detailTitle, detailPrice, detailDesc].forEach { views in
            view.addSubview(views)
        }
        
        configureUI()
    }
    
    func configureUI(){
        detailImg.snp.remakeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        detailTitle.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(view).inset(20)
            make.top.equalTo(detailImg.snp.bottom).offset(20)
        }
        
        detailPrice.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(view).inset(20)
            make.top.equalTo(detailTitle.snp.bottom).offset(5)
        }
        
        detailDesc.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(view).inset(20)
            make.top.equalTo(detailPrice.snp.bottom).offset(5)
        }
    }
    
}
