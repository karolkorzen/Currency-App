//
//  CurrencyItemViewModel.swift
//  Currency-App
//
//  Created by Karol Korzeń on 15/01/2022.
//

import Foundation

class CurrencyItemViewModel {
    
    //MARK: - Properties
    
    var currency: CurrencyItem
    var effectiveDate: String
    
    //MARK: - Init
    
    init(withCurrency currency: CurrencyItem, withDate date: String) {
        self.currency = currency
        self.effectiveDate = date
    }
    
    //MARK: - Helpers
    
    var midLabelText: String {
        if let mid = currency.mid {
            return mid.description
        } else {
            if let bid = currency.bid {
                return bid.description
            } else {
                return ""
            }
        }
    }
    var codeLabelText: String {
        if let code = currency.code {
            return code
        } else {
            return ""
        }
    }
    var nameLabelText: String {
        if let currency = currency.currency {
            return currency
        } else {
            return ""
        }
    }
    var dateLabelText: String {
        return effectiveDate
    }
}
