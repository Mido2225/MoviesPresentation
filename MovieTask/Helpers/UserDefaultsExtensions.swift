//
//  UserDefaultsExtensions.swift
//  Teemah
//
//  Created by MGAboarab on 31/12/2021.
//

import Foundation

@propertyWrapper
struct ValueDefault<Value> {
    
    let key: String
    let defualtValue: Value
    let container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            return container.value(forKey: key) as? Value ?? defualtValue
        }
        set {
            container.setValue(newValue, forKey: key)
        }
    }
}

@propertyWrapper
struct ModelsDefault<Model: Codable> {
    
    let key: String
    let defualtValue: Model
    let container: UserDefaults = .standard
    
    var wrappedValue: Model {
        get {
            let decoder = JSONDecoder()
            guard let decoded = container.object(forKey: key) as? Data else {return defualtValue}
            let loadedValue = try? decoder.decode(Model.self, from: decoded)
            return loadedValue ?? defualtValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                container.set(encoded, forKey: key)
                container.synchronize()
            }
        }
    }
}

extension UserDefaults {
    private enum Keys {
        static let isLogin = "isLogin"
        static let accessToken = "accessToken"
        static let pushNotificationToken = "pushNotificationToken"
        static let isFirstTime = "isFirstTime"
    }
    
    @ValueDefault(key: Keys.isLogin, defualtValue: false)
    static var isLogin: Bool

    @ModelsDefault(key: Keys.accessToken, defualtValue: nil)
    static var accessToken: String?
    
    @ModelsDefault(key: Keys.pushNotificationToken, defualtValue: nil)
    static var pushNotificationToken: String?
    
    @ModelsDefault(key: Keys.isFirstTime, defualtValue: true)
    static var isFirstTime: Bool
    

}



