//
//  CurrencyService.swift
//  Currency-App
//
//  Created by Karol Korzeń on 15/01/2022.
//

import Foundation
import UIKit

class CurrencyService {
    static let shared = CurrencyService()
    private var dataTask: URLSessionDataTask?
    
    /// function fetches 25 comics for home sccene
    /// - Parameter completion: Comics
    func fetchCurrencies(withTable parameter: String, completion: @escaping((RawCurrenciesResponse) -> Void)){
        
        let fetchLink = "http://api.nbp.pl/api/exchangerates/tables/"+parameter
        print("DEBUG: fetchLink -> \(fetchLink)")
        guard let url = URL(string: fetchLink) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("DEBUG: DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("DEBUG: Empty Response")
                return
            }
            print("DEBUG: Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("DEBUG: Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([RawCurrenciesResponse].self, from: data)
                if let currencies = jsonData.first {
                    print("DEBUG: SUCCESS - FETCH")
                    DispatchQueue.main.async {
                        completion(currencies)
                    }
                }
            } catch let error {
                print("DEBUG: ERROR - FETCH")
                print(error)
            }
            
        }
        dataTask?.resume()
    }
    
    func fetchCurrencyDetails(withTable table: String, withCurrencyCode code: String, withStartDate: String, withEndDate: String, completion: @escaping((RawCurrencyDetailsResponse) -> Void)){
        
        let fetchLink = "http://api.nbp.pl/api/exchangerates/rates/\(table)/\(code)/\(withStartDate)/\(withEndDate)/"
        print("DEBUG: fetchLink -> \(fetchLink)")
        guard let url = URL(string: fetchLink) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("DEBUG: DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("DEBUG: Empty Response")
                return
            }
            print("DEBUG: Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("DEBUG: Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(RawCurrencyDetailsResponse.self, from: data)
                let currencyDetails = jsonData
                print("DEBUG: SUCCESS - FETCH")
                print("DEBUG: \(currencyDetails.code) \(currencyDetails.currency) \(currencyDetails.rates?.count)")
                DispatchQueue.main.async {
                    completion(currencyDetails)
                }
                
            } catch let error {
                print("DEBUG: ERROR - FETCH")
                print(error)
            }
            
        }
        dataTask?.resume()
    }
}
