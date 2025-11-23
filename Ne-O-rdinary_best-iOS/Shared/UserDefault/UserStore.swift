//
//  UserStore.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation
import UIKit

private enum UserStoreKey: String {
    case refreshToken = "USER_REFRESH_TOKEN_KEY"
    case accessToken = "USER_ACCESS_TOKEN_KEY"
    case isLogIn = "IS_LOG_IN"
}

public enum UserStore {
    @Bucket(key: UserStoreKey.refreshToken)
    static var refreshToken: String?

    @Bucket(key: UserStoreKey.accessToken)
    static var accessToken: String?
    
    @Bucket(key: UserStoreKey.isLogIn)
    static var isLogIn: Bool?
    
    static func saveTokens(accessToken: String, refreshToken: String) {
        UserStore.accessToken = accessToken
        UserStore.refreshToken = refreshToken
    }
    
    static func getAccessToken() -> String? {
        return UserStore.accessToken
    }
    
    static func getRefreshToken() -> String? {
        return UserStore.refreshToken
    }
    
    static func setLogIn(_ result: Bool){
        UserStore.isLogIn = result
    }
    
    static func getLogIn() -> Bool? {
        return UserStore.isLogIn
    }
}
private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

protocol BucketKey: ExpressibleByStringLiteral {}

@propertyWrapper
struct Bucket<Value> {
    
    var wrappedValue: Value {
        get {
            let value = UserDefaults.standard.object(forKey: self.key) as? Value
            return value ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                UserDefaults.standard.removeObject(forKey: self.key)
            } else {
                UserDefaults.standard.setValue(newValue, forKey: self.key)
            }
        }
    }
    private let key: String
    private let defaultValue: Value
    
    init(wrappedValue defaultValue: Value, key: String) {
        self.defaultValue = defaultValue
        self.key = key
    }
}

private extension Bucket {
    init(wrappedValue defaultValue: Value, key: UserStoreKey) {
        self.init(wrappedValue: defaultValue, key: key.rawValue)
    }
}

private extension Bucket where Value: ExpressibleByNilLiteral {
    init(key: UserStoreKey) {
        self.init(wrappedValue: nil, key: key.rawValue)
    }
}
