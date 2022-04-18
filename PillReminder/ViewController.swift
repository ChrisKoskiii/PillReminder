//
//  ViewController.swift
//  PillReminder
//
//  Created by Christopher Koski on 4/17/22.
//

import UIKit

class ViewController: UIViewController {

  private var myTable = UITableView()
  private var myArray = ["Vitamin C", "Alpha Brain", "Elderberry", "Fish Oil"]
  let previousDayButton = UIBarButtonItem()
  let nextDayButton = UIBarButtonItem()

  override func viewDidLoad() {
    super.viewDidLoad()

    style()
    layout()
  }
}

extension ViewController {
  func style() {
    let screenSize: CGRect = UIScreen.main.bounds
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height

    myTable.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
    myTable.dataSource = self
    myTable.delegate = self

    myTable.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")

    previousDayButton.image = UIImage(systemName: "arrow.backward")

    nextDayButton.image = UIImage(systemName: "arrow.forward")

    title = "Monday, Jan 4th"
    self.navigationItem.leftBarButtonItem = previousDayButton
    self.navigationItem.rightBarButtonItem = nextDayButton
  }

  func layout() {
    self.view.addSubview(myTable)
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    myArray.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
    cell.textLabel?.text = self.myArray[indexPath.row]
    return cell
  }


}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("User selected table row \(indexPath.row) and item \(myArray[indexPath.row])")
  }
}

