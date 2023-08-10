//
//  test.swift
//  Crickit_iOSAthon
//
//  Created by ephrim.daniel on 25/07/23.
//

import SwiftUI

struct test: View {
    var body: some View {
        VStack {
            CardView(width: 140, height: 200)
                .clipShape(MyCard())
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                RecentMatches()
            }
            
        }
    }
}

struct customTabBars: View {
    
    let tabs = ["Home", "Shop", "Live"]
    
    @State var selectedIndex = 0
    
    var body: some View{
        VStack {
            
            switch selectedIndex {
            case 0:
                HomePage()
            case 1:
                ShopPage()
            default:
                AboutPage()
            }
            HStack {
                
                ForEach(tabs.indices, id: \.self) { index in
                    Button(action: {
                        self.selectedIndex = index
                    }){
                        myLabel(itemName: tabs[index], foregroundColor: .blue)
                    }
                }
            }
        }
    }
}


struct myLabel: View {
    var itemName: String
    var foregroundColor: Color
    var body: some View{
        Text(itemName)
            .padding()
            .foregroundColor(foregroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}


struct MyCard : Shape {
    func path(in rect : CGRect ) -> Path {
        var path = Path()
        // 1
//        path.move(
//            to: CGPoint(
//                x: 0 * width,
//                y: 0 * height
//            )
//        )
//
//        path.move(
//            to: CGPoint(
//                x: 1 * width,
//                y: 0 * height
//            )
//        )
//        // 2
//        path.addLine(
//            to: CGPoint(
//                x: 1 * width,
//                y: 1 * height)
//        )
//
//        path.addLine(
//            to: CGPoint(
//                x: 0 * width,
//                y: 1 * height)
//        )
        
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + 18))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 18))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

            //    return path
        
        return path
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        customTabBars()
    }
}
