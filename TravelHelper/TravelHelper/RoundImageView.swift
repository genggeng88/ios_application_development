//
//  RoundImageView.swift
//  TravelHelper
//
//  Created by Qin Geng on 5/15/23.
//

import UIKit

class RoundImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }
}
