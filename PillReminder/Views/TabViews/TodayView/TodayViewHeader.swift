//
//  TodayViewHeader.swift
//  PillReminder
//
//  Created by Christopher Koski on 4/18/22.
//

import UIKit

class ViewController: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .red
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 200, height: 200)
  }
}

extension ViewController {
  
  func style() {
    translatesAutoresizingMaskIntoConstraints = false

  }
  
  func layout() {
    
  }
}
