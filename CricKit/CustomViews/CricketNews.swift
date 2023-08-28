//
//  CricketNews.swift
//  CricKit
//
//  Created by Qaisar Raza on 28/08/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            DispatchQueue.main.async {
                uiView.load(request)
            }
        }
    }
}

struct NewsItem: Identifiable {
    var id = UUID()
    var imageName: String
    var header: String
    var subheader: String
    var url: String
}

struct CricketNews: View {
    var newsList: [NewsItem] = [
        NewsItem(imageName: "playerVirat", header: "Virat Kohli's toughness of mind makes a huge difference: Ravi Shastri to India Today", subheader: "Virat Kohli's rampaging run in the South Africa series cemented his place as one of the best players of the modern era, not just in one-day cricket but across all formats.India's tour of South Africa was going to be Kohli's biggest challenge till now as captain and as a batsman and he passed both those tests with flying colours. Kohli amassed 871 runs on the tour and finished as the highest run-getter in the Test and ODI series with 286 and 558 runs respectively.", url: "https://www.indiatoday.in/sports/cricket/story/virat-kohli-s-toughness-of-mind-makes-a-huge-difference-ravi-shastri-to-india-today-1180738-2018-03-02"),
        NewsItem(imageName: "playerRizwan", header: "Asia Cup 2023: Before India vs Pakistan match, Mohammad Rizwan predicts who'll win, ‘The way to differentiate between…’", subheader: "In the forthcoming Asia Cup 2023, the spotlight is turning towards the much-anticipated clash between arch-rivals India and Pakistan. The cricketing world awaits with bated breath for this encounter, which has often been dubbed as one of the greatest rivalries in the sport.", url: "https://www.indiatoday.in/sports/cricket/story/virat-kohli-s-toughness-of-mind-makes-a-huge-difference-ravi-shastri-to-india-today-1180738-2018-03-02")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(newsList) { news in
                NavigationLink(destination: WebView(urlString: news.url)) {
                    NewsCard(news: news)
                }
            }
        }
    }
}



struct NewsCard: View {
    var news: NewsItem
    
    var body: some View {
        HStack(spacing: 10) {
            Image(news.imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(news.header)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 5)
                Text(news.subheader)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 5)
                NavigationLink(destination: WebView(urlString: news.url)) { 
                    HStack {
                        Text("Read More")
                            .font(.caption)
                            .foregroundColor(.blue)
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        .frame(height: 150)
        .padding(10)
        .background(Blur(style: .systemChromeMaterialDark))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct NewsDetail: View {
    var news: NewsItem
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        Image(news.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                        VStack {
                            Spacer()
                            Text(news.header)
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(25)
                                .background(Color.black.opacity(0.5))
                            
                        }
                    }
                    Text(news.header)
                        .padding()
                }
                .frame(width: UIScreen.main.bounds.width)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton()
                }
            })
        }
    }
}

struct CricketNews_Previews: PreviewProvider {
    static var previews: some View {
        CricketNews()
    }
}

