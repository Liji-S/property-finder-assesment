//
//  AppContainer.swift
//  Tahudu
//

import Foundation

// Here I have used a centralized container to manage DI in one place so it would be easy for us to manage the DI through this container. I have introduced 3 protocols here to achieve DI.
// This container we initialze only once in the root level.

struct AppContainer {
    let networkService: NetworkServicingProtocol
    let listingsService: ListingsServicingProtocol
    let favoritesStore: FavoritesStoringProtocol

    init(
        networkService: NetworkServicingProtocol = NetworkService(),
        favoritesStore: FavoritesStoringProtocol = FavoritesStore()
    ) {
        self.networkService = networkService
        self.listingsService = ListingsService(networkService: networkService)
        self.favoritesStore = favoritesStore
    }

    @MainActor
    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(
            listingsService: listingsService,
            favoritesStore: favoritesStore
        )
    }
}
