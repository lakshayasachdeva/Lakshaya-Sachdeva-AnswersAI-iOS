//
//  HomeView.swift
//  AnswersAIAssignment
//
//  Created by Lakshaya Sachdeva on 09/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = AppCardViewModel()
    @Namespace var transitionAnimation
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    HeaderView()
                }
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.appCards) { card in
                        if #available(iOS 18.0, *) {
                            NavigationLink(destination: DetailView(card: card)
                                .navigationTransition(.zoom(sourceID: card.id, in: transitionAnimation))
                            ) {
                                CardView(card: card)
                            }
                            .buttonStyle(ScaledButtonStyle())
                        } else {
                            NavigationLink(destination: DetailView(card: card)) {
                                CardView(card: card)
                            }
                            .buttonStyle(ScaledButtonStyle())
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
