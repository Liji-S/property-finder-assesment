//
//  SearchViewModelTests.swift
//  TahuduTests
//

import XCTest
@testable import Tahudu

@MainActor
final class SearchViewModelTests: XCTestCase {
    func testToggleFavoritePersistsID() {
        let favoritesStore = InMemoryFavoritesStore()
        let viewModel = SearchViewModel(
            listingsService: MockListingsService(listings: []),
            favoritesStore: favoritesStore
        )

        viewModel.toggleFavorite(for: "prop_001")

        XCTAssertTrue(viewModel.isFavorite("prop_001"))
        XCTAssertEqual(favoritesStore.savedFavorites, Set(["prop_001"]))
    }

    func testFilteredListingsHonorsSearchAndFavorites() async {
        let listing = Listing(
            id: "prop_001",
            type: "Apartment",
            deliveryYear: 2022,
            price: 2575000,
            currency: "AED",
            priceInclusive: true,
            location: "Laguna Tower, Lake Almas West, Jumeirah Lake Tower",
            bedrooms: nil,
            bathrooms: 1,
            areaSqft: 1356,
            publishedAt: Date(),
            lastContactedAt: nil,
            tags: [ListingTag(rawValue: "verified")],
            images: ["FirstImage"],
            contactOptions: [.phone]
        )

        let viewModel = SearchViewModel(
            listingsService: MockListingsService(listings: [listing]),
            favoritesStore: InMemoryFavoritesStore()
        )

        await viewModel.refresh()
        viewModel.searchText = "laguna"
        XCTAssertEqual(viewModel.filteredListings.map(\.id), ["prop_001"])

        viewModel.showFavoritesOnly = true
        XCTAssertTrue(viewModel.filteredListings.isEmpty)

        viewModel.toggleFavorite(for: "prop_001")
        XCTAssertEqual(viewModel.filteredListings.map(\.id), ["prop_001"])
    }

    func testListingFormatting() {
        let listing = Listing(
            id: "prop_001",
            type: "Apartment",
            deliveryYear: 2022,
            price: 2575000,
            currency: "AED",
            priceInclusive: true,
            location: "Laguna Tower",
            bedrooms: nil,
            bathrooms: 1,
            areaSqft: 1356,
            publishedAt: Date(),
            lastContactedAt: nil,
            tags: [],
            images: [],
            contactOptions: []
        )

        XCTAssertEqual(listing.bedroomLabel, "Studio")
        XCTAssertEqual(listing.priceLabel, "2,575,000 AED")
        XCTAssertEqual(listing.areaLabel, "1,356 sqft")
    }
}

private struct MockListingsService: ListingsServicing {
    let listings: [Listing]

    func fetchListings() async throws -> [Listing] {
        listings
    }
}

private final class InMemoryFavoritesStore: FavoritesStoring {
    private(set) var savedFavorites: Set<String> = []

    func load() -> Set<String> {
        savedFavorites
    }

    func save(_ favorites: Set<String>) {
        savedFavorites = favorites
    }
}
