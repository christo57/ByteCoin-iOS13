//
//  ByteCoinData.swift
//  ByteCoin
//
//  Created by Christopher Klein on 17/06/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct ByteCoinData: Decodable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
