//
//  DetailView.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                RemoteImageView(remoteImage:
                                    RemoteImage(urlString: repository.owner.avatarUrl,
                                    placeholder: UIImage(systemName: "circle.fill")!))
                    .frame(width: 60, height: 60, alignment: .center)
                    .cornerRadius(8)
                    Text(repository.owner.login)
                        .font(.title)
            }
            
            Text(repository.name)
                .font(.title).bold()
            
            repository.description.map { Text($0) }
            
            HStack {
                if let homepage = repository.homepage, let url = URL(string: homepage) {
                    Image(systemName: "link")
                    Button("ホームページ") {
                        UIApplication.shared.open(url)
                    }
                }
            }.padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            
            HStack {
                if let htmlUrl = repository.htmlUrl, let url = URL(string: htmlUrl) {
                    Image(systemName: "link")
                    Button("ブラウザで開く") {
                        UIApplication.shared.open(url)
                    }
                }
            }.padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            
            HStack {
                Image(systemName: "star")
                Text("\(repository.stargazersCount) stars")
                Image(systemName: "tuningfork")
                Text("\(repository.forksCount) forks")
            }
        }.padding()
        .background(Color.white)
        .cornerRadius(8)
        .clipped()
        .shadow(color: .gray, radius: 4)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(repository: Repository.template)
    }
}
