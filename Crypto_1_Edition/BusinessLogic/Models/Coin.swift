//
//  Coin.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 29.06.2023.
//

import Foundation

struct Coin: Identifiable, Codable {
    var id: String {
        return shortName
    }
    let name: String
    let shortName: String
    let url: URL
    let descriptions: String
    let foundersDescription: String

    init(name: String, shortName: String, url: URL, descriptions: String, foundersDescription: String) {
        self.name = name
        self.shortName = shortName
        self.url = url
        self.descriptions = descriptions
        self.foundersDescription = foundersDescription
    }

    init(databaseObject: Coinss) {
        self.name = databaseObject.name
        self.shortName = databaseObject.shortName
        self.url = databaseObject.url
        self.descriptions = databaseObject.descriptions
        self.foundersDescription = databaseObject.foundersDescription
    }
    
    init(databaseObject: MyCoins) {
        self.name = databaseObject.name
        self.shortName = databaseObject.shortName
        self.url = databaseObject.url
        self.descriptions = databaseObject.descriptions
        self.foundersDescription = databaseObject.foundersDescription
    }
    
}

extension Coin: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(shortName)
    }
}


extension Coin {
    static var coins: [Coin] {
        return [
            Coin(name: "Solana",
                 shortName: "SOL",
                 url: URL(string: "https://coinmarketcap.com/currencies/solana/#About")!,
                 descriptions: "Solana is a highly functional open source project that banks on blockchain technology’s permissionless nature to provide decentralized finance (DeFi) solutions. While the idea and initial work on the project began in 2017, Solana was officially launched in March 2020 by the Solana Foundation with headquarters in Geneva, Switzerland.",
                 foundersDescription: "Anatoly Yakovenko is the most important person behind Solana. His professional career started at Qualcomm, where he quickly moved up the ranks and became senior staff engineer manager in 2015. Later on, his professional path shifted, and Yakovenko entered a new position as a software engineer at Dropbox. In 2017, Yakovenko started working on a project which would later materialize as Solana. He teamed up with his Qualcomm colleague Greg Fitzgerald, and they founded a project called Solana Labs. Attracting several more former Qualcomm colleagues in the process, the Solana protocol and SOL token were released to the public in 2020."),
            Coin(name: "Ethereum",
                 shortName: "ETH",
                 url: URL(string: "https://coinmarketcap.com/currencies/ethereum/#About")!,
                 descriptions: "Ethereum is a decentralized open-source blockchain system that features its own cryptocurrency, Ether. ETH works as a platform for numerous other cryptocurrencies, as well as for the execution of decentralized smart contracts. Ethereum was first described in a 2013 whitepaper by Vitalik Buterin. Buterin, along with other co-founders, secured funding for the project in an online public crowd sale in the summer of 2014. The project team managed to raise $18.3 million in Bitcoin, and Ethereum’s price in the Initial Coin Offering (ICO) was $0.311, with over 60 million Ether sold. Taking Ethereum’s price now, this puts the return on investment (ROI) at an annualized rate of over 270%, essentially almost quadrupling your investment every year since the summer of 2014.",
                 foundersDescription: "Ethereum has a total of eight co-founders — an unusually large number for a crypto project. They first met on June 7, 2014, in Zug, Switzerland. Russian-Canadian Vitalik Buterin is perhaps the best known of the bunch. He authored the original white paper that first described Ethereum in 2013 and still works on improving the platform to this day. Prior to ETH, Buterin co-founded and wrote for the Bitcoin Magazine news website. British programmer Gavin Wood is arguably the second most important co-founder of ETH, as he coded the first technical implementation of Ethereum in the C++ programming language, proposed Ethereum’s native programming language Solidity and was the first chief technology officer of the Ethereum Foundation. Before Ethereum, Wood was a research scientist at Microsoft. Afterward, he moved on to establish the Web3 Foundation."),
            Coin(
                name: "Cardano",
                shortName: "ADA",
                url: URL(string: "https://coinmarketcap.com/currencies/cardano/#About")!,
                descriptions: "Cardano is a proof-of-stake blockchain platform that says its goal is to allow “changemakers, innovators and visionaries” to bring about positive global change. Cardano is used by agricultural companies to track fresh produce from field to fork, while other products built on the platform allow educational credentials to be stored in a tamper-proof way, and retailers to clamp down on counterfeit goods.",
                foundersDescription: "Cardano was founded by Charles Hoskinson, who was also one of the co-founders of the Ethereum network. He is the CEO of IOHK, the company that built Cardano’s blockchain."),
            Coin(
                name: "Cosmos",
                shortName: "ATOM",
                url: URL(string: "https://coinmarketcap.com/currencies/cosmos/#About")!,
                descriptions: "In a nutshell, Cosmos bills itself as a project that solves some of the “hardest problems” facing the blockchain industry. It aims to offer an antidote to “slow, expensive, unscalable and environmentally harmful” proof-of-work protocols, like those used by Bitcoin, by offering an ecosystem of connected blockchains. Cosmos’ origins can be dated back to 2014, when Tendermint, a core contributor to the network, was founded. In 2016, a white paper for Cosmos was published — and a token sale was held the following year. ATOM tokens are earned through a hybrid proof-of-stake algorithm, and they help to keep the Cosmos Hub, the project’s flagship blockchain, secure. This cryptocurrency also has a role in the network’s governance.",
                foundersDescription: "The co-founders of Tendermint — the gateway to the Cosmos ecosystem — were Jae Kwon, Zarko Milosevic and Ethan Buchman. Although Kwon is still listed as principal architect, he stepped down as CEO in 2020. He maintains he is still a part of the project but is mainly focusing on other initiatives. He has now been replaced as Tendermint’s CEO by Peng Zhong, and the whole board of directors was given quite a substantial refresh. Their goals include enhancing the experience for developers, creating an enthusiastic community for Cosmos and building educational resources so greater numbers of people are aware of what this network is capable of."),
            Coin(
                name: "ChainLink",
                shortName: "LINK",
                url: URL(string: "https://coinmarketcap.com/currencies/chainlink/#About")!,
                descriptions: "Founded in 2017, Chainlink is a blockchain abstraction layer that enables universally connected smart contracts. Through a decentralized oracle network, Chainlink allows blockchains to securely interact with external data feeds, events and payment methods, providing the critical off-chain information needed by complex smart contracts to become the dominant form of digital agreement. The Chainlink Network is driven by a large open-source community of data providers, node operators, smart contract developers, researchers, security auditors and more. The company focuses on ensuring that decentralized participation is guaranteed for all node operators and users looking to contribute to the network.",
                foundersDescription: "Sergey Nazarov is a co-founder and CEO at Chainlink Labs. He graduated with a degree in business administration from New York University, with a focus on philosophy and administration. His professional career began as a teaching fellow at NYU Stern School of Business. In 2009, Nazarov co-founded ExistLocal, a peer-to-peer marketplace for authentic local experiences. In 2014, he also co-founded CryptaMail, a completely decentralized, blockchain-based email service. In 2014, Nazarov teamed up with Steve Ellis and launched SmartContract, a platform that brings smart contracts to life by connecting them to external data and widely accepted bank payments. SmartContract was one of the entrepreneurial ventures that led Sergey Nazarov to the founding of Chainlink."),
            Coin(name: "Bitcoin",
                 shortName: "BTC",
                 url: URL(string: "https://coinmarketcap.com/currencies/bitcoin/#About")!,
                 descriptions: "Bitcoin is a decentralized cryptocurrency originally described in a 2008 whitepaper by a person, or group of people, using the alias Satoshi Nakamoto. It was launched soon after, in January 2009. Bitcoin is a peer-to-peer online currency, meaning that all transactions happen directly between equal, independent network participants, without the need for any intermediary to permit or facilitate them. Bitcoin was created, according to Nakamoto’s own words, to allow “online payments to be sent directly from one party to another without going through a financial institution.”",
                 foundersDescription: "Bitcoin’s original inventor is known under a pseudonym, Satoshi Nakamoto. As of 2021, the true identity of the person — or organization — that is behind the alias remains unknown. On October 31, 2008, Nakamoto published Bitcoin’s whitepaper, which described in detail how a peer-to-peer, online currency could be implemented. They proposed to use a decentralized ledger of transactions packaged in batches (called “blocks”) and secured by cryptographic algorithms — the whole system would later be dubbed “blockchain.”")
        ]
    }
}
