//
//  NFTDetailView.swift
//  PorttoHomework
//
//  Created by Shane Li on 2023/9/15.
//

import SwiftUI
import Web3Actor
import SDWebImageSwiftUI

struct NFTDetailView: View {
    let nft: Opensea.NFT
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 8) {
                    if let imageUrl = nft.imageUrl {
                        if imageUrl.hasSuffix(".svg") {
                            WebImage(url: URL(string: imageUrl))
                                .placeholder {
                                    ProgressView()
                                }
                                .resizable()
                                .scaledToFill()
                        } else {
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                    Text(nft.name)
                        .bold()
                    Text(nft.description)
                        .multilineTextAlignment(.leading)
                }
                .padding()
            }
            VStack {
                Spacer()
                Button {
                    // FIXME: there is no permalink in the API response
                    guard let url = try? nft.imageUrl?.asURL() else { return }
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Permalink")
                        Spacer()
                    }
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke()
                    }
                }
                .padding()
            }
        }
    }
}
