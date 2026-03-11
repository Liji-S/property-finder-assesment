//
//  ListingCardViewData.swift
//  Tahudu
//

import Foundation

struct ListingCardViewData: Identifiable, Equatable {
    let id: String
    let price: String
    let pricingNote: String?
    let location: String
    let topMetadata: [String]
    let publishedText: String
    let lastContactedText: String?
    let tags: [ListingTag]
    let images: [String]
    let contactOptions: [ContactType]
}

extension ListingCardViewData {
    init(listing: Listing) {
        id = listing.id
        price = listing.priceLabel
        pricingNote = listing.inclusiveLabel
        location = listing.location
        topMetadata = [
            listing.type,
            listing.bedroomLabel,
            listing.bathroomLabel,
            listing.areaLabel
        ]
        publishedText = listing.publishedLabel
        lastContactedText = listing.lastContactedLabel
        tags = listing.tags
        images = listing.images
        contactOptions = listing.contactOptions
    }
}
