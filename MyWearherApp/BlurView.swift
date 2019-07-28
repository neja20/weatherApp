//
//  BlurView.swift
//  MyWearherApp
//
//  Created by D N on 26/07/2019.
//  Copyright © 2019 Daniel Nejezchleb. All rights reserved.
//

import Foundation
import UIKit

class BlurView: UIVisualEffectView {
    
    var temperatureLabel = UILabel()
    var cityLabel = UILabel()
    
    override func awakeFromNib() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // set the corner radius
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        
        self.effect = UIBlurEffect(style: .light)
        self.backgroundColor = .clear
        //self.tintColor = .red
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: self.effect as! UIBlurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(vibrancyView)
        
        
        NSLayoutConstraint.activate([
            vibrancyView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            vibrancyView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            vibrancyView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            vibrancyView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
            ])
        
        
        let viewFromNib: UIView? = Bundle.main.loadNibNamed("weatherView",
                                                            owner: nil,
                                                            options: nil)?.first as! UIView
        viewFromNib?.translatesAutoresizingMaskIntoConstraints = false
        vibrancyView.contentView.addSubview(viewFromNib!)
        
        NSLayoutConstraint.activate([
            vibrancyView.topAnchor.constraint(equalTo: viewFromNib!.topAnchor),
            vibrancyView.leadingAnchor.constraint(equalTo: viewFromNib!.leadingAnchor),
            vibrancyView.trailingAnchor.constraint(equalTo: viewFromNib!.trailingAnchor),
            vibrancyView.bottomAnchor.constraint(greaterThanOrEqualTo: viewFromNib!.bottomAnchor, constant: 8)
            ])

    }
    
    init() {
        super.init(effect: nil)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // set the corner radius
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        
        self.effect = UIBlurEffect(style: .light)
        self.backgroundColor = .clear
        self.tintColor = .red
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: self.effect as! UIBlurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(vibrancyView)
        
        
        NSLayoutConstraint.activate([
            vibrancyView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            vibrancyView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            vibrancyView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            vibrancyView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
            ])
        
        
        let viewFromNib: UIView? = Bundle.main.loadNibNamed("weatherView",
                                                            owner: nil,
                                                            options: nil)?.first as! UIView
        viewFromNib?.translatesAutoresizingMaskIntoConstraints = false
        vibrancyView.contentView.addSubview(viewFromNib!)
        
        NSLayoutConstraint.activate([
            vibrancyView.topAnchor.constraint(equalTo: viewFromNib!.topAnchor),
            vibrancyView.leadingAnchor.constraint(equalTo: viewFromNib!.leadingAnchor),
            vibrancyView.trailingAnchor.constraint(equalTo: viewFromNib!.trailingAnchor),
            vibrancyView.bottomAnchor.constraint(greaterThanOrEqualTo: viewFromNib!.bottomAnchor, constant: 8)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
