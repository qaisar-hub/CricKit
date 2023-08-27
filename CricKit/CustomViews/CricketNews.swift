//
//  CricketNews.swift
//  CricKit
//
//  Created by Qaisar Raza on 28/08/23.
//

import SwiftUI

struct NewsItem: Identifiable {
    var id = UUID()
    var imageName: String
    var header: String
    var subheader: String
}

struct CricketNews: View {
    var newsList: [NewsItem] = [
        NewsItem(imageName: "playerVirat", header: "Virat Kohli can make a telling difference for India in the World Cup: Curtly Ambrose", subheader: "NEW DELHI: West Indies legend Curtly Ambrose, a renowned fasI have seen Virat for several years now and I do not need to ...")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(newsList) { news in
                NavigationLink(destination: NewsDetail(news: news)) {
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
                    .lineLimit(1)
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 5)
                Text(news.subheader)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(Color.white)
                NavigationLink(destination: NewsDetail(news: news)) {
                    HStack {
                        Spacer()
                        Text("...Read More")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
            }
            Spacer()
        }
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

