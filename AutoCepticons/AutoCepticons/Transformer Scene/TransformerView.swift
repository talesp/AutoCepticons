//
//  TransformerView.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/25/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class TransformerView: UIView {

    private let webservice = Webservice()

    private var transformer: Transformer?

    private var viewFactory = ViewFactory()

    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: .zero)
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                         UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard(sender:)))]
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        return toolbar
    }()

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit

        guard let url = self.transformer?.teamIconURL else { return view }
        URLSession(configuration: .default).dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                guard let image = image else { return }

                view.image = image
                let multiplier = image.size.height / image.size.width
                view.heightAnchor.constraint(equalTo: self.iconImageView.widthAnchor,
                                             multiplier: multiplier).isActive = true
            }
        }).resume()

        return view
    }()

    private lazy var imageWidthConstraint = iconImageView.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                                                 multiplier: 1,
                                                                                 constant: -(2 * self.layoutMargins.left))

    private lazy var imageHeightConstraint = iconImageView.widthAnchor.constraint(equalTo: self.heightAnchor,
                                                                                 multiplier: 1,
                                                                                 constant: -(2 * self.layoutMargins.top))

    private lazy var nameLabel: UILabel = {
        return self.viewFactory.label(title: "Name")
    }()

    private lazy var nameTextField: UITextField = {
        return self.viewFactory.textField(title: self.transformer?.name, delegate: self, toolbar: self.toolbar, isAsciiCapable: true)
    }()

    private lazy var nameStackView: UIStackView = {
        return self.viewFactory.stackView(with: nameLabel, valueLabel: nameTextField)
    }()

    private lazy var teamLabel: UILabel = {
        return self.viewFactory.label(title: "Team")
    }()

    private lazy var teamSwitch: UISwitch = {
        let view = UISwitch(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOn = true
        view.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
        return view
    }()

    private lazy var teamSelectorStackView: UIStackView = {
        let autoBotLabel = UILabel(frame: .zero)
        autoBotLabel.translatesAutoresizingMaskIntoConstraints = false
        autoBotLabel.text = "AutoBot"
        autoBotLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        autoBotLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        autoBotLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let decepticonLabel = UILabel(frame: .zero)
        decepticonLabel.translatesAutoresizingMaskIntoConstraints = false
        decepticonLabel.text = "Decepticon"
        decepticonLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        decepticonLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        decepticonLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let view = UIStackView(arrangedSubviews: [decepticonLabel, teamSwitch, autoBotLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .equalSpacing
        return view
    }()

    private lazy var teamStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [teamLabel, teamSelectorStackView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 4
        return view
    }()

    private lazy var strengthLabel: UILabel = {
        return self.viewFactory.label(title: "Strength")
    }()

    private lazy var strengthTextField: UITextField = {
        return self.viewFactory.textField(title: self.transformer?.strength, delegate: self, toolbar: self.toolbar)
    }()

    private lazy var strengthStackView: UIStackView = {
        return self.viewFactory.stackView(with: strengthLabel, valueLabel: strengthTextField)
    }()

    private lazy var intelligenceLabel: UILabel = {
        return self.viewFactory.label(title: "Intelligence")
    }()

    private lazy var intelligenceTextField: UITextField = {
        return self.viewFactory.textField(title: self.transformer?.intelligence, delegate: self, toolbar: self.toolbar)
    }()

    private lazy var intelligenceStackView: UIStackView = {
        return self.viewFactory.stackView(with: intelligenceLabel, valueLabel: intelligenceTextField)
    }()

    private lazy var speedLabel: UILabel = {
        return self.viewFactory.label(title: "Speed")
    }()

    private lazy var speedTextField: UITextField = {
        return self.viewFactory.textField(title: self.transformer?.speed, delegate: self, toolbar: self.toolbar)
    }()

    private lazy var speedStackView: UIStackView = {
        return self.viewFactory.stackView(with: speedLabel, valueLabel: speedTextField)
    }()

    private lazy var enduranceLabel: UILabel = {
        return self.viewFactory.label(title: "Endurance")
    }()

    private lazy var enduranceTextField: UITextField = {
        return self.viewFactory.textField(title: self.transformer?.endurance, delegate: self, toolbar: self.toolbar)
    }()

    private lazy var enduranceStackView: UIStackView = {
        return self.viewFactory.stackView(with: enduranceLabel, valueLabel: enduranceTextField)
    }()

    private lazy var rankLabel: UILabel = {
        return self.viewFactory.label(title: "Rank")
    }()

    private lazy var rankTextField: UITextField = {
        return self.viewFactory.textField(title: self.transformer?.rank, delegate: self, toolbar: self.toolbar)
    }()

    private lazy var rankStackView: UIStackView = {
        return self.viewFactory.stackView(with: rankLabel, valueLabel: rankTextField)
    }()

    private lazy var courageLabel: UILabel = {
        return self.viewFactory.label(title: "Courage")
    }()

    private lazy var courageTextField: UITextField = {
        return self.viewFactory.textField(title: self.transformer?.courage, delegate: self, toolbar: self.toolbar)
    }()

    private lazy var courageStackView: UIStackView = {
        return self.viewFactory.stackView(with: courageLabel, valueLabel: courageTextField)
    }()

    private lazy var firepowerLabel: UILabel = {
        return self.viewFactory.label(title: "Firepower")
    }()

    private lazy var firepowerTextField: UITextField = {
        return self.viewFactory.textField(title: self.transformer?.firepower, delegate: self, toolbar: self.toolbar)
    }()

    private lazy var firepowerStackView: UIStackView = {
        return self.viewFactory.stackView(with: firepowerLabel, valueLabel: firepowerTextField)
    }()

    private lazy var skillLabel: UILabel = {
        return self.viewFactory.label(title: "Skill")
    }()

    private lazy var skillTextField: UITextField = {
        return self.viewFactory.textField(title: self.transformer?.skill, delegate: self, toolbar: self.toolbar)
    }()

    private lazy var skillStackView: UIStackView = {
        return self.viewFactory.stackView(with: skillLabel, valueLabel: skillTextField)
    }()

    private lazy var formStackView: UIStackView = {
        var view = UIStackView(arrangedSubviews: [
            nameStackView, teamStackView, strengthStackView, intelligenceStackView, speedStackView,
            enduranceStackView, rankStackView, courageStackView, firepowerStackView, skillStackView,
            saveButton
            ])
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 4.0
        view.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        view.isLayoutMarginsRelativeArrangement = true

        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [iconImageView, formStackView])

        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 4.0
        view.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let vertical = UITraitCollection(verticalSizeClass: .regular)
        guard self.iconImageView.image != nil else { return }
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { return }
            let isVertical = self.traitCollection.containsTraits(in: vertical)
            self.stackView.axis = isVertical ? .vertical : .horizontal
            if self.iconImageView.image != nil {
                if isVertical {
                    self.imageWidthConstraint.isActive = true
                }
                else {
                    self.imageWidthConstraint.isActive = false
                }
                self.imageHeightConstraint.isActive = !self.imageWidthConstraint.isActive
            }
            self.layoutIfNeeded()
        }
    }

    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(save(sender:)), for: .touchUpInside)
        view.setTitle("Save Transformer", for: .normal)
        return view
    }()

    @objc
    func save(sender: Any) {
        guard let name = nameTextField.text,
            let strenght = strengthTextField.text,
            let inteligence = intelligenceTextField.text,
            let speed = speedTextField.text,
            let endurance = enduranceTextField.text,
            let rank = rankTextField.text,
            let courage = courageTextField.text,
            let firepower = firepowerTextField.text,
            let skill = skillTextField.text else {
                return
        }


        let transformer: Transformer
        if let transf = self.transformer {
            transf.name = name
            transf.team = self.teamSwitch.isOn ? "A" : "D"
            transf.strength = strenght
            transf.intelligence = inteligence
            transf.speed = speed
            transf.endurance = endurance
            transf.rank = rank
            transf.courage = courage
            transf.firepower = firepower
            transf.skill = skill
            transformer = transf

        } else {
            transformer = Transformer(name: name,
                                      team: teamSwitch.isOn ? "A" : "D",
                                      strength: strenght,
                                      intelligence: inteligence,
                                      speed: speed,
                                      endurance: endurance,
                                      rank: rank,
                                      courage: courage,
                                      firepower: firepower,
                                      skill: skill)
        }
        let resource: Resource<Transformer>
        if transformer.id != nil {
            resource = transformer.put()
        }
        else {
            resource = transformer.post()
        }
        webservice.load(resource) { result in
            switch result {
            case .success(let transformer):
                guard let url = transformer.teamIconURL else {
                    print("fuem")
                    return
                }
                URLSession(configuration: .default).dataTask(with: url, completionHandler: { data, response, error in
                    guard let data = data else { return }
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        guard let image = image else { return }

                        self.iconImageView.image = image
                        let multiplier = image.size.height / image.size.width
                        self.iconImageView.heightAnchor.constraint(equalTo: self.iconImageView.widthAnchor,
                                                                   multiplier: multiplier).isActive = true
                        UIView.animate(withDuration: 0.25, animations: {
                            self.iconImageView.image = image
                            self.layoutIfNeeded()
                        })
                    }
                }).resume()
            case .failure(let error):
                dump(error)
            }
        }
    }

    @objc
    private func valueChanged(sender: Any) {
        updateSaveButton()
    }

    private func updateSaveButton() {
        saveButton.isEnabled = self.nameTextField.text?.isEmpty == false &&
            self.strengthTextField.text?.isEmpty == false &&
            self.intelligenceTextField.text?.isEmpty == false &&
            self.speedTextField.text?.isEmpty == false &&
            self.enduranceTextField.text?.isEmpty == false &&
            self.rankTextField.text?.isEmpty == false &&
            self.courageTextField.text?.isEmpty == false &&
            self.firepowerTextField.text?.isEmpty == false &&
            self.skillTextField.text?.isEmpty == false
    }


    init(model: Transformer?) {
        self.transformer = model
        super.init(frame: .zero)
        setupViewConfiguration()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TransformerView: ViewConfiguration {

    func buildViewHierarchy() {
        self.contentView.addSubview(stackView)
        self.scrollView.addSubview(contentView)
        self.addSubview(scrollView)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([
            scrollView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])

        NSLayoutConstraint.activate([
            strengthLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            strengthLabel.widthAnchor.constraint(equalTo: teamLabel.widthAnchor),
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
        updateSaveButton()
    }

    @objc
    private func dismissKeyboard(sender: Any) {
        endEditing(false)
    }

}

extension TransformerView: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard textField != nameTextField else { return true }

        let charset = CharacterSet.decimalDigits
        return string == "" || string.rangeOfCharacter(from: charset) != nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            strengthTextField.becomeFirstResponder()
        case strengthTextField:
            intelligenceTextField.becomeFirstResponder()
        case intelligenceTextField:
            speedTextField.becomeFirstResponder()
        case speedTextField:
            enduranceTextField.becomeFirstResponder()
        case enduranceTextField:
            rankTextField.becomeFirstResponder()
        case rankTextField:
            courageTextField.becomeFirstResponder()
        case courageTextField:
            firepowerTextField.becomeFirstResponder()
        case firepowerTextField:
            skillTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButton()
    }
}
