//
//  NewItemTableView.swift
//  PillReminder
//
//  Created by Christopher Koski on 4/19/22.
//


import Foundation
import UIKit

class NewItemTableView: UIView {
  
  let stackView = UIStackView()
  
  let titleTextInput = UITextField()
  let unitsTextInput = UITextField()
  let frequencyTextInput = UITextField()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension NewItemTableView {
  
  func style() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .secondarySystemBackground
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 8
    
    titleTextInput.translatesAutoresizingMaskIntoConstraints = false
    titleTextInput.placeholder = "Name"
    titleTextInput.delegate = self
    
    unitsTextInput.translatesAutoresizingMaskIntoConstraints = false
    unitsTextInput.placeholder = "How much?"
    unitsTextInput.delegate = self
    
    frequencyTextInput.translatesAutoresizingMaskIntoConstraints = false
    frequencyTextInput.placeholder = "How often?"
    frequencyTextInput.delegate = self
    
    layer.cornerRadius = 5
    clipsToBounds = true
  }
  
  func layout() {
    stackView.addArrangedSubview(titleTextInput)
    stackView.addArrangedSubview(DividerView())
    stackView.addArrangedSubview(unitsTextInput)
    stackView.addArrangedSubview(DividerView())
    stackView.addArrangedSubview(frequencyTextInput)
    
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
      trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
      bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
    ])
  }
}

extension NewItemTableView: UITextFieldDelegate {
  
}

class DividerView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func style() {
    backgroundColor = .secondarySystemBackground
    translatesAutoresizingMaskIntoConstraints = false
    
    self.translatesAutoresizingMaskIntoConstraints = false
    self.backgroundColor = .secondarySystemFill
  }
  
  func layout() {
    self.heightAnchor.constraint(equalToConstant: 1).isActive = true
  }
}
