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

struct CricketNews: View {
    var newsModel: [NewsModel]
    var body: some View {
        VStack(spacing: 20) {
            ForEach(newsModel) { news in
                NavigationLink(destination: NewsDetail(news: news)) {
                    NewsCard(news: news)
                }
            }
        }
    }
}



struct NewsCard: View {
    var news: NewsModel
    @EnvironmentObject private var appSettings: AppSettings
    
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
                    .foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                    .padding(.bottom, 5)
                Text(news.subheader)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                    .padding(.bottom, 5)
                NavigationLink(destination: NewsDetail(news: news)) {
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
        .background(BlurManagerData.blurMaterial(colorScheme: appSettings.isDarkMode ? .dark : .light))
        .cornerRadius(10)
    }
}

struct NewsDetail: View {
    var news: NewsModel
    @EnvironmentObject private var appSettings: AppSettings
    
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
                                .font(.subheadline)
								.foregroundStyle(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                                .padding(25)
                        }
                    }
                    Text(news.subheader)
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
        CricketNews(newsModel: [NewsModel(imageName: "playerVirat", header: "Virat Kohli's toughness of mind makes a huge difference: Ravi Shastri to India Today", subheader: "Virat Kohli's rampaging run in the South Africa series cemented his place as one of the best players of the modern era, not just in one-day cricket but across all formats.India's tour of South Africa was going to be Kohli's biggest challenge till now as captain and as a batsman and he passed both those tests with flying colours. Kohli amassed 871 runs on the tour and finished as the highest run-getter in the Test and ODI series with 286 and 558 runs respectively.")])
    }
}

