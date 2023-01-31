//
//  SearchView.swift
//  Nike
//
//  Created by Dauren Sarsenov on 27.01.2023.
//

import SwiftUI

struct SearchView: View {
    
    var animation: Namespace.ID
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var homeData: HomeViewModel
    @FocusState var startTF: Bool
    
    var body: some View {
        
        VStack(spacing:0){
            
            HStack(spacing: 20){
                
                //close button
                Button {
                    withAnimation{
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                
                //search bar
                HStack(spacing:15) {
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                    
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule().strokeBorder(Color.orange, lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom, 10)
            
            if let products = homeData.searchedProducts{
                
                if products.isEmpty{
                    
                    VStack(spacing: 10){
                        
                        Image("NotFound")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                        
                        Text("Item Not Found")
                            .font(.custom("", size: 22).bold())
                        
                        Text("Try a more generic search term or try looking for alternative products.")
                            .font(.custom("", size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,30)
                    }
                    .padding()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing:0) {
                            
                            Text("Found \(products.count) results")
                                .font(.custom("", size: 24).bold())
                                .padding(.vertical)
                            
                            StaggeredGrid(columns: 2, spacing: 20, list: products) {product in
                                
                                ProductCardView(product: product)
                            }
                        }
                        .padding()
                    }
                }
            } else {
                
                ProgressView()
                    .padding(.top,30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("mainColor").ignoresSafeArea()) // change color
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                startTF = true
            }
        }
    }
    
    @ViewBuilder
    func ProductCardView(product: Product)-> some View {
        
        VStack(spacing:10){
            
                ZStack{
                    
//                    if sharedData.showDetailProduct{
//                        Image(product.productImage)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .cornerRadius(150)
//                            .opacity(0)
//                    } else {
//                        Image(product.productImage)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .cornerRadius(150)
//                            .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
//                    }
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(150)
                }
                .offset(y: -50)
                .padding(.bottom, -65)
            
            Text(product.title)
                .font(.custom("", size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.custom("", size: 14))
                .foregroundColor(.gray)
            
            Text("$\(product.price)")
                .font(.custom("", size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color.orange)
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white.cornerRadius(25)
        )
        .padding(.top,30)
        .onTapGesture {
            withAnimation(.easeInOut){
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
