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
    
    @Published var balance: BigUInt = 0
    @Published var nfts: [Opensea.NFT] = []
    @Published var isLoadingNFTs: Bool = false
    
    private var cancellables: [AnyCancellable] = []
    
    private let address = EthereumAddress(hexString: "0x85fD692D2a075908079261F5E351e7fE0267dB02")!
    @Published var nftCursor: String?
    
    init() {
        Task {
            await Web3Actor.shared.initialize(.EthereumGoerli, openseaApiKey: "c823fdee93814f7abd5492604697e9c8")
            await Web3Actor.shared.$nfts.sink(receiveValue: { nfts in
                DispatchQueue.main.async {
                    self.nfts = nfts
                }
            }).store(in: &cancellables)
            
            getBalance()
            getNfts()
        }
    }
    
    public func getBalance() {
        Task {
            do {
                let balance = try await Web3Actor.shared.getBalance(of: address).quantity
                DispatchQueue.main.async {
                    self.balance = balance
                }
            } catch {
                print("::: error occurred getting balance:", error)
            }
        }
    }
    
    public func reset() {
        Task {
            await Web3Actor.shared.resetNFTs()
            DispatchQueue.main.async {
                self.nftCursor = nil
            }
        }
    }
    
    public func getNfts() {
        guard nftCursor != nil || nfts.isEmpty, !isLoadingNFTs else { return }
        isLoadingNFTs = true
        Task {
            do {
                let cursor = try await Web3Actor.shared.getNFTs(of: address, nextCursor: nftCursor)
                DispatchQueue.main.async {
                    self.nftCursor = cursor
                    self.isLoadingNFTs = false
                }
            } catch {
                print("::: error occurred fetching NFTs with cursor \(nftCursor ?? "nil"):", error)
                DispatchQueue.main.async {
                    self.isLoadingNFTs = false
                }
            }
        }
    }
}
