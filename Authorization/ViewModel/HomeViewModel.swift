//
//  HomeViewModel.swift
//  Nike
//
//  Created by Dauren Sarsenov on 27.01.2023.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var productType: ProductType = .basketball
    
    @Published var products: [Product] = [
        Product(type: .basketball, title: "Nike Cosmic", subtitle: "Unity 2: Purple", price: 160,
                productImage: "cosmic", describe: "Celebrate the love and joy of the game with the Nike Cosmic Unity 2. It is made of at least 20% recycled material and offers improved responsiveness and support. "),
        Product(type: .jordan1, title: "Jordan Luka", subtitle: "Luka 1: Blue", price: 110,
                productImage: "doncic", describe: "Designed for #77 and made for every athlete craving speed and efficiency, Luka's debut delivers the goods. The first shoe with full-length Formula 23 foam, it has an ultra-supportive fit crafted with the step-back in mind."),
        Product(type: .winter1, title: "Nike Court Vision", subtitle: "Mid Winter: Brown", price: 90,
                productImage: "winter", describe: "Updated traction pattern. Durable materials. Metal details. Check, check, check. With these basketball-inspired shoes from the 80s you bring your retro basketball vibes into the winter."),
        Product(type: .running1, title: "Nike Alphafly", subtitle: "Alphafly 2: Green", price: 320,
                productImage: "alphafly", describe: "Already with the first steps in the Nike Alphafly 2 you will feel the difference to your previous favorite shoes for competitions. With these rockets you can improve your personal records by precious seconds or minutes, without having to give up the base that your foot needs to run the track."),
        Product(type: .football, title: "Nike Zoom Mercurial", subtitle: "Mercurial Superfly 9 Elite FG: White", price: 280, productImage: "mercurial", describe: "With the eye-catching design of the Superfly 9 Elite FG, you immediately dominate the playing field. We have added a Zoom Air element specially designed for football, as well as a grippy structure at the top for an excellent ball feeling, so that you can give it your all in the post-game minutes."),
        Product(type: .lifestyle, title: "Nike Air Force 1", subtitle: "Air Force 1 Retro: White", price: 150,
                productImage: "airForce", describe: "The original point maker, who became a streetwear king, is celebrating his 40th anniversary. With everything you know best: sewn covers, supple leather and a perfect basketball style."),
        ///
        Product(type: .basketball, title: "Nike LeBron", subtitle: "Witness 7: Black", price: 115,
                productImage: "lebron", describe: "The longer LeBron's legendary career continues, the more his game needs a design that does not weigh him down, but still can control all this sublime power. That's how we came up with our lightest LeBron model, but with the kind of hold you use to stay in the game ahead of your opponents."),
        Product(type: .jordan1, title: "Jordan Air", subtitle: "XXXVI Low: Red", price: 175,
                productImage: "tatum", describe: "Get the energy that started a basketball revolution. The AJ XXXVI is one of the lightest Air Jordan gaming shoes to date and impresses with a minimalist but durable upper material with a reinforced coating."),
        Product(type: .winter1, title: "Nike City Classic", subtitle: "City Classic: Brown", price: 120,
                productImage: "cityC", describe: "Are you ready for winter matinés and hut excursions? Get started with the City Classic Boots. The narrow toe area and the shaped, shoe collar have been specially developed for feet with a low profile and ensure flexibility and comfort."),
        Product(type: .running1, title: "Nike Zegama", subtitle: "Zegama: Black", price: 160,
                productImage: "zegama", describe: "The Nike Zegama was designed for all ups and downs on uncompromising terrain. It is made with excellent grip and stability and provides protection so that you can climb further and reach greater personal heights when it's rough."),
        Product(type: .football, title: "Nike Phantom GX", subtitle: "GX Academy Dynamic Fit MG: Black", price: 95, productImage: "phantom", describe: "With NikeSkin and a mesh touch zone for improved precision, as well as a maneuverability sole designed for running and sprinting, you can express your spontaneous playmaking spirit. This version has a Dynamic Fit collar that wraps the ankle with soft, elastic material and ensures a secure fit."),
        Product(type: .lifestyle, title: "Nike Dunk Low", subtitle: "Dunk Low Retro: Black & Red", price: 110,
                productImage: "dunkLow", describe: "The basketball classic of the 80s was developed for the indoor parquet and returns with classic details and retro basketball style. The padded, low-cut shoe collar impresses with vintage style and ensures a retro look and modern comfort.")
    ]
    
    //Filtered products
    @Published var filteredProducts: [Product] = []
    
    //More products on the type
    @Published var showMoreProductsOnType: Bool = false
    
    //Search Data
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init () {
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != ""{
                    self.filterProductBySearch()
                } else {
                    self.searchedProducts = nil
                }
            })
    }

    func filterProductByType(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            //since it will require more memory so were using lazy to perform more
                .lazy
                .filter{ product in
                    
                    return product.type == self.productType
                }
            //Limited result
                .prefix(4)
            
            DispatchQueue.main.async {
                
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            //since it will require more memory so were using lazy to perform more
                .lazy
                .filter{ product in
                    
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
}

