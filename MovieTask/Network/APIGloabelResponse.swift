//
//  APIGloabelResponse.swift
//  Taskon
//
//  Created by MGAboarab on 02/02/2022.
//

import Foundation

class APIGloabelResponse: Codable {
    var key: String
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case key
        case message = "msg"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decode(String.self, forKey: .key)
        message = try values.decode(String.self, forKey: .message)
    }
    
}

class APIGenericResponse<T: Codable>: APIGloabelResponse {
    
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case data
        case key
        case message = "msg"
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decode(String.self, forKey: .key)
        message = try values.decode(String.self, forKey: .message)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }
    
}

struct Paginate: Codable {
    let currentPage: Int
    let lastPage: Int
    let perPage: Int
    let total: Int
}
