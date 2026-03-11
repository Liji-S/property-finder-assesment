//
//  SearchScreenContent.swift
//  Tahudu
//

import SwiftUI

struct SearchScreenContent: View {
    let topInset: CGFloat
    let headerContentHeight: CGFloat
    @Binding var searchText: String
    let showFavoritesOnly: Bool
    let errorMessage: String?
    let emptyStateTitle: String
    let listingCards: [ListingCardViewData]
    let isFavorite: (String) -> Bool
    let onSearchTap: () -> Void
    let onRefresh: () async -> Void
    let onResetFilters: () -> Void
    let onToggleFavorite: (String) -> Void
    let onContactTap: (ContactType, String) -> Void
    let onFilterTap: () -> Void
    let onSortTap: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 16) {
                    Color.clear
                        .frame(height: headerContentHeight)

                    SearchResultsContent(
                        errorMessage: errorMessage,
                        emptyStateTitle: emptyStateTitle,
                        listingCards: listingCards,
                        isFavorite: isFavorite,
                        onRefresh: onRefresh,
                        onResetFilters: onResetFilters,
                        onToggleFavorite: onToggleFavorite,
                        onContactTap: onContactTap
                    )
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }

            SearchHeaderView(
                topInset: topInset,
                searchText: $searchText,
                showFavoritesOnly: showFavoritesOnly,
                onSearchTap: onSearchTap,
                onFilterTap: onFilterTap,
                onSortTap: onSortTap
            )
        }
    }
}
