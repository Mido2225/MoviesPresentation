//
//  Downloader.swift
//  Taskon
//
//  Created by MGAboarab on 02/02/2022.
//

import Foundation

class Downloader {
    class func load(stringURL: String, completion: @escaping (Data) -> ()) {
        guard let url = URL(string: stringURL) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(data)
                return
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

