//
//  Currency.swift
//  Currency-App
//
//  Created by Karol Korzeń on 15/01/2022.
//

import Foundation

class RawCurrenciesResponse: Codable {
    let effectiveDate: String?
    let rates: [CurrencyItem]?
}

class CurrencyItem: Codable {
    let currency: String?
    let code:  String?
    let mid: Double?
    let bid: Double?
    let ask: Double?
    let effectiveDate: String?
    let no: String?
}

class RawCurrencyDetailsResponse: Codable {
    let currency: String?
    let code: String?
    let rates: [CurrencyItem]?
}

