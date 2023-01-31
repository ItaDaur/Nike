//
//  ProfilePage.swift
//  Nike
//
//  Created by Dauren Sarsenov on 27.01.2023.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    Text("My Profile")
                        .font(.custom("", size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack (spacing: 15) {
                        
                        Image("Profile_Image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        
                        Text("Kiyotaka Ayanokoji")
                            .font(.custom("", size: 16))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                            
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray) // change color
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Address: 43 Oxford Road\nM13 4GR\nManchester, UK")
                                .font(.custom("", size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        Color.white.cornerRadius(12)
                    )
                    .padding()
                    .padding(.top,40)
                    
                    //Custom Navigation Links
                    CustomNavigationLink(title: "API") {
                        
                        API()
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("mainColor").ignoresSafeArea() // change color
                            )
                    }
                    
                    CustomNavigationLink(title: "Shopping addresses") {
                        
                        MapKit()
                            .navigationTitle("Shopping address")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("mainColor").ignoresSafeArea() // change color
                            )
                    }
                    
                    CustomNavigationLink(title: "History") {
                        
                        VStack {
                            ScrollView(.vertical, showsIndicators: false) {
                                
                                Text("Nike, Inc., formerly (1964–78) Blue Ribbon Sports, American sportswear company headquartered in Beaverton, Oregon. It was founded in 1964 as Blue Ribbon Sports by Bill Bowerman, a track-and-field coach at the University of Oregon, and his former student Phil Knight. They opened their first retail outlet in 1966 and launched the Nike brand shoe in 1972. The company was renamed Nike, Inc., in 1978 and went public two years later. By the early 21st century, Nike had retail outlets and distributors in more than 170 countries, and its logo—a curved check mark called the “swoosh”—was recognized throughout the world. \nFrom the late 1980s Nike steadily expanded its business and diversified its product line through numerous acquisitions, including the shoe companies Cole Haan (1988; sold in 2012) and Converse, Inc. (2003), the sports-equipment producer Canstar Sports, Inc. (1994; later called Bauer and sold in 2008), and the athletic apparel and equipment company Umbro (2008; sold in 2012). In 1996 the company created Nike ACG (“all-conditions gear”), which markets products for extreme sports such as snowboarding and mountain biking. In the early 21st century Nike began selling sports-technology accessories, including portable heart-rate monitors and high-altitude wrist compasses. \nPart of Nike’s success is owed to endorsements by such athletes as Michael Jordan, Mia Hamm, Roger Federer, and Tiger Woods. The NikeTown chain stores, the first of which opened in 1990, pay tribute to these and other company spokespersons while offering consumers a full range of Nike products. In the 1990s the company’s image briefly suffered from revelations about poor working conditions in its overseas factories.")
                            }
                                .frame(alignment: .trailing)
                                .navigationTitle("History")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(
                                    Color("mainColor").ignoresSafeArea() // change color
                                )
                                .padding()
                            .padding(.vertical, 5)
                        }
                        .background(
                            Color("mainColor").ignoresSafeArea() // change color
                        )
                    }
                    
                    CustomNavigationLink(title: "About us") {
                        
                            VStack {
                                
                                HStack(spacing: 20) {
                                    
                                    VStack(spacing:20) {
                                        
                                        Text("Dosmailov Temirlan")
                                        
                                        Text("Mobile Dev")
                                        
                                        Link("LinkedIn",
                                              destination: URL(string: "https://www.linkedin.com/in/temirlan-dosmailov-5358b6236")!)
                                    }
                                    
                                    Image("Timafei")
                                        .resizable()
                                        .cornerRadius(30)
                                        .aspectRatio(contentMode: .fit)
                                }
                                .padding()
                                
                                HStack(spacing: 20) {
                                    
                                    VStack(spacing:20) {
                                        
                                        Text("Sarsenov Dauren")
                                        
                                        Text("Mobile Dev")
                                        
                                        Link("LinkedIn",
                                              destination: URL(string: "https://www.linkedin.com/in/dauren-sarsenov-7b413a240/")!)
                                    }
                                    
                                    Image("Daur")
                                        .resizable()
                                        .cornerRadius(30)
                                        .aspectRatio(contentMode: .fit)
                                }
                                .padding()
                                
                            }
                            .navigationTitle("About us")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("mainColor").ignoresSafeArea() // change color
                            )
                    }
                    
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("mainColor").ignoresSafeArea() // change color
            )
        }
    }
    
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping ()->Detail) -> some View {
        
        NavigationLink {
            content()
        } label: {
            
            HStack{
                
                Text(title)
                    .font(.custom("", size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color.white.cornerRadius(12) // change color
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
