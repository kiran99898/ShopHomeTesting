//
//  ShopProductsRootModel.swift
//  ShopHome
//
//  Created by kiran on 3/11/19.
//  Copyright © 2019 kiran. All rights reserved.
//


import Foundation

typealias ShopProductsRootModel = [ShopProductsRootModelElement]

struct ShopProductsRootModelElement: Codable {
    let id: Int
    let name, slug, postAuthor: String
    let permalink: String
    let dateCreated, dateCreatedGmt, dateModified, dateModifiedGmt: String
    let type: TypeEnum
    let status: Status
    let featured: Bool
    let catalogVisibility: CatalogVisibility
    let description, shortDescription, sku, price: String
    let regularPrice, salePrice: String
    let dateOnSaleFrom, dateOnSaleFromGmt, dateOnSaleTo, dateOnSaleToGmt: String?
    let priceHTML: String
    let onSale, purchasable: Bool
    let totalSales: Int
    let virtual, downloadable: Bool
    let downloadLimit, downloadExpiry: Int
    let externalURL, buttonText: String
    let taxStatus: TaxStatus
    let taxClass: String
    let manageStock: Bool
    let stockQuantity: Int?
    let lowStockAmount: LowStockAmount
    let inStock: Bool
    let backorders: Backorders
    let backordersAllowed, backordered, soldIndividually: Bool
    let weight: String
    let dimensions: Dimensions
    let shippingRequired, shippingTaxable: Bool
    let shippingClass: String
    let shippingClassID: Int
    let reviewsAllowed: Bool
    let averageRating: String
    let ratingCount: Int
    let relatedIDS: [Int]
    let parentID: Int
    let purchaseNote: String
    let categories, tags: [Category]
    let images: [Image]
    let attributes: [Attribute]
    
    let menuOrder: Int
    let metaData: [MetaDatum]
    let store: Store
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case postAuthor = "post_author"
        case permalink
        case dateCreated = "date_created"
        case dateCreatedGmt = "date_created_gmt"
        case dateModified = "date_modified"
        case dateModifiedGmt = "date_modified_gmt"
        case type, status, featured
        case catalogVisibility = "catalog_visibility"
        case description
        case shortDescription = "short_description"
        case sku, price
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
        case dateOnSaleFrom = "date_on_sale_from"
        case dateOnSaleFromGmt = "date_on_sale_from_gmt"
        case dateOnSaleTo = "date_on_sale_to"
        case dateOnSaleToGmt = "date_on_sale_to_gmt"
        case priceHTML = "price_html"
        case onSale = "on_sale"
        case purchasable
        case totalSales = "total_sales"
        case virtual, downloadable
        case downloadLimit = "download_limit"
        case downloadExpiry = "download_expiry"
        case externalURL = "external_url"
        case buttonText = "button_text"
        case taxStatus = "tax_status"
        case taxClass = "tax_class"
        case manageStock = "manage_stock"
        case stockQuantity = "stock_quantity"
        case lowStockAmount = "low_stock_amount"
        case inStock = "in_stock"
        case backorders
        case backordersAllowed = "backorders_allowed"
        case backordered
        case soldIndividually = "sold_individually"
        case weight, dimensions
        case shippingRequired = "shipping_required"
        case shippingTaxable = "shipping_taxable"
        case shippingClass = "shipping_class"
        case shippingClassID = "shipping_class_id"
        case reviewsAllowed = "reviews_allowed"
        case averageRating = "average_rating"
        case ratingCount = "rating_count"
        case relatedIDS = "related_ids"
        case parentID = "parent_id"
        case purchaseNote = "purchase_note"
        case categories, tags, images, attributes

        case menuOrder = "menu_order"
        case metaData = "meta_data"
        case store
        
    }
}

struct Attribute: Codable {
    let id: Int
    let name: AttributeName
    let position: Int
    let visible, variation: Bool
    let options: [String]
}

enum AttributeName: String, Codable {
    case brands = "Brands"
    case color = "Color"
    case size = "size"
}

enum Backorders: String, Codable {
    case no = "no"
    case yes = "yes"
}

enum CatalogVisibility: String, Codable {
    case visible = "visible"
}

struct Category: Codable {
    let id: Int
    let name, slug: String
}

struct Dimensions: Codable {
    let length, width, height: String
}

struct Image: Codable {
    let id: Int
    let dateCreated, dateCreatedGmt, dateModified, dateModifiedGmt: String
    let src: String
    let name, alt: String
    let position: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case dateCreated = "date_created"
        case dateCreatedGmt = "date_created_gmt"
        case dateModified = "date_modified"
        case dateModifiedGmt = "date_modified_gmt"
        case src, name, alt, position
    }
}

enum LowStockAmount: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(LowStockAmount.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LowStockAmount"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

struct MetaDatum: Codable {
    let id: Int
    let key: String
    let value: ValueUnion
}

enum ValueUnion: Codable {
    case string(String)
    case valueClass(ValueClass)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(ValueClass.self) {
            self = .valueClass(x)
            return
        }
        throw DecodingError.typeMismatch(ValueUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ValueUnion"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .valueClass(let x):
            try container.encode(x)
        }
    }
}

struct ValueClass: Codable {
    let vcGridID: [JSONAnyShop]
    
    enum CodingKeys: String, CodingKey {
        case vcGridID = "vc_grid_id"
    }
}

enum Status: String, Codable {
    case publish = "publish"
}

struct Store: Codable {
    let id: Int
    let name: StoreName
    let url: String
    let avatar: String
    let address: Address1
}

struct Address1: Codable {
    let street1: Street11
    let street2: Street22
    let city: City1
    let zip: Zip1
    let country: Country1
    let state: State1
    
    enum CodingKeys: String, CodingKey {
        case street1 = "street_1"
        case street2 = "street_2"
        case city = "city"
        case zip = "zip"
        case country = "country"
        case state = "state"
    }
}

enum City1: String, Codable {
    case rajbiraj = "Rajbiraj"
}

enum Country1: String, Codable {
    case np = "NP"
}

enum State1: String, Codable {
    case bag = "BAG"
}

enum Street11: String, Codable {
    case rajbiraj3SaptariNepal = "Rajbiraj - 3, Saptari, Nepal"
}

enum Street22: String, Codable {
    case sherpaMall = "Sherpa Mall"
}

enum Zip1: String, Codable {
    case firstFloor = "First Floor"
}

enum StoreName: String, Codable {
    case navinKumarNavjyoti = "Navin Kumar Navjyoti"
}

enum TaxStatus: String, Codable {
    case taxable = "taxable"
}

enum TypeEnum: String, Codable {
    case simple = "simple"
}

// MARK: Encode/decode helpers

class JSONNullShop: Codable, Hashable {
    
    public static func == (lhs: JSONNullShop, rhs: JSONNullShop) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullShop.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNullShop"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}






class JSONCodingKeyShop: CodingKey {
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

class JSONAnyShop: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAnyShopShop")
        return DecodingError.typeMismatch(JSONAnyShop.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAnyShop")
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
            return JSONNullShop()
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
                return JSONNullShop()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKeyShop.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKeyShop>, forKey key: JSONCodingKeyShop) throws -> Any {
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
                return JSONNullShop()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKeyShop.self, forKey: key) {
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
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKeyShop>) throws -> [String: Any] {
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
            } else if value is JSONNullShop {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKeyShop.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKeyShop>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKeyShop(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNullShop {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKeyShop.self, forKey: key)
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
        } else if value is JSONNullShop {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAnyShop.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKeyShop.self) {
            self.value = try JSONAnyShop.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAnyShop.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAnyShop.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKeyShop.self)
            try JSONAnyShop.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAnyShop.encode(to: &container, value: self.value)
        }
    }
}


