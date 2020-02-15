//
//  ContentView.swift
//  bootcamp
//
//  Created by Jangkung Ari on 14/02/20.
//  Copyright © 2020 Jangkung Ari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let colorbg = UIColor(rgb: 0x081C24)
    let coloracc = UIColor(rgb: 0x01d277)
    let colortab = UIColor(rgb: 0xF0F0F0)
    let aColor = UIColor(named: "customControlColor")
    @State private var selection = 0

    init() {
//        UITabBar.appearance().barTintColor = colortab
        
       
    }
    var body: some View {
    
//
        ZStack{
//            Color.init(aColor!)
//                .edgesIgnoringSafeArea(.top)
            TabView(selection: $selection){
             ZStack {

                 VStack(spacing: 20) {
                     
                     Image("landscape-tmdb")
                         .resizable()
                         .frame(width: 135.0, height: 50.0) //that is not the solution to change image size
                         .padding()
                     Text("TabView")
                         .font(.largeTitle).foregroundColor(.white)
                     Text("TabItem Colors")

                         .font(.title).foregroundColor(.gray)

                     Text("Set the color of the active tab item by setting the accent color for the TabView.")

                         .frame(minWidth: 0, maxWidth: .infinity).padding()

                         .background(Color.blue).foregroundColor(Color.white)

                         .font(.title)

                 }

             }
                 .tabItem{
                         VStack {
                             Image(systemName: "house.fill")
                             Text("Home")
                         }
                 }
                 .tag(0)
             
             ZStack{

                 VStack{
                     Text("Popular")
                         .foregroundColor(.white)
                     .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                     .font(.title)
                     .italic()
                     }
                 }
                 .tabItem{
                         VStack{
                             Image(systemName: "flame.fill")
                             Text("Popular")
                         }
                 }
                 .tag(1)
             
             ZStack{
                 VStack{
                     Text("Hello, World!")
                         .foregroundColor(Color.init(coloracc))
                     .font(.title)
                     .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                     .italic()
                 }
             }
             
                 
                 .tabItem{
                     VStack{
                         Image(systemName: "play.circle.fill")
                         Text("Popular")
                         }
                 }
                 .tag(2)
             
            }.accentColor(Color.init(coloracc))
           
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
