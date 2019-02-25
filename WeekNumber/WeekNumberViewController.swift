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
	
	var extraFuncs = ExtraFunctions()
	
	let defaults = UserDefaults.standard
	

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
		weekRangeText.stringValue = "coming soon..."
		
		//print(dayRangeOf(weekOfMonth: weekOfMonth, year: year, month: month))
		//let dates = dayRangeOf(weekOfMonth: weekOfMonth, year: year, month: month)
		//let rangeText = String(format: "%02d --> %02d", startDate, endDate)
		//weekRangeText.stringValue = rangeText

    }
	
	
	
	@IBAction func showFullDate(_ sender: NSButton) {
		switch sender.state {
			case .on:
				print("1on")
				defaults.set(true, forKey: defaultsKeys.showFullDateKey)
			case .off:
				print("1off")
				defaults.set(false, forKey: defaultsKeys.showFullDateKey)
			case .mixed:
				print("1mixed")
			default: break
		}
	}
	
	@IBAction func time24(_ sender: NSButton) {
		switch sender.state {
			case .on:
				print("2on")
				defaults.set(true, forKey: defaultsKeys.time24Key)
			case .off:
				print("2off")
				defaults.set(false, forKey: defaultsKeys.time24Key)
			case .mixed:
				print("2mixed")
			default: break
		}
	}
	
	@IBAction func showTime(_ sender: NSButton) {
		switch sender.state {
			case .on:
				print("3on")
				defaults.set(true, forKey: defaultsKeys.showTimeKey)
			case .off:
				print("3off")
				defaults.set(false, forKey: defaultsKeys.showTimeKey)
			case .mixed:
				print("3mixed")
			default: break
		}
	}
	@IBAction func quitApp(_ sender: Any) {
		NSApplication.shared.terminate(self)
	}
	/*
	func dayRangeOf(weekOfMonth: Int, year: Int, month: Int) -> Range<Date>? {
		let calendar = Calendar.current
		guard let startOfMonth = calendar.date(from: DateComponents(year:year, month:month)) else { return nil }
		var startDate = Date()
		if weekOfMonth == 1 {
			var interval = TimeInterval()
			guard calendar.dateInterval(of: .weekOfMonth, start: &startDate, interval: &interval, for: startOfMonth) else { return nil }
		} else {
			let nextComponents = DateComponents(year: year, month: month, weekOfMonth: weekOfMonth)
			guard let weekStartDate = calendar.nextDate(after: startOfMonth, matching: nextComponents, matchingPolicy: .nextTime) else {
				return nil
			}
			startDate = weekStartDate
		}
		let endComponents = DateComponents(day:7, second: -1)
		let endDate = calendar.date(byAdding: endComponents, to: startDate)!
		return startDate..<endDate
	}
	*/
	

    
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

