//
//  AppInstallOverlay.swift
//  AnswersAIAssignment
//
//  Created by Lakshaya Sachdeva on 09/12/24.
//

import SwiftUI

struct AppInstallOverlay: View {
    var card: AppCard
    @Binding var isPresented: Bool
    @State private var offsetX: CGFloat = 0
    @State private var isAnimating = false
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        ZStack {
            // Full screen dismissible background
            Color.black.opacity(0.85)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented.toggle()
                }
            
            // Double Click to Install text with indicator line on right side
            GeometryReader { geometry in
                VStack {
                    HStack(spacing: 8) {
                        Spacer()
                        Text("Double-Click\nto Install")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.white)
                        
                        // Vertical indicator line
                        Rectangle()
                            .fill(.white)
                            .frame(width: 6, height: 120)
                            .cornerRadius(1.5)
                    }
                    .padding(.trailing, 2)
                    Spacer()
                }
                .padding(.trailing, 2)
                .offset(x: offsetX, y: geometry.size.height * 0.22)
                .onAppear {
                    func startAnimation() {
                        // First pulse left
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.1)) {
                            offsetX = -8
                        }
                        
                        // Reset for second pulse
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.spring(response: 0.15, dampingFraction: 0.6, blendDuration: 0.1)) {
                                offsetX = 0
                            }
                        }
                        
                        // Second pulse left
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.1)) {
                                offsetX = -8
                            }
                        }
                        
                        // Final return to original position
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.1)) {
                                offsetX = 0
                            }
                        }
                        
                        // Restart animation after a shorter delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                            startAnimation()
                        }
                    }
                    
                    // Start the initial animation
                    startAnimation()
                }
            }
            
            VStack(spacing: 0) {
                Spacer()
                
                // Entire bottom sheet
                VStack(spacing: 20) {
                    // App Store header with close button
                    HStack {
                        Text("App Store")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        Spacer()
                        Button {
                            withAnimation {
                                isPresented.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(.white).opacity(0.7))
                                .frame(width: 28, height: 28)
                                .background(Color.white.opacity(0.1))
                                .clipShape(.circle)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // App info card
                    VStack(spacing: 8) {
                        HStack(spacing: 12) {
                            Image(card.appIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 52, height: 52)
                                .cornerRadius(12)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(card.appName)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                Text(card.appDeveloper)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                Text("Offers In-App Purchases")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                                                        
                           
                        }
                        
                        Divider()
                            .opacity(0.5)
                        
                        Text("Account: \(card.appDeveloper)")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(.ultraThinMaterial)
                    }
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Install confirmation
                    VStack(spacing: 4) {
                        ZStack {
                            Circle()
                                .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                                .frame(width: 56, height: 56)
                            
                            Image(systemName: "lock.open.iphone")
                                .font(.system(size: 28))
                                .foregroundColor(.blue)
                            
                        }
                        
                        Text("Confirm with Side Button")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 24)
                }
                .background {
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .fill(.thickMaterial)
                }
                
                
            }
            .ignoresSafeArea()
            
        }
    }
}

#Preview {
    @State var isPresented:Bool = true

    AppInstallOverlay(card: AppCard(
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
    ), isPresented: $isPresented)
}


// Environment value for safe area
private struct SafeAreaInsetsKey: EnvironmentKey {
    static let defaultValue: UIEdgeInsets = .zero
}

extension EnvironmentValues {
    var safeAreaInsets: UIEdgeInsets {
        get { self[SafeAreaInsetsKey.self] }
        set { self[SafeAreaInsetsKey.self] = newValue }
    }
}
