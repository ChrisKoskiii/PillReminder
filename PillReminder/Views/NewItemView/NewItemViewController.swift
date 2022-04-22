//
//  NewItemViewController.swift
//  PillReminder
//
//  Created by Christopher Koski on 4/18/22.
//

import UIKit

protocol NewItemViewControllerDelegate: AnyObject {
  func newItemCreated(_ newItem: ItemToTake)
}

class NewItemViewController: UIViewController {
  
  var tableView = NewItemTableView()
  let addItemButton = UIButton(type: .system)
  
  var testArray = [ItemToTake]()
  weak var delegate: NewItemViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemMint
    style()
    layout()
  }
}

extension NewItemViewController {
  func style() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    addItemButton.translatesAutoresizingMaskIntoConstraints = false
    addItemButton.configuration = .filled()
    addItemButton.setTitle("Add item", for: [])
    addItemButton.addTarget(self, action: #selector(addItemTapped), for: .primaryActionTriggered)

  }
  
  func layout() {
    view.addSubview(tableView)
    view.addSubview(addItemButton)
    
    NSLayoutConstraint.activate([
      tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 2)
    ])
    
    NSLayoutConstraint.activate([
      addItemButton.topAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 1),
      addItemButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
      addItemButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),

    ])
  }
}

// MARK: Actions
extension NewItemViewController {
  @objc func addItemTapped() {
    let itemToAdd = newItem(name: tableView.titleTextInput.text!, amount: tableView.unitsTextInput.text!, frequency: tableView.frequencyTextInput.text!, isDone: false)
    delegate?.newItemCreated(itemToAdd)
    tableView.titleTextInput.text?.removeAll()
    tableView.unitsTextInput.text?.removeAll()
    tableView.frequencyTextInput.text?.removeAll()
    self.dismiss(animated: true, completion: nil)
  }
}

// MARK: New item creation
extension NewItemViewController {
  func newItem(name: String, amount: String, frequency: String, isDone: Bool) -> ItemToTake {
    let newItem = ItemToTake(name: name, amount: amount, frequency: frequency, isDone: false)
    return newItem
  }
}
