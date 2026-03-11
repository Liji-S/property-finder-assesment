//
//  FavoritesStore.swift
//  Tahudu
//

import Foundation

protocol FavoritesStoringProtocol {
    func load() -> Set<String>
    func save(_ favorites: Set<String>)
}

struct FavoritesStore: FavoritesStoringProtocol {
    private let favoriteUserdefaults: UserDefaults
    private let key: String

    init(favoriteUserdefaults: UserDefaults = .standard, key: String = "favorite_listing_ids") {
        self.favoriteUserdefaults = favoriteUserdefaults
        self.key = key
    }

    func load() -> Set<String> {
        Set(favoriteUserdefaults.stringArray(forKey: key) ?? [])
    }

    func save(_ favorites: Set<String>) {
        favoriteUserdefaults.set(Array(favorites).sorted(), forKey: key)
    }
}
