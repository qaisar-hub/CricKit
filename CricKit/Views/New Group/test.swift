//
//  test.swift
//  CricKit
//
//  Created by ephrim.daniel on 25/07/23.
//

import SwiftUI

struct test: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack {
                    CardView(width: 140, height: 200)
                    .background(Color.black)
                    .clipShape(MyCard())
            }
        }
    }
}

struct BackgroundCard : Shape {
    func path(in rect : CGRect ) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY - 100))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY - 100))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY - ( UIScreen.main.bounds.width)))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
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
                LiveMatches()
            default:
                UserProfilePage()
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
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + 18))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 18))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}

struct LiveMatchCard : Shape {
    func path(in rect : CGRect ) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 30))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}



struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
