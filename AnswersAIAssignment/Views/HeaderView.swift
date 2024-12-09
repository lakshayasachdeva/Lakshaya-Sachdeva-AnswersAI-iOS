//
//  HeaderView.swift
//  AnswersAIAssignment
//
//  Created by Lakshaya Sachdeva on 09/12/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("Today")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("8 December")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, 6)
            Spacer()
            
            Button {
            } label: {
                Image(systemName: "person.circle.fill")
                    .font(.largeTitle)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    HeaderView()
}
