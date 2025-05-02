//
//  RepositorySkeletonView.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import UIKit

final class RepositorySkeletonView: UIView {
    private let shimmerLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        layer.cornerRadius = 8
        clipsToBounds = true
        setupShimmer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupShimmer() {
        shimmerLayer.colors = [
            UIColor.systemGray4.cgColor,
            UIColor.systemGray5.cgColor,
            UIColor.systemGray4.cgColor
        ]
        shimmerLayer.startPoint = CGPoint(x: 0, y: 0.5)
        shimmerLayer.endPoint = CGPoint(x: 1, y: 0.5)
        shimmerLayer.locations = [0, 0.5, 1]
        shimmerLayer.frame = bounds
        layer.addSublayer(shimmerLayer)

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1, -0.5, 0]
        animation.toValue = [1, 1.5, 2]
        animation.duration = 1.2
        animation.repeatCount = .infinity
        shimmerLayer.add(animation, forKey: "shimmer")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        shimmerLayer.frame = bounds
    }
}
