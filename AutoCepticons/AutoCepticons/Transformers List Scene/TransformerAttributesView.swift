//
//  TransformerAttributesView.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 15/12/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class TransformerAttributesView: UIView {

    private let viewFactory = ViewFactory()

    private let transformer: Transformer?

    private let delegate: UITextFieldDelegate?

    private let toolbar: UIToolbar?

    private let isEditable: Bool

    init(transformer: Transformer?, isEditable: Bool, delegate: UITextFieldDelegate? = nil, toolbar: UIToolbar? = nil) {
        self.transformer = transformer
        self.isEditable = isEditable
        self.delegate = delegate
        self.toolbar = toolbar
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViewConfiguration()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var strengthLabel: UILabel = {
        return self.viewFactory.label(title: "Strength")
    }()

    private lazy var strengthTextField: UITextField = {
        return self.viewFactory.textField(title: "", delegate: self.delegate, toolbar: self.toolbar, isEditable: self.isEditable)
    }()

    private lazy var strengthStackView: UIStackView = {
        return self.viewFactory.stackView(with: strengthLabel, valueLabel: strengthTextField)
    }()

    private lazy var intelligenceLabel: UILabel = {
        return self.viewFactory.label(title: "Intelligence")
    }()

    private lazy var intelligenceTextField: UITextField = {
        return self.viewFactory.textField(title: "", delegate: self.delegate, toolbar: self.toolbar, isEditable: self.isEditable)
    }()

    private lazy var intelligenceStackView: UIStackView = {
        return self.viewFactory.stackView(with: intelligenceLabel, valueLabel: intelligenceTextField)
    }()

    private lazy var strengthIntelligenceStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [strengthStackView, intelligenceStackView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()

    private lazy var speedLabel: UILabel = {
        return self.viewFactory.label(title: "Speed")
    }()

    private lazy var speedTextField: UITextField = {
        return self.viewFactory.textField(title: "", delegate: self.delegate, toolbar: self.toolbar, isEditable: self.isEditable)
    }()

    private lazy var speedStackView: UIStackView = {
        return self.viewFactory.stackView(with: speedLabel, valueLabel: speedTextField)
    }()

    private lazy var enduranceLabel: UILabel = {
        return self.viewFactory.label(title: "Endurance")
    }()

    private lazy var enduranceTextField: UITextField = {
        return self.viewFactory.textField(title: "", delegate: self.delegate, toolbar: self.toolbar, isEditable: self.isEditable)
    }()

    private lazy var enduranceStackView: UIStackView = {
        return self.viewFactory.stackView(with: enduranceLabel, valueLabel: enduranceTextField)
    }()

    private lazy var speedEnduranceStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [speedStackView, enduranceStackView])
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        return view
    }()

    private lazy var firstBlockStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [strengthIntelligenceStackView, speedEnduranceStackView])
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var rankLabel: UILabel = {
        return self.viewFactory.label(title: "Rank")
    }()

    private lazy var rankTextField: UITextField = {
        return self.viewFactory.textField(title: "", delegate: self.delegate, toolbar: self.toolbar, isEditable: self.isEditable)
    }()

    private lazy var rankStackView: UIStackView = {
        return self.viewFactory.stackView(with: rankLabel, valueLabel: rankTextField)
    }()

    private lazy var courageLabel: UILabel = {
        return self.viewFactory.label(title: "Courage")
    }()

    private lazy var courageTextField: UITextField = {
        return self.viewFactory.textField(title: "", delegate: self.delegate, toolbar: self.toolbar, isEditable: self.isEditable)
    }()

    private lazy var courageStackView: UIStackView = {
        return self.viewFactory.stackView(with: courageLabel, valueLabel: courageTextField)
    }()

    private lazy var rankCourageStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [rankStackView, courageStackView])
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        return view
    }()

    private lazy var firepowerLabel: UILabel = {
        return self.viewFactory.label(title: "Firepower")
    }()

    private lazy var firepowerTextField: UITextField = {
        return self.viewFactory.textField(title: "", delegate: self.delegate, toolbar: self.toolbar, isEditable: self.isEditable)
    }()

    private lazy var firepowerStackView: UIStackView = {
        return self.viewFactory.stackView(with: firepowerLabel, valueLabel: firepowerTextField)
    }()

    private lazy var skillLabel: UILabel = {
        return self.viewFactory.label(title: "Skill")
    }()

    private lazy var skillTextField: UITextField = {
        return self.viewFactory.textField(title: "", delegate: self.delegate, toolbar: self.toolbar, isEditable: self.isEditable)
    }()

    private lazy var skillStackView: UIStackView = {
        return self.viewFactory.stackView(with: skillLabel, valueLabel: skillTextField)
    }()

    private lazy var firepowerSkillStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [firepowerStackView, skillStackView])
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        return view
    }()

    private lazy var secondBlockStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [rankCourageStackView, firepowerSkillStackView])
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [firstBlockStackView, secondBlockStackView])
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }

    func setup(transformer: Transformer) {
        self.strengthTextField.text = "\(transformer.strength)"
        self.intelligenceTextField.text = "\(transformer.intelligence)"
        self.speedTextField.text = "\(transformer.speed)"
        self.enduranceTextField.text = "\(transformer.endurance)"
        self.rankTextField.text = "\(transformer.rank)"
        self.courageTextField.text = "\(transformer.courage)"
        self.firepowerTextField.text = "\(transformer.firepower)"
        self.skillTextField.text = "\(transformer.skill)"

    }
}

extension TransformerAttributesView: ViewConfiguration {

    func buildViewHierarchy() {
        self.addSubview(stackView)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo:self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])

        NSLayoutConstraint.activate([
            strengthLabel.widthAnchor.constraint(equalTo: intelligenceLabel.widthAnchor),
            strengthLabel.widthAnchor.constraint(equalTo: speedLabel.widthAnchor),
            strengthLabel.widthAnchor.constraint(equalTo: enduranceLabel.widthAnchor),
            strengthLabel.widthAnchor.constraint(equalTo: rankLabel.widthAnchor),
            strengthLabel.widthAnchor.constraint(equalTo: courageLabel.widthAnchor),
            strengthLabel.widthAnchor.constraint(equalTo: firepowerLabel.widthAnchor),
            strengthLabel.widthAnchor.constraint(equalTo: skillLabel.widthAnchor)
            ])

    }

    func configureViews() {
        backgroundColor = .white
    }

    @objc
    private func dismissKeyboard(sender: Any) {
        endEditing(false)
    }

}

