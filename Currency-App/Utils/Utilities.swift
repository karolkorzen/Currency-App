//
//  Utilities.swift.swift
//  Currency-App
//
//  Created by Karol Korzeń on 15/01/2022.
//

import UIKit

enum ViewFactory {
    /// func creates  standar label of default size 14 and default weight .back
    /// - Parameters:
    ///   - size: font size
    ///   - weight: weight
    ///   - color: color
    /// - Returns: UILabel
    static func standardLabel(withSize size: CGFloat = 14, withWeight weight: UIFont.Weight = .black, withColor color: UIColor = UIColor.rgb(red: 158, green: 158, blue: 158)) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    /// func creates UIImageView with defaut size 60x60
    /// - Parameters:
    ///   - width: width of image
    ///   - height: height of image
    /// - Returns: UIImageView
    static func profileImageView(withWidth width: CGFloat = 60, withHeight height: CGFloat = 60) -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: width, height: width)
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }
    
    /// func creates UIButton for filtering
    /// - Parameter text: optionText
    /// - Returns: UIButton
    static func optionButton(withText text: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.setTitle(text, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = UIColor.rgb(red: 158, green: 158, blue: 158)
        button.layer.cornerRadius = 15
        return button
    }
}
