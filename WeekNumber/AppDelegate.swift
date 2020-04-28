//
//  AppDelegate.swift
//  WeekNumber
//
//  Created by Josh Fisher on 03/02/2019.
//  Copyright © 2019 Josh Fisher. All rights reserved.
//

import Cocoa
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
	var statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
	var weekTimer = Timer()
	var eventMonitor: EventMonitor?
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		constructMenu();
		
		self.weekTimer = Timer.scheduledTimer(
			timeInterval: 1,
			target: self,
			selector: #selector(AppDelegate.updateWeekNumber(_:)),
			userInfo: nil,
			repeats: true
		);
		weekTimer.fire();
		
		if let statItem = statusItem.button {
			statItem.image = NSImage(named:NSImage.Name("CalendarImageButton"))
			statItem.imagePosition = NSControl.ImagePosition.imageLeft
			statItem.frame = CGRect(x: 0,y: -0.5, width: statItem.frame.width, height: statItem.frame.height);
		}
		
	}
	
	@objc func updateWeekNumber(_ sender: Any?) {
		let date = Date();
		let calendar = Calendar.current;
		let weekOfYear = calendar.component(.weekOfYear, from: date);
		self.statusItem.button!.title = String(format: " W#%02d", weekOfYear);
	}
	
	func constructMenu() {
		let menu = NSMenu();
		menu.addItem(NSMenuItem(
			title: "Quit",
			action: #selector(NSApplication.terminate(_:)),
			keyEquivalent: "q"
		));
		statusItem.menu = menu;
	}

}

