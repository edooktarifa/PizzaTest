//
//  PizzaModel.swift
//  PizzaAppTest
//
//  Created by Phincon on 17/11/22.
//

import Foundation

struct PizzaModel: Codable {
    var menu: [PizzaMenu] = []
    
    init(_ from: [String:Any]) {
        let menu = from["menu"] as? [[String: Any]] ?? [["":""]]
        for i in menu {
            self.menu.append(PizzaMenu(i))
        }
    }
}

// MARK: - Menu
struct PizzaMenu: Codable {
    let kategori, nama, deskripsi, gambar: String
    let harga: Int
    
    init(_ from: [String:Any]) {
        self.kategori = from["kategori"] as? String ?? ""
        self.nama = from["nama"] as? String ?? ""
        self.deskripsi = from["deskripsi"] as? String ?? "-"
        self.gambar = from["gambar"] as? String ?? ""
        self.harga = from["harga"] as? Int ?? 0
    }
}
