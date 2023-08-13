//
//  customTabBar.swift
//  Crickit_iOSAthon
//
//  Created by ephrim.daniel on 08/08/23.
//

import SwiftUI

struct customTabBar: View {
    
    let tabs = ["Home", "Shop", "My Profile"]
    
    @Binding var selectedIndex: Int
    
    
    var body: some View{
        HStack {
            
            ForEach(tabs.indices, id: \.self) { index in
                Button(action: {
                    print("<<< selectedIndex")
                    selectedIndex = index
                }){
                    myLabel(itemName: tabs[index], foregroundColor: .blue)
                }
            }
        }
    }
}

struct customTabBar_Previews: PreviewProvider {
    static var previews: some View {
        customTabBar(selectedIndex: .constant(0))
    }
}
