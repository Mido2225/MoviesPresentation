//
//  Array.swift
//  Helper
//
//  Created by Mohammed Abouarab on 29/11/2021.
//

import Foundation

extension Array where Element: Encodable {
    func toString() -> String {
        do {
            let encodedData = try JSONEncoder().encode(self)
            let stringModel = String(data: encodedData, encoding: .utf8)
            return stringModel ?? "[]"
        } catch {
            return "[]"
        }
    }
}
