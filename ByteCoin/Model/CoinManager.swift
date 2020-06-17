//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "B37C2883-FA23-43AF-B1DB-E854BF6F7DC4"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func fetchValue(moneyType: String){
        let stringUrl = "\(baseURL)/\(moneyType)?apikey=\(apiKey)"
        print(stringUrl)
        performRequest(with: stringUrl)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if let data = self.getValue(safeData) {
                        self.delegate?.didDataUpdate(data)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func getValue(_ data: Data) -> ByteCoinData? {
        let str = String(decoding: data, as: UTF8.self)
        print(str)
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(ByteCoinData.self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

