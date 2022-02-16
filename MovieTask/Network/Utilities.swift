//
//  Utilities.swift
//  Taskon
//
//  Created by MGAboarab on 02/02/2022.
//

import UIKit

let deviceId = UserDefaults.pushNotificationToken ?? "no device id for firebase for this device and this is an ios device"
let uuid = UIDevice.current.identifierForVendor?.uuidString ?? String()

func printApiResponse(_ responseData: Data?) {
    guard let responseData = responseData else {
        print("\n\n====================================\n⚡️⚡️RESPONSE IS::\n" ,responseData as Any, "\n====================================\n\n")
        return
    }
    
    if let object = try? JSONSerialization.jsonObject(with: responseData, options: []),
       let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys]), let JSONString = String(data: data, encoding: String.Encoding.utf8) {
        print("\n\n====================================\n⚡️⚡️RESPONSE IS::\n" ,JSONString, "\n====================================\n\n")
        return
    }
    print("\n\n====================================\n⚡️⚡️RESPONSE IS::\n" ,responseData, "\n====================================\n\n")
}


