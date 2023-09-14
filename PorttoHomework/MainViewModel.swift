//
//  MainViewModel.swift
//  PorttoHomework
//
//  Created by Shane Li on 2023/9/14.
//

import Foundation
import Combine
import Web3Actor
import Web3

class MainViewModel: ObservableObject {
    
    @Published var nfts: [Opensea.NFT] = []
    
    private var cancellables: [AnyCancellable] = []
    
    private let address = EthereumAddress(hexString: "0x85fD692D2a075908079261F5E351e7fE0267dB02")!
    private var nftCursor: String?
    
    init() {
        Task {
            await Web3Actor.shared.initialize(.EthereumGoerli, openseaApiKey: "c823fdee93814f7abd5492604697e9c8")
            await Web3Actor.shared.$nfts.sink(receiveValue: { nfts in
                self.nfts = nfts
            }).store(in: &cancellables)
        }
    }
    
    public func getNfts() {
        Task {
            do {
                guard nfts.isEmpty || nftCursor != nil else { return }
                nftCursor = try await Web3Actor.shared.getNFTs(of: address, nextCursor: nftCursor)
            } catch {
                print("::: error occurred fetching NFTs with cursor \(nftCursor ?? "nil"):", error)
            }
        }
    }
}
