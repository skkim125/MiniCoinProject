//
//  CoinSearchRowView.swift
//  MiniCoinProject
//
//  Created by 김상규 on 9/9/24.
//

import SwiftUI

struct CoinSearchRowView: View {
    var body: some View {
        HStack {
            Image(systemName: "star.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text("비트코인")
                    .font(.title3)
                
                Text("BTC")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.leading, 5)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "star")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    CoinSearchRowView()
}
