//
//  Para.swift
//  ShopHome
//
//  Created by kiran on 3/23/19.
//  Copyright © 2019 kiran. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let datatoEncode = try? newJSONDecoder().decode(DatatoEncode.self, from: jsonData)

import Foundation

class DatatoEncode: Codable {
    let billing, shipping: DtIng
    let paymentMethod, paymentMethodTitle, transactionID: String
    let datePaid, datePaidGmt, dateCompleted, dateCompletedGmt: DtJSONNull?
    let lineItems: [DtLineItem]
    let taxLines: [DtJSONAny]
    let shippingLines: [DtShippingLine]
    let feeLines: [DtFeeLine]
    
    enum CodingKeys: String, CodingKey {
        case billing, shipping
        case paymentMethod = "payment_method"
        case paymentMethodTitle = "payment_method_title"
        case transactionID = "transaction_id"
        case datePaid = "date_paid"
        case datePaidGmt = "date_paid_gmt"
        case dateCompleted = "date_completed"
        case dateCompletedGmt = "date_completed_gmt"
        case lineItems = "line_items"
        case taxLines = "tax_lines"
        case shippingLines = "shipping_lines"
        case feeLines = "fee_lines"
    }
    
    init(billing: DtIng, shipping: DtIng, paymentMethod: String, paymentMethodTitle: String, transactionID: String, datePaid: DtJSONNull?, datePaidGmt: DtJSONNull?, dateCompleted: DtJSONNull?, dateCompletedGmt: DtJSONNull?, lineItems: [DtLineItem], taxLines: [DtJSONAny], shippingLines: [DtShippingLine], feeLines: [DtFeeLine]) {
        self.billing = billing
        self.shipping = shipping
        self.paymentMethod = paymentMethod
        self.paymentMethodTitle = paymentMethodTitle
        self.transactionID = transactionID
        self.datePaid = datePaid
        self.datePaidGmt = datePaidGmt
        self.dateCompleted = dateCompleted
        self.dateCompletedGmt = dateCompletedGmt
        self.lineItems = lineItems
        self.taxLines = taxLines
        self.shippingLines = shippingLines
        self.feeLines = feeLines
    }
}

class DtIng: Codable {
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
    
    init(firstName: String, lastName: String, company: String, address1: String, address2: String, city: String, state: String, postcode: String, country: String, email: String?, phone: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.state = state
        self.postcode = postcode
        self.country = country
        self.email = email
        self.phone = phone
    }
}

class DtFeeLine: Codable {
    let name, taxClass, taxStatus, amount: String
    let total, totalTax: String
    let taxes, metaData: [DtJSONAny]
    
    enum CodingKeys: String, CodingKey {
        case name
        case taxClass = "tax_class"
        case taxStatus = "tax_status"
        case amount, total
        case totalTax = "total_tax"
        case taxes
        case metaData = "meta_data"
    }
    
    init(name: String, taxClass: String, taxStatus: String, amount: String, total: String, totalTax: String, taxes: [DtJSONAny], metaData: [DtJSONAny]) {
        self.name = name
        self.taxClass = taxClass
        self.taxStatus = taxStatus
        self.amount = amount
        self.total = total
        self.totalTax = totalTax
        self.taxes = taxes
        self.metaData = metaData
    }
}

class DtLineItem: Codable {
    let name: String
    let productID, variationID, quantity: Int
    let taxClass, subtotal, subtotalTax, total: String
    let totalTax: String
    let taxes: [DtJSONAny]
    let metaData: [DtMetaDatum]
    let sku: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case name
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
    
    init(name: String, productID: Int, variationID: Int, quantity: Int, taxClass: String, subtotal: String, subtotalTax: String, total: String, totalTax: String, taxes: [DtJSONAny], metaData: [DtMetaDatum], sku: String, price: Int) {
        self.name = name
        self.productID = productID
        self.variationID = variationID
        self.quantity = quantity
        self.taxClass = taxClass
        self.subtotal = subtotal
        self.subtotalTax = subtotalTax
        self.total = total
        self.totalTax = totalTax
        self.taxes = taxes
        self.metaData = metaData
        self.sku = sku
        self.price = price
    }
}

class DtMetaDatum: Codable {
    let id: Int
    let key, value: String
    
    init(id: Int, key: String, value: String) {
        self.id = id
        self.key = key
        self.value = value
    }
}

class DtShippingLine: Codable {
    let methodTitle, methodID, instanceID, total: String
    let totalTax: String
    let taxes: [DtJSONAny]
    let metaData: [DtMetaDatum]
    
    enum CodingKeys: String, CodingKey {
        case methodTitle = "method_title"
        case methodID = "method_id"
        case instanceID = "instance_id"
        case total
        case totalTax = "total_tax"
        case taxes
        case metaData = "meta_data"
    }
    
    init(methodTitle: String, methodID: String, instanceID: String, total: String, totalTax: String, taxes: [DtJSONAny], metaData: [DtMetaDatum]) {
        self.methodTitle = methodTitle
        self.methodID = methodID
        self.instanceID = instanceID
        self.total = total
        self.totalTax = totalTax
        self.taxes = taxes
        self.metaData = metaData
    }
}

// MARK: Encode/decode helpers

class DtJSONNull: Codable, Hashable {
    
    public static func == (lhs: DtJSONNull, rhs: DtJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(DtJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DtJSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class DtJJSONCodingKey: CodingKey {
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

class DtJSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode DtJSONAny")
        return DecodingError.typeMismatch(DtJSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode DtJSONAny")
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
            return DtJSONNull()
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
                return DtJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: DtJJSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<DtJJSONCodingKey>, forKey key: DtJJSONCodingKey) throws -> Any {
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
                return DtJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: DtJJSONCodingKey.self, forKey: key) {
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
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<DtJJSONCodingKey>) throws -> [String: Any] {
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
            } else if value is DtJSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: DtJJSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<DtJJSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = DtJJSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is DtJSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: DtJJSONCodingKey.self, forKey: key)
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
        } else if value is DtJSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try DtJSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: DtJJSONCodingKey.self) {
            self.value = try DtJSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try DtJSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try DtJSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: DtJJSONCodingKey.self)
            try DtJSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try DtJSONAny.encode(to: &container, value: self.value)
        }
    }
}
