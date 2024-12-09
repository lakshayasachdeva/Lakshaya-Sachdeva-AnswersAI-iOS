//
//  DetailView.swift
//  AnswersAIAssignment
//
//  Created by Lakshaya Sachdeva on 09/12/24.
//

import SwiftUI

struct DetailView: View {
    var card: AppCard
    @State var isLoading = false
    @State var showInstallOverlay = false
    @Environment(\.dismiss) var dismiss
    @State private var showShareSheet: Bool = false
    @State private var showFloatingView = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    VStack {
                        GeometryReader { reader -> AnyView in
                            let offset = reader.frame(in: .global).minY
                            DispatchQueue.main.async {
                                showFloatingView = offset < -500
                            }
                            return AnyView(Color.clear)
                        }
                        .frame(height: 0)
                        
                        ZStack {
                            Image(card.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 500)
                                .clipped()
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Spacer()
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(card.subtitle)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .textCase(.uppercase)
                                        .foregroundStyle(.white.opacity(0.8))
                                    
                                    Text(card.title)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                    
                                    Text(card.description)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.8))
                                }
                                .padding(.leading, 16)
                                
                                HStack(spacing: 12) {
                                    Image(card.appIcon)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 56, height: 56)
                                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(card.appName)
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.white)
                                        Text(card.appCategory)
                                            .font(.system(size: 13))
                                            .foregroundColor(.white.opacity(0.8))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    VStack(spacing: 3) {
                                        Button {
                                            isLoading = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                                showInstallOverlay.toggle()
                                                isLoading = false
                                            }
                                        } label: {
                                            if isLoading {
                                                CircularLoadingView()
                                            } else {
                                                Text("Get")
                                                    .font(.system(size: 16, weight: .bold))
                                                    .foregroundColor(.white)
                                                    .frame(width: 72, height: 28)
                                                    .background(
                                                        Capsule()
                                                            .fill(.white)
                                                            .opacity(0.3)
                                                    )
                                            }
                                        }
                                        
                                        if card.hasInAppPurchase {
                                            Text("In-App Purchases")
                                                .font(.system(size: 10))
                                                .foregroundColor(.white)
                                                .opacity(isLoading ? 0 : 1)
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 16)
                                .background(.ultraThinMaterial)
                            }
                        }
                        
                        Text(card.detail)
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.7))
                            .fontWeight(.regular)
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        
                        Divider()
                        
                        Button {
                            showShareSheet.toggle()
                        } label: {
                            Label("Share Story", systemImage: "square.and.arrow.up.fill")
                                .foregroundColor(.primary)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background {
                                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                                        .fill(.ultraThinMaterial)
                                }
                        }
                        .padding()
                    }
                    .padding(.bottom)
                }
                
                Button {
                    dismiss()
                } label: {
                    ZStack {
                        Circle()
                            .fill(.white.opacity(0.7))
                            .frame(width: 36, height: 36)
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
                .padding(.horizontal)
                .offset(x: 0, y: 75)
                
                if showFloatingView {
                    VStack {
                        Spacer()
                        FloatingAppView(card: card)
                    }
                    .transition(.move(edge: .bottom))
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
        .background(Color(UIColor.systemBackground).ignoresSafeArea())
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: [
                "Check out this app: \(String(describing: card.appName))",
                "A \(String(describing: card.appCategory)) app that helps you \(String(describing: card.description))"
            ])
            .presentationDetents([.medium, .large])
        }
        .fullScreenCover(isPresented: $showInstallOverlay, onDismiss: {
        }) {
            AppInstallOverlay(
                card: card,
                isPresented: $showInstallOverlay
            )
            .environment(\.safeAreaInsets, UIApplication.shared.windows.first?.safeAreaInsets ?? .zero)
            .presentationBackground(.clear)
        }
    }
}

#Preview {
    DetailView(card: AppCard(
        title: "Hit the Ground Running\nWith Runna",
        subtitle: "APPS WE LOVE",
        description: "Training plans for your next marathon or run around the park.",
        imageName: "card_cover_img",
        appName: "Runna: Running Training Plans",
        appCategory: "5k, 10k, Half, Marathon, Ultra",
        hasInAppPurchase: true,
        appIcon: "cardIcon",
        appDeveloper: "lakshaya@gmail.com",
        detail: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    ))
}


extension View {
    func safeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}
