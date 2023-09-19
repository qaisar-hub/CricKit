import SwiftUI
import TipKit

struct LiveScoreTip: Tip {
    
    var imageName: String
    var header: String
    var desc: String
    
    // Set Image Icon
    var image: Image? {
        Image(systemName: imageName) //TODO: not showing need to debug
    }
    // Set Title
    var title: Text {
        Text(header)
            .foregroundStyle(ColorManager.appPrimaryColor())
    }
    // Set Message to explain details
    var message: Text? {
        Text(desc)
    }
}

struct FavoriteTeamTip: Tip {
    
    var imageName: String
    var header: String
    var desc: String
    
    // Set Image Icon
    var image: Image? {
        Image(systemName: imageName) //TODO: not showing need to debug
    }
    // Set Title
    var title: Text {
        Text(header)
            .foregroundStyle(ColorManager.appPrimaryColor())
    }
    // Set Message to explain details
    var message: Text? {
        Text(desc)
    }
}
