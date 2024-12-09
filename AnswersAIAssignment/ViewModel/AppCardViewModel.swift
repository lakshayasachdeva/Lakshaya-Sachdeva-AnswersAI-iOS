//
//  AppCardViewModel.swift
//  AnswersAIAssignment
//
//  Created by Lakshaya Sachdeva on 09/12/24.
//

import Foundation

class AppCardViewModel: ObservableObject {
    @Published var appCards: [AppCard] = []
    
    init() {
        loadAppCards()
    }
    
    private func loadAppCards() {
        guard let url = Bundle.main.url(forResource: "app_cards", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return
        }
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(CardsResponse.self, from: data)
            self.appCards = response.cards
        } catch {
            
        }
    }
}

private struct CardsResponse: Codable {
    let cards: [AppCard]
}
