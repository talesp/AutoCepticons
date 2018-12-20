//
//  TransformersListTableViewCell.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 15/12/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class TransformersListTableViewCell: UITableViewCell, Reusable {

    private var dataTask: URLSessionDataTask?
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView(image: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Bot"
        view.font = UIFont.preferredFont(forTextStyle: .title1)
        view.textAlignment = .center
        return view
    }()

    private lazy var attributesView: TransformerAttributesView = {
        let view = TransformerAttributesView(transformer: nil, isEditable: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var innerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, attributesView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8.0
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return view
    }()

    private lazy var outterStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [iconImageView, innerStackView])
        view.axis = .horizontal
        view.spacing = 8.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViewConfiguration()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(transformer: Transformer) {
        self.titleLabel.text = transformer.name
        self.attributesView.setup(transformer: transformer)

        guard let data = transformer.teamIcon else { return }

        self.iconImageView.image = UIImage(data: data)

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.dataTask?.cancel()
        self.dataTask = nil
    }
}

extension TransformersListTableViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        self.contentView.addSubview(outterStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.outterStackView.topAnchor.constraint(equalToSystemSpacingBelow: self.contentView.topAnchor, multiplier: 1.0),
            self.outterStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.contentView.leadingAnchor, multiplier: 1.0),
            self.contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: self.outterStackView.bottomAnchor, multiplier: 1.0),
            self.outterStackView.trailingAnchor.constraint(equalToSystemSpacingAfter: self.contentView.trailingAnchor, multiplier: 1.0),
            ])
        NSLayoutConstraint.activate([
            self.iconImageView.widthAnchor.constraint(equalTo: self.iconImageView.heightAnchor, multiplier: 500.0/475.0),
            self.iconImageView.heightAnchor.constraint(equalToConstant: 140.0)
            ])
    }
    
}
