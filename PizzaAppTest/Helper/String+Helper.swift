//
//  String+Helper.swift
//  PizzaAppTest
//
//  Created by Phincon on 18/11/22.
//

import Foundation

extension String {
    func currencyFormatting(noNeedWhiteSpace: Bool = false) -> String {
        if let value = Double(self.removeCharacters(charSet: .whitespaces)) {
            let formatter = NumberFormatter()
            formatter.currencySymbol = "Rp"
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 0
            if let str = formatter.string(for: value) {
               return noNeedWhiteSpace == true ? "Rp\(str)" : "Rp \(str)"
            }
        }
        return ""
    }
    
    func removeCharacters(charSet: CharacterSet) -> String { return removeCharacters(charSets: [charSet]) }

    func removeCharacters(charSets: [CharacterSet]) -> String { return filterCharacters(definedIn: charSets) { !$0.contains($1) } }
    
    private func filterCharacters(definedIn charSets: [CharacterSet], unicodeScalarsFilter: (CharacterSet, UnicodeScalar) -> Bool) -> String {
        if charSets.isEmpty { return self }
        let charSet = charSets.reduce(CharacterSet()) { return $0.union($1) }
        return filterCharacters { unicodeScalarsFilter(charSet, $0) }
    }
    
    private func filterCharacters(unicodeScalarsFilter closure: (UnicodeScalar) -> Bool) -> String {
        return String(String.UnicodeScalarView(unicodeScalars.filter { closure($0) }))
    }
}
