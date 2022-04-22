//
//  CalenderViewController.swift
//  PillReminder
//
//  Created by Christopher Koski on 4/18/22.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
  
  var calendar = FSCalendar()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    calendar.delegate = self
    
    style()
    layout()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    calendar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 1.5 )
    calendar.frame = calendar.frame.inset(by: UIEdgeInsets(top: 40, left: 16, bottom: 16, right: 16))
  }
}

extension CalendarViewController {
  private func style() {
    
  }
  
  private func layout() {
    view.addSubview(calendar)
  }
}

extension CalendarViewController: FSCalendarDelegate {
  func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE MM-dd-YYYY"
    let string = formatter.string(from: date)
    print("\(string)")
  }
}
