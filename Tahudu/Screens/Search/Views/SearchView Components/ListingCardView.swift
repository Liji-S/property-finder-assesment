//
//  ListingCardView.swift
//  Tahudu
//

import SwiftUI

struct ListingCardView: View {
    let card: ListingCardViewData
    let isFavorite: Bool
    let favoriteAction: () -> Void
    let contactAction: (ContactType) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ListingCarouselView(
                images: card.images,
                tags: card.tags,
                isFavorite: isFavorite,
                favoriteAction: favoriteAction
            )

            VStack(alignment: .leading, spacing: 8) {
                Text(card.price)
                    .font(.headline)

                if let pricingNote = card.pricingNote {
                    Text(pricingNote)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                Text(card.location)
                    .font(.caption)
                    .foregroundColor(.primary)

                HStack(spacing: 8) {
                    ForEach(card.topMetadata, id: \.self) { item in
                        ListingMetaPill(title: item)
                    }
                }

                HStack {
                    Text(card.publishedText)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Spacer()

                    HStack(spacing: 8) {
                        ForEach(card.contactOptions, id: \.rawValue) { type in
                            ContactButton(type) {
                                contactAction(type)
                            }
                        }
                    }
                }

                if let lastContactedText = card.lastContactedText {
                    Text(lastContactedText)
                        .font(.caption.weight(.medium))
                        .foregroundColor(.orange)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.orange.opacity(0.14))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.06), radius: 10, y: 4)
    }
}

private struct ListingCarouselView: View {
    let images: [String]
    let tags: [ListingTag]
    let isFavorite: Bool
    let favoriteAction: () -> Void

    var body: some View {
        TabView {
            ForEach(images, id: \.self) { imageName in
                ZStack(alignment: .topLeading) {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 220)
                        .clipped()

                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(tags, id: \.rawValue) { tag in
                            Text(tag.title)
                                .font(.caption2.weight(.bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                                .background(Color.black.opacity(0.72))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                    }
                    .padding(12)
                }
            }
        }
        .frame(height: 220)
        .tabViewStyle(.page(indexDisplayMode: .automatic))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            Button(action: favoriteAction) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(isFavorite ? .red : .primary)
                    .frame(width: 36, height: 36)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.12), radius: 6, y: 2)
            }
            .buttonStyle(.plain)
            .padding(12),
            alignment: .topTrailing
        )
    }
}

private struct ListingMetaPill: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
