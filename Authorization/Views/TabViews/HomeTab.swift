//
//  HomeTab.swift
//  Nike
//
//  Created by Dauren Sarsenov on 27.01.2023.
//

import SwiftUI

struct HomeTab: View {
    var animation: Namespace.ID
    @EnvironmentObject var sharedData: SharedDataModel
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 15) {
                
                // Search Bar
                ZStack{
                    if homeData.searchActivated{
                        SearchBar()
                    } else {
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut){
                        homeData.searchActivated = true
                    }
                }
                
                Text("Order online\ncollect in store")
                    .font(.custom("", size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                //Product Tab
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 18){
                        
                        ForEach(ProductType.allCases, id: \.self){ type in
                            // Product type view
                            ProductTypeView(type: type)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 28)
                
                //Products page
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack(spacing: 25){
                        
                        ForEach(homeData.filteredProducts){product in
                            
                            //Product Card View
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                }
                .padding(.top,30)
                
                //See all product
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("See more")
                    }
                    .font(.custom("", size: 15).bold())
                    .foregroundColor(Color.orange)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top,10)
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("mainColor"))
        //updating filtered list
        .onChange(of: homeData.productType) { newValue in
            homeData.filterProductByType()
        }
        
        //Preview issue
        .sheet(isPresented: $homeData.showMoreProductsOnType) {
            
        } content: {
            MoreProductsView()
        }
        
        //Displaying Search View
        .overlay(
            
            ZStack{
                
                if homeData.searchActivated {
                    SearchView(animation: animation)
                        .environmentObject(homeData)
                }
            }
        )
    }
    
    @ViewBuilder
    func SearchBar()-> some View{
        
        HStack(spacing:15) {
            
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            Capsule().strokeBorder(Color.gray, lineWidth: 0.8)
        )
    }
    
    @ViewBuilder
    func ProductCardView(product: Product)-> some View {
        
        VStack(spacing:10){
            
                ZStack {
                    
                    if sharedData.showDetailProduct{
                        Image(product.productImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(0)
                    } else {
                        Image(product.productImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                    }
                }
                .frame(width: getRect().width / 2.5, height: getRect().height / 4.1)
                .cornerRadius(150)
                .offset(y: -80)
                .padding(.bottom, -80)
            
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
        //showing product detail
        .onTapGesture {
            
            withAnimation(.easeInOut){
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
    
    @ViewBuilder
    func ProductTypeView(type:ProductType)->some View {
        
        Button {
            //Updating Current Type
            withAnimation{
                homeData.productType = type
            }
        } label: {
            
            Text(type.rawValue)
                .font(.custom("", size: 15))
                .fontWeight(.semibold)
                .foregroundColor(homeData.productType == type ? Color.orange : Color.gray)
                .padding(.bottom,10)
            //Adding indecator at bottom
                .overlay(
                    
                    //Adding Geometry effects
                    ZStack{
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color.orange)
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        } else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                    , alignment: .bottom
                )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

