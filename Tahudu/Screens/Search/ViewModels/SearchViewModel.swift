//
//  SearchViewModel.swift
//  Tahudu
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var showFavoritesOnly = false
    @Published private(set) var listings: [Listing] = []
    @Published private(set) var favoriteIDs: Set<String> // I have used Set here for ensuring no duplicates
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let listingsService: ListingsServicingProtocol
    private let favoritesStore: FavoritesStoringProtocol

    init(
        listingsService: ListingsServicingProtocol,
        favoritesStore: FavoritesStoringProtocol
    ) {
        self.listingsService = listingsService
        self.favoritesStore = favoritesStore
        self.favoriteIDs = favoritesStore.load()
    }

    var filteredListings: [Listing] {
        listings.filter { listing in
            let matchesFavorites = !showFavoritesOnly || favoriteIDs.contains(listing.id)
            let finalQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            let matchesQuery = finalQuery.isEmpty
                || listing.location.localizedCaseInsensitiveContains(finalQuery)
                || listing.type.localizedCaseInsensitiveContains(finalQuery)

            return matchesFavorites && matchesQuery
        }
    }

    var listingCards: [ListingCardViewData] {
        filteredListings.map(ListingCardViewData.init)
    }

    var emptyStateTitle: String {
        if isLoading {
            return "Loading listings..."
        }

        if showFavoritesOnly {
            return "No favourited listings"
        }

        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "No matching listings"
        }

        return "No listings available"
    }

    func loadListings() async {
        guard listings.isEmpty else {
            return
        }

        await refresh()
    }

    func refresh() async {
        isLoading = true
        errorMessage = nil
        
        do {
            listings = try await listingsService.fetchListings()
        } catch {
            errorMessage = error.localizedDescription
            AppLogger.log("Failed to fetch listings: \(error.localizedDescription)")
        }
        
        isLoading = false
    }

    func toggleFavorite(for listingID: String) {
        if favoriteIDs.contains(listingID) {
            favoriteIDs.remove(listingID)
        } else {
            favoriteIDs.insert(listingID)
        }

        favoritesStore.save(favoriteIDs)
    }

    func isFavorite(_ listingID: String) -> Bool {
        favoriteIDs.contains(listingID)
    }

    func performSearchTap() {
        AppLogger.log("Search bar tapped with query: \(searchText)")
    }

    func performMapTap() {
        AppLogger.log("Map button tapped")
    }

    func performSortTap() {
        AppLogger.log("Sort button tapped")
    }

    func performFilterTap() {
        showFavoritesOnly.toggle()
        AppLogger.log("Favorites filter toggled: \(showFavoritesOnly)")
    }

    func performContactTap(type: ContactType, listingID: String) {
        AppLogger.log("Contact tapped: \(type.analyticsName) for listing \(listingID)")
    }
}
