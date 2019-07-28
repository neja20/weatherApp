//
//  ForecastCellView.swift
//  MyWearherApp
//
//  Created by D N on 27/07/2019.
//  Copyright © 2019 Daniel Nejezchleb. All rights reserved.
//

import Foundation
import UIKit

class ForecastCellView: UIView {
    
    var dayLabel = UILabel()
    var weatherIcon = UIImageView()
    var tempLabel = UILabel()
    
    override func awakeFromNib() {
        
        dayLabel.text="22"
        dayLabel.adjustsFontSizeToFitWidth = true
        dayLabel.textAlignment = .center
        tempLabel.text="35 ℃"
        tempLabel.adjustsFontSizeToFitWidth = true
        tempLabel.textAlignment = .center
        weatherIcon.contentMode = .scaleAspectFit
        
        self.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // set the corner radius
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.backgroundColor = .clear
        self.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        
        
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: UIBlurEffect(style: .light))
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        
        blurView.contentView.addSubview(vibrancyView)
        
        NSLayoutConstraint.activate([
            vibrancyView.heightAnchor.constraint(equalTo: blurView.contentView.heightAnchor),
            vibrancyView.widthAnchor.constraint(equalTo: blurView.contentView.widthAnchor),
            vibrancyView.centerXAnchor.constraint(equalTo: blurView.contentView.centerXAnchor),
            vibrancyView.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor)
            ])
        
    
        
        let verticalStackView = UIStackView(arrangedSubviews: [dayLabel, weatherIcon, tempLabel])
        verticalStackView.spacing = 5.0
        verticalStackView.axis = .vertical
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        vibrancyView.contentView.addSubview(verticalStackView)
        
        let constraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|[sv]|", options: [], metrics: nil, views: ["sv": verticalStackView])
        let constraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|[sv]|", options: [], metrics: nil, views: ["sv": verticalStackView])
        NSLayoutConstraint.activate(constraintsV)
        NSLayoutConstraint.activate(constraintsH)
        
        

        
    }
    
}
