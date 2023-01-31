//
//  ProductDetailView.swift
//  Nike
//
//  Created by Dauren Sarsenov on 27.01.2023.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product: Product
    @EnvironmentObject var sharedData: SharedDataModel
    var animation: Namespace.ID
    @EnvironmentObject var homeData: HomeViewModel
    @EnvironmentObject var cartManager: CartManager
    @State var currentIndex: Int = 0
    @State var posts: [Carou] = []
    
    var body: some View {
        
        VStack{
            //title bar and product image
            VStack{
                
                //title bar
                HStack{
                    
                    Button {
                        //closing view
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red :
                                Color.black.opacity(0.7))
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                
                //Product Image
                
                //Snap Carousel
                SnapCarousel(spacing:50,index: $currentIndex, items: posts) { post in
                    
                    GeometryReader{ proxy in
                        
                        let size = proxy.size
                        
                        Image(post.postImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(y:-50)
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .frame(width: size.width)
                    }
                }
                .padding(.vertical, 10)
                
                HStack(spacing: 10){
                    
                    ForEach(posts.indices, id: \.self) { index in
                        
                        Circle()
                            .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                            .frame(width: 10, height: 10)
                            .scaleEffect(currentIndex == index ? 1.4 : 1)
                            .animation(.spring(), value: currentIndex == index)
                    }
                }
                .padding(.bottom, 13)
                
//                Image(product.productImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
//                    .padding(.horizontal)
//                    .offset(y:-12)
//                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(-1)
            
            //product details
            ScrollView(.vertical, showsIndicators: false){
                //product data
                VStack(alignment: .leading, spacing: 15) {
                    Text(product.title)
                        .font(.custom("", size: 20).bold())
                    
                    Text(product.subtitle)
                        .font(.custom("", size: 18))
                        .foregroundColor(.gray)
                    
                    Text("Sustainable materials")
                        .font(.custom("", size: 16).bold())
                        .padding(.top)
                    
                    Text(product.describe)
                        .font(.custom("", size: 15))
                        .foregroundColor(.gray)
                    
                    Button {
                        
                    } label: {
                        
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.custom("", size: 15).bold())
                        .foregroundColor(Color.orange)
                    }
                    
                    HStack {
                        
                        Text("Total")
                            .font(.custom("", size: 17))
                        
                        Spacer()
                        
                        Text("$\(product.price)")
                            .font(.custom("", size: 20).bold())
                            .foregroundColor(Color.orange)
                    }
                    .padding(.vertical, 20)
                    
                    Button {
                        addToCart()
                        cartManager.addToCart(product: product)
                        
                    } label: {
                        Text("\(isAddedToCart() ? "added" : "add") to basket")
                            .font(.custom("", size: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.orange
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.6), radius: 5,x:5, y: 5)
                            )
                    }
                }
                .padding([.horizontal, .bottom])
                .padding(.top,25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedData.likedProducts)
        .animation(.easeInOut, value: sharedData.cartProducts)
        .background(
            Color("mainColor").ignoresSafeArea() //change color
        )
        .onAppear{
            for index in 1...9{
                posts.append(Carou(postImage: "\(product.productImage)\(index)"))
            }
        }
    }
    
    func isLiked()->Bool {
        
        return sharedData.likedProducts.contains{ product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart()->Bool {
        
        return sharedData.cartProducts.contains{ product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked(){
        
        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }) {
            sharedData.likedProducts.remove(at: index)
        } else {
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToCart(){
        
        if let index = sharedData.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }) {
            sharedData.cartProducts.remove(at: index)
        } else {
            sharedData.cartProducts.append(product)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        ProductDetailView(product: HomeViewModel().products[0])
//            .environmentObject(SharedDataModel())
        MainView()
    }
}
