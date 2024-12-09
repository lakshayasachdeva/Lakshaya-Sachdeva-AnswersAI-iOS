//
//  AppCard.swift
//  AnswersAIAssignment
//
//  Created by Lakshaya Sachdeva on 09/12/24.
//

import Foundation

struct AppCard: Identifiable, Equatable, Codable {
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
    
    private enum CodingKeys: String, CodingKey {
        case title, subtitle, description, imageName, appName, appCategory, hasInAppPurchase, appIcon, appDeveloper, detail
    }
    
    // Implementing Equatable
    static func == (lhs: AppCard, rhs: AppCard) -> Bool {
        lhs.id == rhs.id
    }
}
