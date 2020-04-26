//
//  WeekNumberViewController.swift
//  WeekNumber
//
//  Created by Josh Fisher on 03/02/2019.
//  Copyright © 2019 Josh Fisher. All rights reserved.
//

import Cocoa


class WeekNumberViewController: NSViewController {

	@IBOutlet var weekNumberText: NSTextField!
	@IBOutlet var weekRangeText: NSTextField!

	@IBOutlet var popButton: NSButton!
	
	
	let defaults = UserDefaults.standard
	

	@IBOutlet var taskInputTxt: NSTextField!
	@IBOutlet var taskAddBtn: NSButton!
	
	
	@IBOutlet var taskListTable: NSTableView!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		
		
		
		let date = Date()
		let calendar = Calendar.current
		//let year = calendar.component(.year, from: date)
		//let month = calendar.component(.month, from: date)
		let weekOfYear = calendar.component(.weekOfYear, from: date)
		//let weekOfMonth = calendar.component(.weekOfMonth, from: date)
		//let seconds = calendar.component(.second, from: date)
		
		let btnText = String(format: "Week #%02d", weekOfYear)
		weekNumberText.stringValue = btnText
		
		
		let startWeek = Date().startOfWeek
		let endWeek = Date().endOfWeek
		
		let startday = Calendar.current.component(.day, from: startWeek ?? date)
		let finishday = Calendar.current.component(.day, from: endWeek ?? date)
		let startmonth = Calendar.current.component(.month, from: startWeek ?? date)
		let finishmonth = Calendar.current.component(.month, from: endWeek ?? date)
		let startyear = Calendar.current.component(.year, from: startWeek ?? date)
		let finishyear = Calendar.current.component(.year, from: endWeek ?? date)
		
		print(startWeek ?? "not found start date")
		print(endWeek ?? "not found end date")
		
		weekRangeText.stringValue = String(format: "%02d/%02d/%02d --> %02d/%02d/%02d", startday,startmonth,startyear,finishday,finishmonth,finishyear)

    }
	
	
	@IBAction func quitApp(_ sender: Any) {
		NSApplication.shared.terminate(self)
	}

}
extension WeekNumberViewController {
	// MARK: Storyboard instantiation
	static func freshController() -> WeekNumberViewController {
		//1.
		let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
		//2.
		let identifier = NSStoryboard.SceneIdentifier("WeekNumberViewController")
		//3.
		guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? WeekNumberViewController else {
			fatalError("Why cant i find WeekNumberViewController? - Check Main.storyboard")
		}
		return viewcontroller
	}
}

extension Date {
	var startOfWeek: Date? {
		let gregorian = Calendar(identifier: .gregorian)
		guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
		return gregorian.date(byAdding: .day, value: 1, to: sunday)
	}
	
	var endOfWeek: Date? {
		let gregorian = Calendar(identifier: .gregorian)
		guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
		return gregorian.date(byAdding: .day, value: 7, to: sunday)
	}
}

