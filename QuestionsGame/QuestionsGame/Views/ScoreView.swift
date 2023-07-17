//
//  ScoreView.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import SwiftUI

struct ScoreView: View {
    var score: String
    var body: some View {
        VStack(alignment: .leading) {
            Text("Score: \(score)")
                .lineLimit(26)
                .font(.system(size: 22, weight: .regular))
                .multilineTextAlignment(.leading)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 61,
                    alignment: .leading
                )
                .padding(.all, 17)
        }
        .frame(width: 350, height: 61)
        .background(Color(hex: "#E1F8FF"))
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .shadow(color: .black.opacity(0.25), radius: 4, x: -2, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                    .stroke(.black, lineWidth: 1)
        )
    }
}

#if !TESTING
struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {

        ScoreView(score: "0")
            .frame(alignment: .center)
    }
}
#endif
