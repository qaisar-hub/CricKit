//
//  UserProfilePage.swift
//  Crickit_iOSAthon
//
//  Created by ephrim.daniel on 08/08/23.
//

import SwiftUI

struct UserProfilePage: View {
    
    @State var name: String = "Hello"
    
    var body: some View {
        
        VStack {
            Text(name)
            myButton(action: {
                //updateText()
            })
        }
    }
    
    func updateText() {
        self.name = "Hiiii"
    }
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        UserProfilePage()
    }
}


struct myButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button {
            let a = UserProfilePage()
            a.updateText()
        } label: {
            Text("changetText")
        }
    }
}
