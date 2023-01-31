//
//  LikedPage.swift
//  Nike
//
//  Created by Dauren Sarsenov on 27.01.2023.
//

import SwiftUI

struct LikedPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    @State var showDeleteOption: Bool = false
    var body: some View {
        
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false){
                
                VStack{
                    
                    HStack{
                        
                        Text("Favourites")
                            .font(.custom("", size: 28).bold())
                        
                        Spacer()
                        
                        Button {
                            withAnimation{
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image(systemName: "trash.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.red)
                        }
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)
                    }
                    
                    if sharedData.likedProducts.isEmpty {
                        
                        Group {
                            
                            Image("NoLiked") //need image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top,35)
                            
                            Text("No favourites yet")
                                .font(.custom("", size: 25))
                                .fontWeight(.semibold)
                            
                            Text("Hit the like button on each product page to save favourite ones.")
                                .font(.custom("", size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        
                        VStack(spacing:15) {
                            
                            ForEach(sharedData.likedProducts){ product in
                                
                                HStack(spacing:0){
                                    
                                    if showDeleteOption {
                                        
                                        Button {
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                    }
                                    
                                    CardView(product: product)
                                }
                            }
                        }
                        .padding(.top,25)
                        .padding(.horizontal)
                    }
                    
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("mainColor").ignoresSafeArea()) //change color
        }
    }
    
    @ViewBuilder
    func CardView(product: Product)->some View{
        
        HStack(spacing:15){
            
            if sharedData.showDetailProduct{
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(100)
            } else {
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(100)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(product.title)
                    .font(.custom("", size: 18).bold())
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.custom("", size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.orange)
                
                Text("Type: \(product.type.rawValue)")
                    .font(.custom("", size: 13))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white.cornerRadius(10))
        }
        .onTapGesture {
            
            withAnimation(.easeInOut){
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
    
    func deleteProduct(product: Product){
        
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
            
            let _ = withAnimation{
                sharedData.likedProducts.remove(at: index);
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
