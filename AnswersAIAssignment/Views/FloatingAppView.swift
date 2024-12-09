//
//  FloatingAppView.swift
//  AnswersAIAssignment
//
//  Created by Lakshaya Sachdeva on 09/12/24.
//

import SwiftUI

struct FloatingAppView: View {
    var card: AppCard
    
    var body: some View {
        HStack(spacing: 12) {
            Image(card.appIcon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            
            VStack(alignment: .leading, spacing: 1) {
                Text(card.appName)
                    .font(.system(size: 16, weight: .semibold))
                Text(card.appCategory)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {} label: {
                Image(systemName: "icloud.and.arrow.down")
                    .font(.system(size: 22))
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.thickMaterial)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
        }
        .padding(.horizontal)
        .padding(.bottom, safeArea().bottom)
    }
}

#Preview {
    FloatingAppView(card: AppCard(
        title: "Hit the Ground Running\nWith Runna",
        subtitle: "APPS WE LOVE",
        description: "Training plans for your next marathon or run around the park.",
        imageName: "card_cover_img",
        appName: "Runna: Running Training Plans",
        appCategory: "5k, 10k, Half, Marathon, Ultra",
        hasInAppPurchase: true,
        appIcon: "cardIcon",
        appDeveloper: "lakshaya@gmail.com",
        detail: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    ))
}
