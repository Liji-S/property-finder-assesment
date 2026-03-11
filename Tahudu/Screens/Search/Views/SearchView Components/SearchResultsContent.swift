//
//  SearchResultsContent.swift
//  Tahudu
//

import SwiftUI

struct SearchResultsContent: View {
    let errorMessage: String?
    let emptyStateTitle: String
    let listingCards: [ListingCardViewData]
    let isFavorite: (String) -> Bool
    let onRefresh: () async -> Void
    let onResetFilters: () -> Void
    let onToggleFavorite: (String) -> Void
    let onContactTap: (ContactType, String) -> Void

    @ViewBuilder
    var body: some View {
        if let errorMessage, listingCards.isEmpty {
            SearchMessageCard(
                title: "Could not load listings",
                subtitle: errorMessage,
                actionTitle: "Try Again"
            ) {
                Task {
                    await onRefresh()
                }
            }
        } else if listingCards.isEmpty {
            SearchMessageCard(
                title: emptyStateTitle,
                subtitle: "Adjust the query or toggle the favourites filter.",
                actionTitle: "Reset Filters",
                action: onResetFilters
            )
        } else {
            ForEach(listingCards) { card in
                ListingCardView(
                    card: card,
                    isFavorite: isFavorite(card.id),
                    favoriteAction: {
                        onToggleFavorite(card.id)
                    },
                    contactAction: { type in
                        onContactTap(type, card.id)
                    }
                )
            }
        }
    }
}

private struct SearchMessageCard: View {
    let title: String
    let subtitle: String
    let actionTitle: String
    let action: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.headline)

            Text(subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            Button(actionTitle, action: action)
                .font(.caption.weight(.semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.brand)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
