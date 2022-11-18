//
//  PizzaCell.swift
//  PizzaAppTest
//
//  Created by Phincon on 18/11/22.
//

import UIKit
import SnapKit

class PizzaCell: UITableViewCell, ReusableViewCell {

    var titlePizza: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    var descriptionPizza: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        return label
    }()
    
    var pricePizza: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    var pizzaImg: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configureUI(){
        [titlePizza, pizzaImg, descriptionPizza, pricePizza].forEach { views in
            self.contentView.addSubview(views)
        }
        
        pizzaImg.snp.remakeConstraints { make in
            make.leading.equalTo(16)
            make.height.width.equalTo(90)
        }
        
        titlePizza.snp.remakeConstraints { make in
            make.leading.equalTo(pizzaImg.snp.trailing).offset(10)
            make.trailing.equalTo(-10)
            make.top.equalTo(pizzaImg.snp.top).offset(5)
        }
        
        descriptionPizza.snp.remakeConstraints { make in
            make.trailing.leading.equalTo(titlePizza)
            make.top.equalTo(titlePizza.snp.bottom).offset(5)
        }
        
        pricePizza.snp.remakeConstraints { make in
            make.trailing.leading.equalTo(titlePizza)
            make.top.equalTo(descriptionPizza.snp.bottom).offset(5)
        }
    }
    
    func setContent(data: PizzaMenu){
        titlePizza.text = data.nama
        descriptionPizza.text = data.deskripsi
        pizzaImg.image = UIImage(named: data.gambar)
        pricePizza.text = "\(data.harga)".currencyFormatting()
    }
}

