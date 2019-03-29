//
//  ProductResponse.swift
//  ShopHome
//
//  Created by kiran on 3/27/19.
//  Copyright © 2019 kiran. All rights reserved.
//

import Foundation


typealias ProductResponse = [ProductResponseElement]

struct ProductResponseElement: Codable {
    let id: Int
    let name, slug: String
    let permalink: String
    let dateCreated, dateCreatedGmt, dateModified, dateModifiedGmt: String
    let type: ProductResTypeEnum
    let status: ProductResStatus
    let featured: Bool
    let catalogVisibility: ProductResCatalogVisibility
    let description: String
    let shortDescription: ShortDescription
    let sku, price, regularPrice, salePrice: String
    let dateOnSaleFrom, dateOnSaleFromGmt, dateOnSaleTo, dateOnSaleToGmt: ProductResJSONNull?
    let priceHTML: String
    let onSale, purchasable: Bool
    let totalSales: Int
    let virtual, downloadable: Bool
    let downloads: [ProductResJSONAny]
    let downloadLimit, downloadExpiry: Int
    let externalURL, buttonText: String
    let taxStatus: ProductResTaxStatus
    let taxClass: String
    let manageStock: Bool
    let stockQuantity: ProductResJSONNull?
    let inStock: Bool
    let backorders: ProductResBackorders
    let backordersAllowed, backordered, soldIndividually: Bool
    let weight: String
    let dimensions: ProductResDimensions
    let shippingRequired, shippingTaxable: Bool
    let shippingClass: String
    let shippingClassID: Int
    let reviewsAllowed: Bool
    let averageRating: String
    let ratingCount: Int
    let relatedIDS: [Int]
    let upsellIDS, crossSellIDS: [ProductResJSONAny]
    let parentID: Int
    let purchaseNote: String
    let categories: [ProductResCategory]
    let tags: [ProductResJSONAny]
    let images: [ProductResImage]
    let attributes: [Attribute]
    let defaultAttributes, variations, groupedProducts: [ProductResJSONAny]
    let menuOrder: Int
    let metaData: [ProductResMetaDatum]
    let store: ProductResStore
    let links: ProductResLinks
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug, permalink
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
        case virtual, downloadable, downloads
        case downloadLimit = "download_limit"
        case downloadExpiry = "download_expiry"
        case externalURL = "external_url"
        case buttonText = "button_text"
        case taxStatus = "tax_status"
        case taxClass = "tax_class"
        case manageStock = "manage_stock"
        case stockQuantity = "stock_quantity"
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
        case upsellIDS = "upsell_ids"
        case crossSellIDS = "cross_sell_ids"
        case parentID = "parent_id"
        case purchaseNote = "purchase_note"
        case categories, tags, images, attributes
        case defaultAttributes = "default_attributes"
        case variations
        case groupedProducts = "grouped_products"
        case menuOrder = "menu_order"
        case metaData = "meta_data"
        case store
        case links = "_links"
    }
}

struct Attribute: Codable {
    let id: Int
    let name: String
    let position: Int
    let visible, variation: Bool
    let options: [String]
}

enum ProductResBackorders: String, Codable {
    case no = "no"
}

enum ProductResCatalogVisibility: String, Codable {
    case visible = "visible"
}

struct ProductResCategory: Codable {
    let id: Int
    let name: ProductResCategoryName
    let slug: Slug
}

enum ProductResCategoryName: String, Codable {
    case electronics = "Electronics"
    case samsung = "Samsung"
    case uncategorized = "Uncategorized"
}

enum Slug: String, Codable {
    case electronics = "electronics"
    case samsung = "samsung"
    case uncategorized = "uncategorized"
}

struct ProductResDimensions: Codable {
    let length, width, height: String
}

struct ProductResImage: Codable {
    let id: Int
    let dateCreated, dateCreatedGmt, dateModified, dateModifiedGmt: String
    let src: String
    let name: String
    let alt: ProductResAlt
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

enum ProductResAlt: String, Codable {
    case empty = ""
    case placeholder = "Placeholder"
}

struct ProductResLinks: Codable {
    let linksSelf, collection: [ProductResCollection]
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case collection
    }
}

struct ProductResCollection: Codable {
    let href: String
}

struct ProductResMetaDatum: Codable {
    let id: Int
    let key: String
    let value: ProductResValueUnion
}

enum ProductResValueUnion: Codable {
    case string(String)
    case valueClass(ProductResValueClass)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(ProductResValueClass.self) {
            self = .valueClass(x)
            return
        }
        throw DecodingError.typeMismatch(ProductResValueUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ProductResValueUnion"))
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

struct ProductResValueClass: Codable {
    let vcGridID: [ProductResJSONAny]
    
    enum CodingKeys: String, CodingKey {
        case vcGridID = "vc_grid_id"
    }
}

enum ShortDescription: String, Codable {
    case empty = ""
    case pStrongModelStrongKLV40R352CP = "<p><strong>Model :</strong> KLV-40R352C</p>\n"
}

enum ProductResStatus: String, Codable {
    case publish = "publish"
}

struct ProductResStore: Codable {
    let id: Int
    let name: ProductResStoreName
    let shopName: ShopName
    let url: String
    let address: ProductResAddress
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case shopName = "shop_name"
        case url, address
    }
}

struct ProductResAddress: Codable {
    let street1: ProductResStreet1
    let street2: ProductResStreet2
    let city: ProductResCity
    let zip: ProductResZip
    let country: ProductResCountry
    let state: ProductResState
    
    enum CodingKeys: String, CodingKey {
        case street1 = "street_1"
        case street2 = "street_2"
        case city, zip, country, state
    }
}

enum ProductResCity: String, Codable {
    case rajbiraj = "Rajbiraj"
}

enum ProductResCountry: String, Codable {
    case np = "NP"
}

enum ProductResState: String, Codable {
    case bag = "BAG"
}

enum ProductResStreet1: String, Codable {
    case rajbiraj3SaptariNepal = "Rajbiraj - 3, Saptari, Nepal"
}

enum ProductResStreet2: String, Codable {
    case sherpaMall = "Sherpa Mall"
}

enum ProductResZip: String, Codable {
    case firstFloor = "First Floor"
}

enum ProductResStoreName: String, Codable {
    case admin = "admin"
}

enum ShopName: String, Codable {
    case navinKumarNavjyoti = "Navin Kumar Navjyoti"
}

enum ProductResTaxStatus: String, Codable {
    case taxable = "taxable"
}

enum ProductResTypeEnum: String, Codable {
    case simple = "simple"
}

// MARK: Encode/decode helpers

class ProductResJSONNull: Codable, Hashable {
    
    public static func == (lhs: ProductResJSONNull, rhs: ProductResJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(ProductResJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ProductResJSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class ProductResJSONCodingKey: CodingKey {
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

class ProductResJSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode ProductResJSONAny")
        return DecodingError.typeMismatch(ProductResJSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode ProductResJSONAny")
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
            return ProductResJSONNull()
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
                return ProductResJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: ProductResJSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<ProductResJSONCodingKey>, forKey key: ProductResJSONCodingKey) throws -> Any {
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
                return ProductResJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: ProductResJSONCodingKey.self, forKey: key) {
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
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<ProductResJSONCodingKey>) throws -> [String: Any] {
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
            } else if value is ProductResJSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: ProductResJSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<ProductResJSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = ProductResJSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is ProductResJSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: ProductResJSONCodingKey.self, forKey: key)
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
        } else if value is ProductResJSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try ProductResJSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: ProductResJSONCodingKey.self) {
            self.value = try ProductResJSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try ProductResJSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try ProductResJSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: ProductResJSONCodingKey.self)
            try ProductResJSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try ProductResJSONAny.encode(to: &container, value: self.value)
        }
    }
}
