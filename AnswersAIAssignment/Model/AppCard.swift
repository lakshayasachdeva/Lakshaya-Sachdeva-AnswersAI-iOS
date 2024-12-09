//
//  AppCard.swift
//  AnswersAIAssignment
//
//  Created by Lakshaya Sachdeva on 09/12/24.
//

import Foundation

struct AppCard: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let subtitle: String
    let description: String
    let imageName: String
    let appName: String
    let appCategory: String
    let hasInAppPurchase: Bool
    let appIcon: String
    let appDeveloper: String
    let detail: String
    
    // Implementing Equatable
    static func == (lhs: AppCard, rhs: AppCard) -> Bool {
        lhs.id == rhs.id
    }
}
