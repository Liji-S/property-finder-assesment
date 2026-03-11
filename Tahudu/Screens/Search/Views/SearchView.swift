//
//  SearchView.swift
//  Tahudu
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel: SearchViewModel
    private let headerContentHeight: CGFloat = 124

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            let topInset = geometry.safeAreaInsets.top

            NavigationView {
                SearchScreenContent(
                    topInset: topInset,
                    headerContentHeight: headerContentHeight,
                    searchText: $viewModel.searchText,
                    showFavoritesOnly: viewModel.showFavoritesOnly,
                    errorMessage: viewModel.errorMessage,
                    emptyStateTitle: viewModel.emptyStateTitle,
                    listingCards: viewModel.listingCards,
                    isFavorite: viewModel.isFavorite,
                    onSearchTap: viewModel.performSearchTap,
                    onRefresh: {
                        await viewModel.refresh()
                    },
                    onResetFilters: {
                        viewModel.searchText = ""
                        viewModel.showFavoritesOnly = false
                    },
                    onToggleFavorite: { listingID in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.toggleFavorite(for: listingID)
                        }
                    },
                    onContactTap: { type, listingID in
                        viewModel.performContactTap(type: type, listingID: listingID)
                    },
                    onFilterTap: viewModel.performFilterTap,
                    onSortTap: viewModel.performSortTap
                )
                .navigationBarHidden(true)
            }
        }
        .task {
            await viewModel.loadListings()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: AppContainer().makeSearchViewModel())
    }
}
