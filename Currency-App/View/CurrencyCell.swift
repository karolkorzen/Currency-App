//
//  CurrencyCell.swift
//  Currency-App
//
//  Created by Karol Korzeń on 15/01/2022.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    //MARK: - Properties
    
    private var dateLabel = ViewFactory.standardLabel(withSize: 10, withWeight: .light, withColor: .darkGray)
    private var nameLabel = ViewFactory.standardLabel(withSize: 16, withWeight: .regular, withColor: .black)
    private var codeLabel = ViewFactory.standardLabel(withSize: 10, withWeight: .light, withColor: .darkGray)
    private var midLabel = ViewFactory.standardLabel(withSize: 20, withWeight: .semibold, withColor: .black)
    
    var viewModel: CurrencyItemViewModel? {
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
        nameLabel.text = viewModel.nameLabelText
        codeLabel.text = viewModel.codeLabelText
        midLabel.text = viewModel.midLabelText
    }
    
    func configureCell(){
        backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
        self.layer.cornerRadius = 15
        
        codeLabel.textAlignment = .right
        dateLabel.textAlignment = .right
        
        dateLabel.setContentHuggingPriority(UILayoutPriority.init(rawValue: 250), for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: 250), for: .horizontal)
        codeLabel.setContentHuggingPriority(UILayoutPriority.init(rawValue: 250), for: .horizontal)
        codeLabel.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: 250), for: .horizontal)
        nameLabel.setContentHuggingPriority(UILayoutPriority.init(rawValue: 100), for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: 750), for: .horizontal)
        midLabel.setContentHuggingPriority(UILayoutPriority.init(rawValue: 750), for: .horizontal)
        midLabel.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: 1000), for: .horizontal)

        
        addSubview(nameLabel)
        addSubview(midLabel)
        addSubview(codeLabel)
        addSubview(dateLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            midLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            midLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            dateLabel.trailingAnchor.constraint(equalTo: midLabel.leadingAnchor, constant: -5),
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
            dateLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            dateLabel.heightAnchor.constraint(equalToConstant: 15),
            codeLabel.trailingAnchor.constraint(equalTo: midLabel.leadingAnchor, constant: -5),
            codeLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
            codeLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            codeLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}
