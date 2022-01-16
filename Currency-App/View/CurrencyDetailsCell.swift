//
//  CurrencyDetailsCell.swift
//  Currency-App
//
//  Created by Karol Korzeń on 16/01/2022.
//

import UIKit

class CurrencyDetailsCell: UITableViewCell {
    
    //MARK: - Properties
    
    private var noLabel = ViewFactory.standardLabel(withSize: 14, withWeight: .regular, withColor: .darkGray)
    private var dateLabel = ViewFactory.standardLabel(withSize: 14, withWeight: .semibold, withColor: .black)
    private var midLabel = ViewFactory.standardLabel(withSize: 20, withWeight: .semibold, withColor: .black)
    private var bidLabel = ViewFactory.standardLabel(withSize: 20, withWeight: .semibold, withColor: .black)
    private var midLabelTitle = ViewFactory.standardLabel(withSize: 10, withWeight: .light, withColor: .darkGray)
    private var bidLabelTitle = ViewFactory.standardLabel(withSize: 10, withWeight: .light, withColor: .darkGray)
    
    var viewModel: CurrencyDetailsCellViewModel? {
        didSet{
            putData()
        }
    }
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    override var frame: CGRect {
            get {
                return super.frame
            }
            set (newFrame) {
                let frame = newFrame
                let f = CGRect(x: frame.origin.x+18, y: frame.origin.y, width: frame.width-36, height: frame.height-10)
                super.frame = f
            }
        }
    
    func putData(){
        guard let viewModel = self.viewModel else {return}
        dateLabel.text = viewModel.dateLabelText
        noLabel.text = viewModel.nameLabelText
        if let midText = viewModel.midLabelText {
            midLabel.text = midText
            midLabelTitle.text = "mid"
            bidLabelTitle.text = ""
            bidLabel.isHidden = true
            bidLabelTitle.isHidden = true
        } else {
            bidLabelTitle.text = "bid"
            midLabelTitle.text = "ask"
            bidLabel.isHidden = false
            bidLabelTitle.isHidden = false
            bidLabel.text = viewModel.bidLabelText
            midLabel.text = viewModel.askLabelText
        }
        
    }
    
    func configureCell(){
        backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
        self.layer.cornerRadius = 15
        
        noLabel.setContentHuggingPriority(UILayoutPriority.init(rawValue: 100), for: .horizontal)
        noLabel.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: 750), for: .horizontal)
        midLabel.setContentHuggingPriority(UILayoutPriority.init(rawValue: 750), for: .horizontal)
        midLabel.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: 1000), for: .horizontal)
        bidLabel.setContentHuggingPriority(UILayoutPriority.init(rawValue: 750), for: .horizontal)
        bidLabel.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: 1000), for: .horizontal)
    
        addSubview(noLabel)
        addSubview(dateLabel)
        addSubview(bidLabelTitle)
        addSubview(bidLabel)
        addSubview(midLabelTitle)
        addSubview(midLabel)
        
        NSLayoutConstraint.activate([
            noLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            noLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -2),
            dateLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            dateLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 2),
            midLabel.firstBaselineAnchor.constraint(equalTo: dateLabel.firstBaselineAnchor),
            midLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            bidLabel.firstBaselineAnchor.constraint(equalTo: dateLabel.firstBaselineAnchor),
            bidLabel.trailingAnchor.constraint(equalTo: midLabel.leadingAnchor, constant: -10),
            midLabelTitle.leadingAnchor.constraint(equalTo: midLabel.leadingAnchor),
            midLabelTitle.firstBaselineAnchor.constraint(equalTo: noLabel.firstBaselineAnchor),
            bidLabelTitle.leadingAnchor.constraint(equalTo: bidLabel.leadingAnchor),
            bidLabelTitle.firstBaselineAnchor.constraint(equalTo: noLabel.firstBaselineAnchor),
        ])
    }
}

