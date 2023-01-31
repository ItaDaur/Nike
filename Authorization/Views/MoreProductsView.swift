//
//  MoreProductsView.swift
//  Nike
//
//  Created by Dauren Sarsenov on 27.01.2023.
//

import SwiftUI

struct MoreProductsView: View {
    var body: some View {
        
        VStack {
            
            Text("More Products")
                .font(.custom("", size: 24).bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background()
    }
}

struct MoreProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}
