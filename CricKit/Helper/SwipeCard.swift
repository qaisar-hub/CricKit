import SwiftUI
import Shimmer

struct SwipeCard: View {
    @State private var cardOffsets: [CGFloat] = Array(repeating: 0, count: 4)
    @State private var cardDragStates: [CGSize] = Array(repeating: .zero, count: 4)
    @State private var animationAmount = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                ForEach(0..<4, id: \.self) { index in
                    CustomCardView()
                        .offset(x: cardOffsets[index] + cardDragStates[index].width, y: cardDragStates[index].height)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    cardDragStates[index] = value.translation
                                }
                                .onEnded { value in
                                    if abs(cardDragStates[index].width) > UIScreen.main.bounds.width * 0.4 {
                                        animationAmount += 1
                                        cardOffsets[index] = cardDragStates[index].width > 0 ? UIScreen.main.bounds.width : -UIScreen.main.bounds.width
                                    } else {
                                        cardDragStates[index] = .zero
                                    }
                                }
                        )
                }
            }
            
            Spacer()
        }
        .animation(.easeOut, value: animationAmount)
    }
}

struct CustomCardView: View {
    var body: some View {
        VStack {
            Text("Coming Soon...")
                .modifier(Shimmer())
                .font(.title)
                .foregroundColor(.white)
                .padding()
        }
        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.width * 0.5)
        .background(LinearGradient(gradient: Gradient(colors: [Color.appPrimary, Color.appBlacks]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(10)
        .rotation3DEffect(.degrees(10), axis: (x: 0, y: 5, z: 0))
        .shadow(color: Color.appBlacks, radius: 10)
    }
}

struct SwipeCard_Previews: PreviewProvider {
    static var previews: some View {
        SwipeCard()
    }
}
