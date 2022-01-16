//
//  CurrencySingleViewModel.swift
//  Currency-App
//
//  Created by Karol Korzeń on 16/01/2022.
//

import UIKit

class CurrencyDetailsViewModel {
    
    //MARK: - Properties
    
    var rates: [CurrencyItem] = []
    private var currency: String? = nil
    private var code: String? = nil
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        return df
    }()
    
    //MARK: - API
    
    func fetchCurrencyDetails(withTable table: String, withCurrencyCode code: String, withStartDate startDate: Date = Date.init().weekBefore, withEndDate endDate: Date = Date.init(), completion:(@escaping()->Void)) {
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        CurrencyService.shared.fetchCurrencyDetails(withTable: table, withCurrencyCode: code, withStartDate: startDateString, withEndDate: endDateString) { response in
            if let currency = response.currency, let code = response.code, let rates = response.rates {
                self.currency = currency
                self.code = code
                self.rates = rates
            }
            completion()
        }
    }
    
    //MARK: - Helpers
    
    var numberOfRates: Int {
        return rates.count
    }
    
    var codeString: String {
        if let code = self.code {
            return code
        } else {
            return ""
        }
    }
    
    var currencyString: String {
        if let currency = self.currency {
            return currency
        } else {
            return ""
        }
    }
}
