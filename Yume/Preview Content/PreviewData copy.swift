//
//  PreviewData.swift
//  Rawg
//
//  Created by Bryan on 21/10/22.
//

import Foundation

class PreviewData {
    static func load<T: Decodable>(_ file: String) -> T {
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: URL(filePath: path)) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let result = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return result as T
    }
}
