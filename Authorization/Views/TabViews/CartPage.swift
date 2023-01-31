//
//  CartPage.swift
//  Nike
//
//  Created by Dauren Sarsenov on 27.01.2023.
//

import SwiftUI

struct CartPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var cartManager: CartManager
    @State var showDeleteOption: Bool = false
    var body: some View {
        
        
        NavigationView{
            
            VStack (spacing: 10) {
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    VStack{
                        
                        HStack{
                            
                            Text("Basket")
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
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)
                        }
                            
                            if sharedData.cartProducts.isEmpty {
                                
                                Group {
                                    
                                    Image("NoBasket") //need image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding()
                                        .padding(.top,35)
                                    
                                    Text("No Items added")
                                        .font(.custom("", size: 25))
                                        .fontWeight(.semibold)
                                    
                                    Text("Hit the plus button to save into basket.")
                                        .font(.custom("", size: 18))
                                        .foregroundColor(.gray)
                                        .padding(.horizontal)
                                        .padding(.top, 10)
                                        .multilineTextAlignment(.center)
                                }
                            } else {
                                
                                VStack(spacing:15) {
                                    
                                    ForEach($sharedData.cartProducts){ $product in
                                        
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
                                            
                                            CardView(product: $product)
                                        }
                                    }
                                }
                                .padding(.top,25)
                                .padding(.horizontal)
                            }
                            
                        }
                    .padding()
                }
                    
                    if !sharedData.cartProducts.isEmpty{
                        
                        Group {
                            
                            HStack{
                                
                                Text("Total")
                                    .font(.custom("", size: 14))
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Text(sharedData.getTotalPrice())
                                    .font(.custom("", size: 18).bold())
                                    .foregroundColor(Color.orange)
                            }
                            
                            PaymentButton(action: cartManager.pay)
                                .padding(.vertical)
                            
                            //                        Button {
                            //
                            //                        } label: {
                            //                            Text("Checkout")
                            //                                .font(.custom("", size: 18).bold())
                            //                                .foregroundColor(.white)
                            //                               s .padding(.vertical, 18)
                            //                                .frame(maxWidth: .infinity)
                            //                                .background(Color.orange)
                            //                                .cornerRadius(15)
                            //                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                            //                        }
                            //                        .padding(.vertical)
                        }
                        .padding(.horizontal, 25)
                    }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("mainColor").ignoresSafeArea()) //change color
            .onDisappear{
                if cartManager.paymentSuccess {
                    cartManager.paymentSuccess = false
                }
            }
        }
    }
    
    func deleteProduct(product: Product){
        
        if let index = sharedData.cartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
            
            let _ = withAnimation{
                sharedData.cartProducts.remove(at: index);
            }
        }
    }
}

struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
            .environmentObject(SharedDataModel())
            .environmentObject(CartManager())
    }
}

struct CardView: View{
    @EnvironmentObject var sharedData: SharedDataModel
    @Binding var product: Product
    var body: some View{
        
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
                
                HStack(spacing: 10){
                    
                    Text("Quantity")
                        .font(.custom("", size: 14))
                        .foregroundColor(.gray)
                    
                    Button {
                        product.quantity -= (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.primary)
                            .cornerRadius(4)
                    }
                    
                    Text("\(product.quantity)")
                        .font(.custom("", size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Button {
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.primary)
                            .cornerRadius(4)
                    }
                }
            }
            .padding(.horizontal, 10)
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
}
