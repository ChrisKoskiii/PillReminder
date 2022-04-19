//
//  MedicationsViewController.swift
//  PillReminder
//
//  Created by Christopher Koski on 4/18/22.
//

import UIKit

class MedicationsViewController: UIViewController {
  
  let stackView = UIStackView()
  let label = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    style()
    layout()
  }
}

extension MedicationsViewController {
  private func style() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Welcome"
    label.font = UIFont.preferredFont(forTextStyle: .title1)
  }
  
  private func layout() {
    stackView.addArrangedSubview(label)
    
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
