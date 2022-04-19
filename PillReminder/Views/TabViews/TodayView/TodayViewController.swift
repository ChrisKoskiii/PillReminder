//
//  ViewController.swift
//  PillReminder
//
//  Created by Christopher Koski on 4/17/22.
//

import UIKit

class TodayViewController: UIViewController {
  
  private var myTable = UITableView()
  private var myArray = ["Vitamin C", "Alpha Brain", "Elderberry", "Fish Oil"]
  let verticalStackView = UIStackView()
  let buttonStackView = UIStackView()
  let addItemButton = UIButton(type: .system)
  let menuButton = UIButton(type: .system)
  let titleLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
    
  }
}

extension TodayViewController {
  private func style() {
    let screenSize: CGRect = UIScreen.main.bounds
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height
    
    //Stack Views
    verticalStackView.translatesAutoresizingMaskIntoConstraints = false
    verticalStackView.axis = .vertical
    verticalStackView.spacing = 8
    
    buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    buttonStackView.axis = .horizontal
    buttonStackView.spacing = 8
    
    // UITableView
    myTable.translatesAutoresizingMaskIntoConstraints = false
    myTable.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
    myTable.dataSource = self
    myTable.delegate = self
    myTable.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")

    //Buttons
    menuButton.translatesAutoresizingMaskIntoConstraints = false
    menuButton.configuration = .plain()
    menuButton.setImage(UIImage(systemName: "rectangle.leadinghalf.filled"), for: [])
    menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .primaryActionTriggered)
    
    addItemButton.translatesAutoresizingMaskIntoConstraints = false
    addItemButton.configuration = .plain()
    addItemButton.setImage(UIImage(systemName: "plus"), for: [])
    addItemButton.addTarget(self, action: #selector(addItemTapped), for: .primaryActionTriggered)
    
    // Label
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textAlignment = .center
    titleLabel.textColor = .systemMint
    titleLabel.text = "Monday, Jan 4th"
    titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
    titleLabel.adjustsFontForContentSizeCategory = true
  }
  
  private func layout() {
    buttonStackView.addArrangedSubview(menuButton)
    buttonStackView.addArrangedSubview(titleLabel)
    buttonStackView.addArrangedSubview(addItemButton)
    verticalStackView.addArrangedSubview(buttonStackView)
    verticalStackView.addArrangedSubview(myTable)
    
    self.view.addSubview(verticalStackView)
    
    
    // Vertical stackView
    NSLayoutConstraint.activate([
      verticalStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
      verticalStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: verticalStackView.trailingAnchor, multiplier: 1),
      view.bottomAnchor.constraint(equalToSystemSpacingBelow: verticalStackView.bottomAnchor, multiplier: 1)
    ])
    
    NSLayoutConstraint.activate([
      menuButton.widthAnchor.constraint(equalToConstant: 50)
    ])
  }
}
//MARK: Actions
extension TodayViewController {
  @objc func addItemTapped() {
    print("added item")
  }
  
  @objc func menuButtonTapped() {
    print("menu tapped")
  }
}

// MARK: TableView protocols
extension TodayViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    myArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
    cell.textLabel?.text = self.myArray[indexPath.row]
    return cell
  }
}

extension TodayViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("User selected table row \(indexPath.row) and item \(myArray[indexPath.row])")
  }
}

