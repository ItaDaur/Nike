//
//  MainView.swift
//  Nike
//
//  Created by Dauren Sarsenov on 27.01.2023.
//

import SwiftUI

struct MainView: View {
    
    @State var currentTab: Tab = .Home
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    @StateObject var cartManager = CartManager()
    @Namespace var animation
    
    //Hiding Tabview
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            
            TabView(selection: $currentTab) {
                
                HomeTab(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                LikedPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Liked)
                ProfilePage().tag(Tab.Profile)
                CartPage()
                    .environmentObject(sharedData)
                    .environmentObject(cartManager)
                    .tag(Tab.Cart)
            }
            
            //Custom tabview
            HStack(spacing: 0){
                ForEach(Tab.allCases, id: \.self){ tab in
                    
                    Button {
                        //updating tab
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                        //Applying little shadow at bg
                            .background(
                                Color.orange
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 0 : 1)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ?
                                             Color.orange : Color.black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
        }
        .background(Color("mainColor").ignoresSafeArea())
        .overlay(
            
            ZStack{
                
                if let product = sharedData.detailProduct, sharedData.showDetailProduct{
                    
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)
                        .environmentObject(cartManager)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//Making case iterable...
//Tab cases
enum Tab: String, CaseIterable {
    
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
}

extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
