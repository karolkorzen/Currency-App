//
//  CurrencyDetailsCellViewModel.swift
//  Currency-App
//
//  Created by Karol Korzeń on 16/01/2022.
//

import Foundation

//CurrencyDetailsCellViewModel(withRate: viewModel.rates[indexPath.row])

class CurrencyDetailsCellViewModel {
    
    //MARK: - Properties
    
    private var rate: CurrencyItem
    private var code: String
    private var no: String
    private var date: String
    
    //MARK: - Init
    
    init(withRate rate: CurrencyItem, withCode code: String, withNo no: String) {
        self.rate = rate
        self.code = code
        self.no = no
        self.date = rate.effectiveDate ?? ""
    }
    
    //MARK: - Helpers
    
    var codeLabelText: String {
        return code
    }
    
    var nameLabelText: String {
        return no
    }
    
    var bidLabelText: String? {
        if let bid = rate.bid {
            return bid.description
        } else {
            return nil
        }
    }
    
    var askLabelText: String? {
        if let ask = rate.ask {
            return ask.description
        } else {
            return nil
        }
    }
    
    var midLabelText: String? {
        if let mid = rate.mid {
            return mid.description
        } else {
            return nil
        }
    }
    
    var dateLabelText: String {
        return date
    }
}

