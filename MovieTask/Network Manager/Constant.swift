//
//  Constant.swift
//  Taskon
//
//  Created by MGAboarab on 02/02/2022.
//

import Foundation

//MARK: - Request Enums -
enum ServerKeys: String {
    case baseURL = "https://api.themoviedb.org/"
}
enum APIParameterKey: String {
    case apiKey = "api_key"
    case movieId = "movie-id"
    case query = "query"
    case deviceId = "device_id"
    case deviceType = "device_type"
    case macAddress = "mac_address"
}
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case lang = "lang"
}
enum ContentType: String {
    case json = "application/json"
    case deviceType = "ios"
    case tokenBearer = "Bearer "
}

//MARK: - Response Enums -
enum ResponseKeys: String {
    case success
    case fail
    case needAdminActivation
    case waitingApprove
    case needActive
}

//MARK: - Errors -
enum APIErrors: String {
    case connectionError
    case canNotDecodeData
}
