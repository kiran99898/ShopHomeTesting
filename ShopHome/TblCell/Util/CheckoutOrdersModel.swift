//
//  CheckoutOrdersModel.swift
//  ShopHome
//
//  Created by kiran on 3/22/19.
//  Copyright © 2019 kiran. All rights reserved.
//
import Foundation

struct CheckoutOrdersModel: Codable {
    let id, parentID: Int
    let number, orderKey, createdVia, version: String
    let status, currency, dateCreated, dateCreatedGmt: String
    let dateModified, dateModifiedGmt, discountTotal, discountTax: String
    let shippingTotal, shippingTax, cartTax, total: String
    let totalTax: String
    let pricesIncludeTax: Bool
    let customerID: Int
    let customerIPAddress, customerUserAgent, customerNote: String
    let billing, shipping: Ing
    let paymentMethod, paymentMethodTitle, transactionID: String
    let datePaid, datePaidGmt, dateCompleted, dateCompletedGmt: OrdJJSONNull?
    let cartHash: String
    let metaData: [OrdeJSONAny]
    let lineItems: [OrdLineItem]
    let taxLines: [OrdeJSONAny]
    let shippingLines: [ShippingLine]
    let feeLines: [OrderFeeLine]
    let couponLines, refunds: [OrdeJSONAny]
    let store: OrdeStore
    let links: OrdLinks
    
    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parent_id"
        case number
        case orderKey = "order_key"
        case createdVia = "created_via"
        case version, status, currency
        case dateCreated = "date_created"
        case dateCreatedGmt = "date_created_gmt"
        case dateModified = "date_modified"
        case dateModifiedGmt = "date_modified_gmt"
        case discountTotal = "discount_total"
        case discountTax = "discount_tax"
        case shippingTotal = "shipping_total"
        case shippingTax = "shipping_tax"
        case cartTax = "cart_tax"
        case total
        case totalTax = "total_tax"
        case pricesIncludeTax = "prices_include_tax"
        case customerID = "customer_id"
        case customerIPAddress = "customer_ip_address"
        case customerUserAgent = "customer_user_agent"
        case customerNote = "customer_note"
        case billing, shipping
        case paymentMethod = "payment_method"
        case paymentMethodTitle = "payment_method_title"
        case transactionID = "transaction_id"
        case datePaid = "date_paid"
        case datePaidGmt = "date_paid_gmt"
        case dateCompleted = "date_completed"
        case dateCompletedGmt = "date_completed_gmt"
        case cartHash = "cart_hash"
        case metaData = "meta_data"
        case lineItems = "line_items"
        case taxLines = "tax_lines"
        case shippingLines = "shipping_lines"
        case feeLines = "fee_lines"
        case couponLines = "coupon_lines"
        case refunds, store
        case links = "_links"
    }
}

struct Ing: Codable {
    let firstName, lastName, company, address1: String
    let address2, city, state, postcode: String
    let country: String
    let email, phone: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case company
        case address1 = "address_1"
        case address2 = "address_2"
        case city, state, postcode, country, email, phone
    }
}

struct OrderFeeLine: Codable {
    let id: Int
    let name, taxClass, taxStatus, amount: String
    let total, totalTax: String
    let taxes, metaData: [OrdeJSONAny]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case taxClass = "tax_class"
        case taxStatus = "tax_status"
        case amount, total
        case totalTax = "total_tax"
        case taxes
        case metaData = "meta_data"
    }
}

struct OrdLineItem: Codable {
    let id: Int
    let name: String
    let productID, variationID, quantity: Int
    let taxClass, subtotal, subtotalTax, total: String
    let totalTax: String
    let taxes: [OrdeJSONAny]
    let metaData: [OrdewMetaDatum]
    let sku: OrdJJSONNull?
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case productID = "product_id"
        case variationID = "variation_id"
        case quantity
        case taxClass = "tax_class"
        case subtotal
        case subtotalTax = "subtotal_tax"
        case total
        case totalTax = "total_tax"
        case taxes
        case metaData = "meta_data"
        case sku, price
    }
}

struct OrdewMetaDatum: Codable {
    let id: Int
    let key, value: String
}

struct OrdLinks: Codable {
    let linksSelf, collection: [OrdewrCollection]
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case collection
    }
}

struct OrdewrCollection: Codable {
    let href: String
}

struct ShippingLine: Codable {
    let id: Int
    let methodTitle, methodID, instanceID, total: String
    let totalTax: String
    let taxes: [OrdeJSONAny]
    let metaData: [OrdewMetaDatum]
    
    enum CodingKeys: String, CodingKey {
        case id
        case methodTitle = "method_title"
        case methodID = "method_id"
        case instanceID = "instance_id"
        case total
        case totalTax = "total_tax"
        case taxes
        case metaData = "meta_data"
    }
}

struct OrdeStore: Codable {
    let id: Int
    let name: OrdJJSONNull?
    let shopName, url: String
    let address: [OrdeJSONAny]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case shopName = "shop_name"
        case url, address
    }
}

// MARK: Encode/decode helpers

class OrdJJSONNull: Codable, Hashable {
    
    public static func == (lhs: OrdJJSONNull, rhs: OrdJJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(OrdJJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for OrdJJSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class OrdJSONCodingKey: CodingKey {
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

class OrdeJSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode OrdeJSONAny")
        return DecodingError.typeMismatch(OrdeJSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode OrdeJSONAny")
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
            return OrdJJSONNull()
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
                return OrdJJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: OrdJSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<OrdJSONCodingKey>, forKey key: OrdJSONCodingKey) throws -> Any {
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
                return OrdJJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: OrdJSONCodingKey.self, forKey: key) {
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
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<OrdJSONCodingKey>) throws -> [String: Any] {
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
            } else if value is OrdJJSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: OrdJSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<OrdJSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = OrdJSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is OrdJJSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: OrdJSONCodingKey.self, forKey: key)
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
        } else if value is OrdJJSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try OrdeJSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: OrdJSONCodingKey.self) {
            self.value = try OrdeJSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try OrdeJSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try OrdeJSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: OrdJSONCodingKey.self)
            try OrdeJSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try OrdeJSONAny.encode(to: &container, value: self.value)
        }
    }
}
