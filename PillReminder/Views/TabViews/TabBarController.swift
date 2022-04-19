//
//  TabBarController.swift
//  PillReminder
//
//  Created by Christopher Koski on 4/18/22.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.delegate = self
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let tabOne = TodayViewController()
    let tabOneBarItem = UITabBarItem(title: "Today", image: UIImage(systemName: "checklist"), tag: 0)
    tabOne.tabBarItem = tabOneBarItem
    
    let tabTwo = CalendarViewController()
    let tabTwoBarItem = UITabBarItem(title: "Calendar", image: UIImage(systemName: "calendar"), tag: 1)
    tabTwo.tabBarItem = tabTwoBarItem
    
    let tabThree = MedicationsViewController()
    let tabThreeBarItem = UITabBarItem(title: "Medications", image: UIImage(systemName: "pills"), tag: 2)
    tabThree.tabBarItem = tabThreeBarItem
    
    self.viewControllers = [tabOne, tabTwo, tabThree]
  }

}
