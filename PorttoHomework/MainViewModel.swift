//
//  MainViewModel.swift
//  PorttoHomework
//
//  Created by Shane Li on 2023/9/14.
//

import Foundation
import Web3Actor
import Web3

class MainViewModel: ObservableObject {
    
    private var cancellables: [AnyCancellable] = []
    
    private let address = EthereumAddress(hexString: "0x85fD692D2a075908079261F5E351e7fE0267dB02")!
    
    init() {
        Task {
            await Web3Actor.shared.initialize(.EthereumGoerli, openseaApiKey: "c823fdee93814f7abd5492604697e9c8")
        }
    }
}
