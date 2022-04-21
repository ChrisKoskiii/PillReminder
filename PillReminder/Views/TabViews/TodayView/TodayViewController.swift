//
//  ViewController.swift
//  PillReminder
//
//  Created by Christopher Koski on 4/17/22.
//

import UIKit
import CoreData

class TodayViewController: UIViewController {
  
  private var myTable = UITableView()
  private var myArray = ["Vitamin C", "Alpha Brain", "Elderberry", "Fish Oil"]
  let verticalStackView = UIStackView()
  let buttonStackView = UIStackView()
  let addItemButton = UIButton(type: .system)
  let menuButton = UIButton(type: .system)
  let titleLabel = UILabel()
  let newItemVC = NewItemViewController()
  
  var itemArray = [ItemToTake]()
  var todayCellViewModels: [TodayViewCell.ViewModel] = []
  
  var items: [NSManagedObject] = []
    //test branch
  
  override func viewDidLoad() {
    super.viewDidLoad()
    newItemVC.delegate = self

    style()
    layout()
    setupTable()
    registerTableViewCells()
  }
}
// Table Setup
extension TodayViewController {
  private func setupTable() {
    let screenSize: CGRect = UIScreen.main.bounds
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height
    
    myTable.translatesAutoresizingMaskIntoConstraints = false
    myTable.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
    myTable.dataSource = self
    myTable.delegate = self
    
    myTable.register(TodayViewCell.self, forCellReuseIdentifier: TodayViewCell.reuseID)
    myTable.rowHeight = TodayViewCell.rowHeight
  }
  
  private func registerTableViewCells() {
    let itemCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
    self.myTable.register(itemCell, forCellReuseIdentifier: "CustomTableViewCell")
  }
  
  private func reloadView() {
    self.configureTableCells(with: self.itemArray)
    self.myTable.reloadData()
  }
  private func style() {
    
    //Stack Views
    verticalStackView.translatesAutoresizingMaskIntoConstraints = false
    verticalStackView.axis = .vertical
    verticalStackView.spacing = 8
    
    buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    buttonStackView.axis = .horizontal
    buttonStackView.spacing = 8
    
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
    newItemVC.modalPresentationStyle = .popover
    // Keep animated value as false
    // Custom Modal presentation animation will be handled in VC itself
    self.present(newItemVC, animated: true)
  }
  
  @objc func menuButtonTapped() {
    myTable.reloadData()
    print(itemArray)
  }
  
  func changeCheckmark(item: ItemToTake) {
    
  }
}

// MARK: TableView protocols

extension TodayViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    itemArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard !todayCellViewModels.isEmpty else { return UITableViewCell() }
    let item = todayCellViewModels[indexPath.row]
    
    let cell = myTable.dequeueReusableCell(withIdentifier: TodayViewCell.reuseID, for: indexPath) as! TodayViewCell
    cell.configure(with: item, isDone: item.isDone)
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          itemArray.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: .fade)
      } else if editingStyle == .insert {
          // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
      }
  }
  
  private func configureTableCells(with items: [ItemToTake]) {
    todayCellViewModels = items.map {
      TodayViewCell.ViewModel(itemName: $0.name, amount: $0.amount, frequency: $0.units, isDone: false)
    }
  }
}

extension TodayViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone
    print(itemArray[indexPath.row].isDone)
    let cell = tableView.cellForRow(at: indexPath) as! TodayViewCell
    cell.changeCheckmark(isDone: itemArray[indexPath.row].isDone)
  }
}

extension TodayViewController: NewItemViewControllerDelegate {
  func newItemCreated(_ newItem: ItemToTake) {
    itemArray.append(newItem)
    DispatchQueue.main.async {
      self.reloadView()
    }
  }
}

