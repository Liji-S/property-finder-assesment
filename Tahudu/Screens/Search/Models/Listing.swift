//
//  Listing.swift
//  Tahudu
//

import Foundation

struct ListingResponse: Decodable {
    let listings: [Listing]
}

struct Listing: Identifiable, Decodable, Equatable {
    let id: String
    let type: String
    let deliveryYear: Int
    let price: Int
    let currency: String
    let priceInclusive: Bool
    let location: String
    let bedrooms: Int?
    let bathrooms: Int
    let areaSqft: Int
    let publishedAt: Date
    let lastContactedAt: Date?
    let tags: [ListingTag]
    let images: [String]
    let contactOptions: [ContactType]

    init(
        id: String,
        type: String,
        deliveryYear: Int,
        price: Int,
        currency: String,
        priceInclusive: Bool,
        location: String,
        bedrooms: Int?,
        bathrooms: Int,
        areaSqft: Int,
        publishedAt: Date,
        lastContactedAt: Date?,
        tags: [ListingTag],
        images: [String],
        contactOptions: [ContactType]
    ) {
        self.id = id
        self.type = type
        self.deliveryYear = deliveryYear
        self.price = price
        self.currency = currency
        self.priceInclusive = priceInclusive
        self.location = location
        self.bedrooms = bedrooms
        self.bathrooms = bathrooms
        self.areaSqft = areaSqft
        self.publishedAt = publishedAt
        self.lastContactedAt = lastContactedAt
        self.tags = tags
        self.images = images
        self.contactOptions = contactOptions
    }

    var bedroomLabel: String {
        guard let bedrooms else {
            return "Studio"
        }

        return "\(bedrooms) Bed" + (bedrooms == 1 ? "" : "s")
    }

    var bathroomLabel: String {
        "\(bathrooms) Bath" + (bathrooms == 1 ? "" : "s")
    }

    var areaLabel: String {
        "\(areaSqft.formattedGrouped) sqft"
    }

    var priceLabel: String {
        "\(price.formattedGrouped) \(currency)"
    }

    var inclusiveLabel: String? {
        priceInclusive ? "Inclusive of all taxes" : nil
    }

    var publishedLabel: String {
        "Published \(publishedAt.relativeDescription)"
    }

    var lastContactedLabel: String? {
        guard let lastContactedAt else {
            return nil
        }

        return "Last contacted \(lastContactedAt.relativeDescription)"
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case deliveryYear
        case price
        case currency
        case priceInclusive
        case location
        case bedrooms
        case bathrooms
        case areaSqft
        case publishedAt
        case lastContactedAt
        case tags
        case images
        case contactOptions
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        deliveryYear = try container.decode(Int.self, forKey: .deliveryYear)
        price = try container.decode(Int.self, forKey: .price)
        currency = try container.decode(String.self, forKey: .currency)
        priceInclusive = try container.decode(Bool.self, forKey: .priceInclusive)
        location = try container.decode(String.self, forKey: .location)
        bedrooms = try container.decodeIfPresent(Int.self, forKey: .bedrooms)
        bathrooms = try container.decode(Int.self, forKey: .bathrooms)
        areaSqft = try container.decode(Int.self, forKey: .areaSqft)
        publishedAt = try container.decode(Date.self, forKey: .publishedAt)
        lastContactedAt = try container.decodeIfPresent(Date.self, forKey: .lastContactedAt)
        tags = try container.decode([ListingTag].self, forKey: .tags)
        images = try container.decode([ListingImageAsset].self, forKey: .images).map(\.assetName)
        contactOptions = try container.decode([ContactType].self, forKey: .contactOptions)
    }
}

struct ListingTag: Decodable, Equatable, Hashable {
    let rawValue: String

    init(rawValue: String) {
        self.rawValue = rawValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try container.decode(String.self)
    }

    var title: String {
        rawValue
            .replacingOccurrences(of: "_", with: " ")
            .uppercased()
    }
}

private enum ListingImageAsset: String, Decodable {
    case firstImage = "first_image"
    case secondImage = "second_image"

    var assetName: String {
        switch self {
        case .firstImage:
            return "FirstImage"
        case .secondImage:
            return "SecondImage"
        }
    }
}
