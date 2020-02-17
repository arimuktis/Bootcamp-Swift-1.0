//
//  ContentView.swift
//  bootcamp
//
//  Created by Jangkung Ari on 14/02/20.
//  Copyright © 2020 Jangkung Ari. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject var obs = observer()
    
    let colorbg = UIColor(rgb: 0x081C24)
    let coloracc = UIColor(rgb: 0x01d277)
    let colortab = UIColor(rgb: 0x0C1519)
    let aColor = UIColor(named: "customControlColor")
    @State private var selection = 0

    init() {
        UITabBar.appearance().barTintColor = colorbg
        
        // NavBar
        UINavigationBar.appearance().backgroundColor = colorbg
        UINavigationBar.appearance().largeTitleTextAttributes = [
             .foregroundColor: coloracc]
//             .font : UIFont(name:"Papyrus", size: 40)!]
//        UINavigationBar.appearance().titleTextAttributes = [
//             .font : UIFont(name: "HelveticaNeue-Thin", size: 20)!]
    }
    
    
    var body: some View {

        ZStack{
            Color.init(colorbg)
                .edgesIgnoringSafeArea(.all)
            TabView(selection: $selection){
                VStack{
                        Image("landscape-tmdb")
                         .resizable()
                         .frame(width: 135.0, height: 50.0) //that is not the solution to change image size
                        .padding()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .scaledToFit()
                        Divider()
//                    .navigationBarItems(leading:
//                    HStack {
//                        Button(action: {}) {
//                            Image(systemName: "minus.square.fill")
//                                .font(.largeTitle)
//                        }.foregroundColor(.pink)
//                    }, trailing:
//                    HStack {
//                        Button(action: {}) {
//                            Image(systemName: "plus.square.fill")
//                                .font(.largeTitle)
//                        }.foregroundColor(.blue)
//                    })
                        ZStack() {
                            Color.init(colorbg)
                            .edgesIgnoringSafeArea(.all)
                           VStack(alignment: .center, spacing: 20) {
                                Text("TabView")
                                    .font(.largeTitle).foregroundColor(.white)
                                Text("TabItem Colors")

                                    .font(.title).foregroundColor(.gray)

                                Text("Set the color of the active tab item by setting the accent color for the TabView.")

                                    .frame(minWidth: 0, maxWidth: .infinity).padding() .background(Color.init(coloracc)).foregroundColor(Color.white)

                                    .font(.title)
                            }
                        }
                    
                }
                 .background(Color.init(colorbg))
                 .tabItem{
                         VStack {
                             Image(systemName: "house.fill")
                             Text("Home")
                         }
                 }
                 .tag(0)

             ZStack{
                Color.init(colorbg)
                    .edgesIgnoringSafeArea(.all)

                NavigationView{
                        ScrollView(.vertical){
                            VStack{
                            ForEach(obs.movieList) {i in
                            ListRow(url: i.poster_path, name: i.original_title, rating: i.vote_average, release_date: i.release_date)
                                }
                            }
                            .background(Color.init(colortab))
                        }
                        .navigationBarTitle("Popular")
                        .background(Color.init(colortab))
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
                Color.init(colorbg).edgesIgnoringSafeArea(.all)
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
                         Text("Now Playing")
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

class observer : ObservableObject{
    @Published var movieList = [modeldatatype]()
    
    init() {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=8897c211c4af54fb09ad89b42353a210&language=en-US&page=1"
        let sess = URLSession(configuration: .default)
        
        sess.dataTask(with: URL(string: url)!) { (data, _, _) in
            do{
                let fetch = try JSONDecoder().decode(datatype.self, from: data!)
                DispatchQueue.main.async {
                    self.movieList = fetch.results
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

struct datatype : Decodable{
    
    var results : [modeldatatype]
    
}

struct modeldatatype : Identifiable, Decodable {
    
    var id : Int
    var original_title : String
    var vote_average : CGFloat
    var poster_path : String
    var backdrop_path : String
    var overview : String
    var release_date : String
}

struct ListRow : View {
    
    var url = ""
    var name = ""
    var rating : CGFloat = 0
    var release_date = ""
    
    var body : some View{
        
        VStack{
            ZStack(alignment: .bottom){
                AnimatedImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(url)")).resizable().frame(width: 350, height: 200)
                
                VStack(alignment: .leading){
                    Text(name).fontWeight(.heavy).foregroundColor(.white)
                    .padding(.leading, 10)
//                    Text("Rating = \(rating)").foregroundColor(.white)
                    Divider().accentColor(.white)
                    HStack{
                        Text("Release date:").foregroundColor(.green)
                            .fontWeight(.light)
                        Text(release_date).lineLimit(2).foregroundColor(.green)
                    }
                    .padding(.leading, 10)
                }.background(Color.black.opacity(0.5))
                }.clipShape(RoundedRectangle(cornerRadius: 15.0)).frame(width: 350, height: 200)
            .padding(.top, 10)
            Divider()
        }
    }
}
