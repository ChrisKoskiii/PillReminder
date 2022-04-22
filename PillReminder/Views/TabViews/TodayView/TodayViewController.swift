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
  let verticalStackView = UIStackView()
  let buttonStackView = UIStackView()
  let addItemButton = UIButton(type: .system)
  let menuButton = UIButton(type: .system)
  let titleLabel = UILabel()
  let newItemVC = NewItemViewController()
  
  var itemArray = [ItemToTake]()
  var todayCellViewModels: [TodayViewCell.ViewModel] = []
  
  var items: [NSManagedObject] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    newItemVC.delegate = self
    
    style()
    layout()
    setupTable()
    registerTableViewCells()
    reloadView()
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
    //1
    guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    let managedContext =
    appDelegate.persistentContainer.viewContext
    
    //2
    let fetchRequest =
    NSFetchRequest<NSManagedObject>(entityName: "Item")
    
    //3
    do {
      items = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
    self.configureTableCells(with: self.items)
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
    items.count
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
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return }
    guard editingStyle == .delete else { return }
    let itemToDelete = items.remove(at: indexPath.row)
    appDelegate.persistentContainer.viewContext.delete(itemToDelete)
    tableView.deleteRows(at: [indexPath], with: .automatic)
    
    do {
      try appDelegate.persistentContainer.viewContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
    
  }
  
  private func configureTableCells(with itemsToUse: [NSManagedObject]) {
    todayCellViewModels = itemsToUse.map {
      TodayViewCell.ViewModel(itemName: $0.value(forKey: "name") as! String, amount: $0.value(forKey: "amount") as! String, frequency: $0.value(forKey: "frequency") as! String, isDone: false)
    }
  }
}
extension TodayViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var myBool = items[indexPath.row].value(forKey: "isDone") as! Bool
    print(myBool)
    myBool = !myBool
    saveToCoreData()
    print(myBool)
  }
}

extension TodayViewController: NewItemViewControllerDelegate {
  func newItemCreated(_ newItem: ItemToTake) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
    
    let item = NSManagedObject(entity: entity, insertInto: managedContext)
    
    item.setValue(newItem.name, forKey: "name")
    item.setValue(newItem.amount, forKey: "amount")
    item.setValue(newItem.frequency, forKey: "frequency")
    item.setValue(newItem.isDone, forKey: "isDone")
    
    do {
      try managedContext.save()
      items.append(item)
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
    DispatchQueue.main.async {
      self.reloadView()
    }
  }
}

extension TodayViewController {
  private func saveToCoreData() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return }
    
    do {
      try appDelegate.persistentContainer.viewContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
}

