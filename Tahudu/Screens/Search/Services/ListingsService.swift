//
//  ListingsService.swift
//  Tahudu
//

import Foundation

protocol ListingsServicingProtocol {
    func fetchListings() async throws -> [Listing]
}

struct ListingsService: ListingsServicingProtocol {
    private let networkService: NetworkServicingProtocol
    private let listingsURL = URL(string: "https://simplejsoncms.com/api/m6nfoc4jlw")!

    init(networkService: NetworkServicingProtocol) {
        self.networkService = networkService
    }

    func fetchListings() async throws -> [Listing] {
        let response = try await networkService.fetch(ListingResponse.self, from: listingsURL)
        return response.listings
    }
}
