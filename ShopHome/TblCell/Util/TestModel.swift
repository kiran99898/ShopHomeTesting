//
//  TestModel.swift
//  ShopHome
//
//  Created by kiran on 3/11/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import Foundation

/*

typealias ShopRootModel = [RootModelElement]

struct RootModelElement: Codable {
    let id: Int
    let storeName, firstName, lastName, email: String
    let social: SocialUnion
    let phone: Phone
    let showEmail: Bool
    let address: AddressUnion
    let location: Location
    let banner: Banner
    let gravatar, shopURL: String
    let productsPerPage: Int
    let showMoreProductTab, tocEnabled: Bool
    let storeToc: String
    let featured: Bool
    let rating: RatingClass
    let enabled: Bool
    let registered: String
    let payment: PaymentUnion
    let trusted: Bool
    let links: Links
    
    enum CodingKeys: String, CodingKey {
        case id
        case storeName = "store_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case email, social, phone
        case showEmail = "show_email"
        case address, location, banner, gravatar
        case shopURL = "shop_url"
        case productsPerPage = "products_per_page"
        case showMoreProductTab = "show_more_product_tab"
        case tocEnabled = "toc_enabled"
        case storeToc = "store_toc"
        case featured, rating, enabled, registered, payment, trusted
        case links = "_links"
    }
}

enum AddressUnion: Codable {
    case addressClass(AddressClass)
    case anythingArray([JSONAny])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONAny].self) {
            self = .anythingArray(x)
            return
        }
        if let x = try? container.decode(AddressClass.self) {
            self = .addressClass(x)
            return
        }
        throw DecodingError.typeMismatch(AddressUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AddressUnion"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .addressClass(let x):
            try container.encode(x)
        case .anythingArray(let x):
            try container.encode(x)
        }
    }
}

struct AddressClass: Codable {
    let street1: Street1
    let street2: Street2
    let city: City
    let zip: Zip
    let country: Country
    let state: State
    
    enum CodingKeys: String, CodingKey {
        case street1 = "street_1"
        case street2 = "street_2"
        case city, zip, country, state
    }
}

enum City: String, Codable {
    case empty = ""
    case rajbiraj = "Rajbiraj"
}

enum Country: String, Codable {
    case empty = ""
    case np = "NP"
}

enum State: String, Codable {
    case bag = "BAG"
    case empty = ""
}

enum Street1: String, Codable {
    case empty = ""
    case rajbiraj3SaptariNepal = "Rajbiraj - 3, Saptari, Nepal"
    case starMall = "Star Mall"
}

enum Street2: String, Codable {
    case empty = ""
    case sherpaMall = "Sherpa Mall"
}

enum Zip: String, Codable {
    case empty = ""
    case firstFloor = "First Floor"
    case secondFloor = "Second Floor"
}

enum Banner: Codable {
    case bool(Bool)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Banner.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Banner"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

struct Links: Codable {
    let linksSelf, collection: [Collection]
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case collection
    }
}

struct Collection: Codable {
    let href: String
}

enum Location: String, Codable {
    case empty = ""
    case location = ","
}

enum PaymentUnion: Codable {
    case anythingArray([JSONAny])
    case paymentClass(PaymentClass)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONAny].self) {
            self = .anythingArray(x)
            return
        }
        if let x = try? container.decode(PaymentClass.self) {
            self = .paymentClass(x)
            return
        }
        throw DecodingError.typeMismatch(PaymentUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PaymentUnion"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .anythingArray(let x):
            try container.encode(x)
        case .paymentClass(let x):
            try container.encode(x)
        }
    }
}

struct PaymentClass: Codable {
    let paypal: [Paypal]
    let bank: [JSONAny]
}

enum Paypal: String, Codable {
    case email = "email"
}

enum Phone: String, Codable {
    case empty = ""
    case the9847957908 = "9847957908"
    case the9851128919 = "9851128919"
}

struct RatingClass: Codable {
    let rating: RatingEnum
    let count: Int
}

enum RatingEnum: String, Codable {
    case noRatingsFoundYet = "No Ratings found yet"
}

enum SocialUnion: Codable {
    case anythingArray([JSONAny])
    case socialClass(SocialClass)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONAny].self) {
            self = .anythingArray(x)
            return
        }
        if let x = try? container.decode(SocialClass.self) {
            self = .socialClass(x)
            return
        }
        throw DecodingError.typeMismatch(SocialUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SocialUnion"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .anythingArray(let x):
            try container.encode(x)
        case .socialClass(let x):
            try container.encode(x)
        }
    }
}

struct SocialClass: Codable {
    let fb, gplus, twitter, pinterest: Fb
    let linkedin, youtube, instagram, flickr: Fb
}

enum Fb: Codable {
    case bool(Bool)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Fb.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Fb"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

*/
