//
//  DetailView.swift
//  Nike
//
//  Created by Dauren Sarsenov on 25.01.2023.
//

import SwiftUI

struct DetailView: View {
    @Binding var showDetail: Bool

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Man's Shoe")
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            Text("Nike Airmax Plus")
                                .bold()
                        }
                        Spacer()
                        Text("300$")
                            .bold()
                            .font(.system(size: 24))
                    }
                    .padding(.horizontal)
                    Text("Select Size")
                        .font(.caption)
                        .padding(.horizontal)
                    VStack(alignment: .center, spacing: 8.0) {
                        HStack(alignment: .center, spacing: 8.0) {
                            Text("UK 5.5")
                                .font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                            Text("UK 6 (EU 39)")
                                .font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                            Text("UK 6 (EU 40)")
                                .font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                        }

                        HStack(alignment: .center, spacing: 10.0) {
                            Text("UK 6.5")
                                .font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                            Text("UK 7")
                                .font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                            Text("UK 7.5")
                                .font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                                .opacity(0.2)
                        }


                        HStack(alignment: .center, spacing: 10.0) {
                            Text("UK 5.5")
                                .font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                            Text("UK 6 (EU 39)")
                                .font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                                .opacity(0.2)
                            Text("UK 6 (EU 40)")
                                .font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                        }

                    }
                    .padding(.leading, 30)

                    Button(action: {
                        //
                    }) {
                        Text("Add to bag")
                            .foregroundColor(.white)
                            .frame(width: 321, height: 44)
                            .background(Color(#colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0, alpha: 1)))
                            .cornerRadius(20)
                            .shadow(color: Color(#colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0, alpha: 1)).opacity(0.6), radius: 10, y: 10)
                            .padding(.leading, 30)

                    }

                }
                .padding(.top, 10)

                .frame(width: 383, height: 400)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)

            }



            Image(systemName: "xmark")
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
                .offset(x: 160, y: 15)
                .onTapGesture {
                    self.showDetail = false
            }

        }
    }
}


