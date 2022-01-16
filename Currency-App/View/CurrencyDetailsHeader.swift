//
//  CurrencyDetailsHeader.swift
//  Currency-App
//
//  Created by Karol Korzeń on 16/01/2022.
//

import UIKit

//MARK: - CurrencyListHeaderViewDelegate

protocol CurrencyDetailsHeaderViewDelegate: AnyObject {
    func changedDate(withStartDate startDate: Date, withEndDate endDate: Date)
}

class CurrencyDetailsHeader: UIView {
    
    //MARK: - Data
    
    let codeName: String
    let currencyName: String
    
    //MARK: - Properties
    
    weak var delegate: CurrencyDetailsHeaderViewDelegate?
    
    private var startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.date = Date.init().weekBefore
        datePicker.maximumDate = Date.init()
        return datePicker
    }()
    
    private var stopDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.date = Date.init()
        datePicker.maximumDate = Date.init()
        return datePicker
    }()
    
    private var startDateLabel = ViewFactory.standardLabel(withSize: 15, withWeight: .light, withColor: .black)
    private var stopDateLabel = ViewFactory.standardLabel(withSize: 15, withWeight: .light, withColor: .black)
    
    private var currencyNameLabel = ViewFactory.standardLabel(withSize: 25, withWeight: .bold, withColor: .black)
    private var codeNameLabel = ViewFactory.standardLabel(withSize: 20, withWeight: .regular, withColor: .darkGray)
    
    //MARK: - Lifecycle
    
    init(frame: CGRect, codeName: String, currencyName: String) {
        self.codeName = codeName
        self.currencyName = currencyName
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func startDateDidChange(){
        if startDatePicker.date > stopDatePicker.date {
            stopDatePicker.date = startDatePicker.date
        }
        delegate?.changedDate(withStartDate: startDatePicker.date, withEndDate: stopDatePicker.date)
        print("DEBUG: sending dates \(startDatePicker.date) \(stopDatePicker.date) ")
    }
    
    @objc func stopDateDidChange(){
        if stopDatePicker.date < startDatePicker.date {
            startDatePicker.date = stopDatePicker.date
        }
        delegate?.changedDate(withStartDate: startDatePicker.date, withEndDate: stopDatePicker.date)
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        addSubview(startDateLabel)
        addSubview(stopDateLabel)
        addSubview(startDatePicker)
        addSubview(stopDatePicker)
        addSubview(codeNameLabel)
        addSubview(currencyNameLabel)
        
        codeNameLabel.text = codeName
        codeNameLabel.textAlignment = .center
        currencyNameLabel.text = currencyName
        currencyNameLabel.textAlignment = .center
        
        startDateLabel.text = "Start Date"
        stopDateLabel.text = "Stop Date"
        
        startDatePicker.addTarget(self, action: #selector(startDateDidChange), for: .editingDidEnd)
        stopDatePicker.addTarget(self, action: #selector(stopDateDidChange), for: .editingDidEnd)
        
        startDatePicker.setDimensions(width: 104, height: 35)
        stopDatePicker.setDimensions(width: 104, height: 35)
        
        startDatePicker.contentHorizontalAlignment = .leading
        
        NSLayoutConstraint.activate([
            currencyNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            currencyNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            
            codeNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            codeNameLabel.topAnchor.constraint(equalTo: currencyNameLabel.bottomAnchor, constant: 5),
            
            startDateLabel.topAnchor.constraint(equalTo: codeNameLabel.bottomAnchor, constant: 10),
            startDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            
            stopDateLabel.topAnchor.constraint(equalTo: codeNameLabel.bottomAnchor, constant: 10),
            stopDateLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            
            startDatePicker.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 5),
            startDatePicker.leadingAnchor.constraint(equalTo: startDateLabel.leadingAnchor),
            
            stopDatePicker.topAnchor.constraint(equalTo: stopDateLabel.bottomAnchor, constant: 5),
            stopDatePicker.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -18),
        ])
    }
}

