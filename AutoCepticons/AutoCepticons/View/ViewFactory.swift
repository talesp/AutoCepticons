//
//  ViewFactory.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 15/12/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class ViewFactory {

    func label(title: String, forTextStyle style: UIFont.TextStyle = .body) -> UILabel {
        let view = UILabel(frame: .zero)
        view.font = UIFont.preferredFont(forTextStyle: style)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.text = title
        return view
    }

    func textField(title: String?,
                   delegate: UITextFieldDelegate?,
                   toolbar: UIToolbar?,
                   isAsciiCapable: Bool = false,
                   isEditable: Bool = true) -> UITextField {
        let view = UITextField(frame: .zero)
        view.font = UIFont.preferredFont(forTextStyle: .title3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = title ?? ""
        if isEditable {
            view.borderStyle = .roundedRect
        }
        else {
            view.borderStyle = .none
        }
        view.delegate = delegate

        view.inputAccessoryView = toolbar
        view.returnKeyType = .next
        if isAsciiCapable {
            view.keyboardType = .asciiCapable
        }
        else {
            view.keyboardType = .numberPad
        }
        return view
    }

    func stackView(with titleLabel: UILabel, valueLabel: UITextField) -> UIStackView {
        let view = UIStackView(arrangedSubviews: [ titleLabel, valueLabel ])
        view.axis = .horizontal
        view.spacing = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

