//
//  SearchHeaderView.swift
//  Tahudu
//

import SwiftUI

struct SearchHeaderView: View {
    let topInset: CGFloat
    @Binding var searchText: String
    let showFavoritesOnly: Bool
    let onSearchTap: () -> Void
    let onFilterTap: () -> Void
    let onSortTap: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            SearchHeaderActions(
                showFavoritesOnly: showFavoritesOnly,
                onFilterTap: onFilterTap,
                onSortTap: onSortTap
            )

            ClearableTextField(
                label: "City, community or building",
                symbol: "magnifyingglass",
                text: $searchText
            ) { isEditing in
                if isEditing {
                    onSearchTap()
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 12)
        .background(
            VStack(spacing: 0) {
                Color(.systemGroupedBackground)
                    .frame(height: topInset)
                Color(.systemGroupedBackground)
            }
            .ignoresSafeArea(edges: .top)
        )
    }
}

private struct SearchHeaderActions: View {
    let showFavoritesOnly: Bool
    let onFilterTap: () -> Void
    let onSortTap: () -> Void

    var body: some View {
        HStack {
            HStack(spacing: 8) {
                SearchActionButton(
                    systemName: "slider.horizontal.3",
                    isActive: showFavoritesOnly,
                    action: onFilterTap
                )

                SearchActionButton(
                    systemName: "arrow.up.arrow.down",
                    action: onSortTap
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct SearchActionButton: View {
    let systemName: String
    var isActive = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(isActive ? .white : .primary)
                .frame(width: 44, height: 44)
                .background(isActive ? Color.brand : Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color(.separator).opacity(isActive ? 0 : 0.25), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isActive ? "Showing favourites only" : "Toggle favourites filter")
    }
}
