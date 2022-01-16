//
//  CurrencyListHeader.swift
//  Currency-App
//
//  Created by Karol Korzeń on 16/01/2022.
//

import UIKit

enum CurrencyListOption {
    case A
    case B
    case C
}

//MARK: - CurrencyListHeaderViewDelegate

protocol CurrencyListHeaderViewDelegate: AnyObject {
    func changeFilter(withOption option: CurrencyListOption)
}

class CurrencyListHeader: UIView {
    //MARK: - Properties
    
    weak var delegate: CurrencyListHeaderViewDelegate?
    
    private var optionAButton = ViewFactory.optionButton(withText: "A")
    private var optionBButton = ViewFactory.optionButton(withText: "B")
    private var optionCButton = ViewFactory.optionButton(withText: "C")
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    override func layoutSubviews() {
        optionAButton.setDimensions(width: frame.width/3.5, height: 30)
        optionBButton.setDimensions(width: frame.width/3.5, height: 30)
        optionCButton.setDimensions(width: frame.width/3.5, height: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func optionATapped(){
        delegate?.changeFilter(withOption: .A)
        highlightButton(withOption: .A)
    }
    
    @objc func optionBTapped(){
        delegate?.changeFilter(withOption: .B)
        highlightButton(withOption: .B)
    }
    
    @objc func optionCTapped(){
        delegate?.changeFilter(withOption: .C)
        highlightButton(withOption: .C)
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        optionAButton.addTarget(self, action: #selector(optionATapped), for: .touchUpInside)
        optionBButton.addTarget(self, action: #selector(optionBTapped), for: .touchUpInside)
        optionCButton.addTarget(self, action: #selector(optionCTapped), for: .touchUpInside)

        highlightButton(withOption: .A)
        
        let stack = UIStackView(arrangedSubviews: [optionAButton, optionBButton, optionCButton])
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18)
        ])
    }
    
    func highlightButton(withOption option: CurrencyListOption){
        switch option {
        case .A:
            optionAButton.setTitleColor(.black, for: .normal)
            optionBButton.setTitleColor(.darkGray, for: .normal)
            optionCButton.setTitleColor(.darkGray, for: .normal)
        case .B:
            optionAButton.setTitleColor(.darkGray, for: .normal)
            optionBButton.setTitleColor(.black, for: .normal)
            optionCButton.setTitleColor(.darkGray, for: .normal)
        case .C:
            optionAButton.setTitleColor(.darkGray, for: .normal)
            optionBButton.setTitleColor(.darkGray, for: .normal)
            optionCButton.setTitleColor(.black, for: .normal)
        }
    }
}
