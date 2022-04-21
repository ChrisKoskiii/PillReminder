//
//  CheckMarkImage.swift
//  PillReminder
//
//  Created by Christopher Koski on 4/20/22.
//

import Foundation
import UIKit

class SelectedCheckmark: UIView {
  
  let checkmarkImage = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    style()
    layout()
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 48, height: 48)
  }
}

extension SelectedCheckmark {
  private func style() {
    translatesAutoresizingMaskIntoConstraints = false
    checkmarkImage.translatesAutoresizingMaskIntoConstraints = false
    let image = UIImage(systemName: "checkmark.circle.fill")!.withTintColor(.systemMint, renderingMode: .alwaysOriginal)
    checkmarkImage.image = image
  }
  
  private func layout() {
    addSubview(checkmarkImage)
    
    NSLayoutConstraint.activate([
     checkmarkImage.centerXAnchor.constraint(equalTo: centerXAnchor),
     checkmarkImage.centerYAnchor.constraint(equalTo: centerYAnchor),
     checkmarkImage.heightAnchor.constraint(equalToConstant: 40),
     checkmarkImage.widthAnchor.constraint(equalToConstant: 40)
    ])
  }
  
  private func setup() {
    let singleTap = UITapGestureRecognizer(target: self, action: #selector(checkmarkImageTapped(_: )))
    checkmarkImage.addGestureRecognizer(singleTap)
    checkmarkImage.isUserInteractionEnabled = true
  }
  
  @objc func checkmarkImageTapped(_ recognizer: UITapGestureRecognizer) {
    print("check clicked")
  }
}
