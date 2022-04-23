//
//  TodayViewCell.swift
//  PillReminder
//
//  Created by Christopher Koski on 4/20/22.
//

import UIKit

class TodayViewCell: UITableViewCell {
  
  // ViewModel
  struct ViewModel {
    let itemName: String
    let amount: String
    let frequency: String
    var isDone: Bool
  }
  let viewModel: ViewModel? = nil
  
  // Labels
  let nameLabel = UILabel()
  let amountLabel = UILabel()
  let frequencyLabel = UILabel()
  
  let underlineView = UIView()
  
  // Checkmark Image
  let selectedCheckmark = SelectedCheckmark()
  let unselectedCheckmark = UnselectedCheckmark()
  
  // Utils
  static let reuseID = "AccountSummaryCell"
  static let rowHeight: CGFloat = 112  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension TodayViewCell {
  private func setup() {
    
    //    labelStack.translatesAutoresizingMaskIntoConstraints = false
    //    labelStack.axis = .vertical
    //    labelStack.spacing = 8
    
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    nameLabel.adjustsFontForContentSizeCategory = true
    nameLabel.text = "Item Name"
    
    underlineView.translatesAutoresizingMaskIntoConstraints = false
    underlineView.backgroundColor = .systemMint
    
    amountLabel.translatesAutoresizingMaskIntoConstraints = false
    amountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    amountLabel.adjustsFontForContentSizeCategory = true
    amountLabel.text = "2 Capsules"
    
    frequencyLabel.translatesAutoresizingMaskIntoConstraints = false
    frequencyLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    frequencyLabel.adjustsFontForContentSizeCategory = true
    frequencyLabel.text = "Every Morning"
    
    selectedCheckmark.isHidden = true
  }
  
  private func layout() {
    addSubview(nameLabel)
    addSubview(underlineView)
    addSubview(amountLabel)
    addSubview(frequencyLabel)
    
    addSubview(selectedCheckmark)
    addSubview(unselectedCheckmark)
    
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
      nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
      
      underlineView.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 1),
      underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
      underlineView.widthAnchor.constraint(equalToConstant: 60),
      underlineView.heightAnchor.constraint(equalToConstant: 4),
      
      amountLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
      amountLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      
      frequencyLabel.topAnchor.constraint(equalToSystemSpacingBelow: amountLabel.bottomAnchor, multiplier: 1),
      frequencyLabel.leadingAnchor.constraint(equalTo: amountLabel.leadingAnchor),
      
      selectedCheckmark.centerYAnchor.constraint(equalTo: centerYAnchor),
      trailingAnchor.constraint(equalToSystemSpacingAfter: selectedCheckmark.trailingAnchor, multiplier: 2),
      
      unselectedCheckmark.centerYAnchor.constraint(equalTo: centerYAnchor),
      trailingAnchor.constraint(equalToSystemSpacingAfter: unselectedCheckmark.trailingAnchor, multiplier: 2)
    ])
    
  }
}

extension TodayViewCell {
  func configure(with vm: ViewModel, isDone: Bool) {
    nameLabel.text = vm.itemName
    amountLabel.text = vm.amount
    frequencyLabel.text = vm.frequency
    changeCheckmark(isDone: isDone)
  }
  
  func changeCheckmark(isDone: Bool) {
    if isDone {
      UIView.transition(with: self, duration: 0.5, options: [.transitionCrossDissolve], animations: { [self] in
        self.selectedCheckmark.isHidden = false
        unselectedCheckmark.isHidden = true
      }, completion: nil)
    } else {
      UIView.transition(with: self, duration: 0.5, options: [.transitionCrossDissolve], animations: { [self] in
        selectedCheckmark.isHidden = true
        unselectedCheckmark.isHidden = false
      }, completion: nil)

    }
  }
}
