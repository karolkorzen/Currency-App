//
//  CurrenciesViewModel.swift
//  Currency-App
//
//  Created by Karol Korzeń on 15/01/2022.
//

import Foundation

class CurrenciesViewModel {
    
    //MARK: - Properties
    
    var currencies: [CurrencyItem] = []
    private var effectiveDate: String? = nil
    var currentTable: String = "A"
    
    //MARK: - API
    
    func fetchCurrencies(withParameter parameter: String, completion:(@escaping()->Void)) {
        CurrencyService.shared.fetchCurrencies(withTable: parameter) { response in
            if let rates = response.rates, let date = response.effectiveDate {
                self.currencies = rates
                self.effectiveDate = date
            }
            completion()
        }
    }
    
    //MARK: - Helpers
    
    var numberOfCurrencies: Int {
        return currencies.count
    }
    
    var date: String {
        if let date = effectiveDate {
            return date
        } else {
            return ""
        }
    }
    
    func changeTable(withOption option: CurrencyListOption){
        switch option {
        case .A:
            self.currentTable = "A"
        case .B:
            self.currentTable = "B"
        case .C:
            self.currentTable = "C"
        }
    }
}
