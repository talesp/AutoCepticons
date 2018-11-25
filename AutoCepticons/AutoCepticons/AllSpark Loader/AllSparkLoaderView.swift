//
//  AllSparkLoaderView.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/25/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class AllSparkLoaderView: UIView {

    private lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .title1)
        view.text = "Loading AllSpark..."
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()

    /// ":nodoc:"
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }

    /// ":nodoc:"
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AllSparkLoaderView: ViewConfiguration {

    /// ":nodoc:"
    func buildViewHierarchy() {
        addSubview(titleLabel)
    }

    /// ":nodoc:"
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor,
                                              multiplier: 1.0,
                                              constant: -(layoutMargins.left + layoutMargins.right)),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }

}
