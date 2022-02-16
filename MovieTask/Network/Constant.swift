//
//  Constant.swift
//  Taskon
//
//  Created by MGAboarab on 02/02/2022.
//

import Foundation

//MARK: - Request Enums -
enum ServerKeys: String {
    case baseURL = "https://tskn-app.aait-sa.com/api/"
}
enum APIParameterKey: String {
    case name
    case phone
    case password
    case code
    case email
    case commercial
    case lat
    case lng
    case address
    case userType = "user_type"
    case advertiserNumber = "advertiser_number"
    case cityId = "city_id"
    case estateTypeId = "estate_type_id"
    case housingTypeId = "housing_type_id"
    case numberRoles = "number_roles"
    case propertyId = "property_id"
    case unitId = "unit_id"
    case tenantName = "tenant_name"
    case contractNumber = "contract_number"
    case selectedDate = "selected_date"
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
