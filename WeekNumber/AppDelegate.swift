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
	
	
	let popover = NSPopover()
	let defaults = UserDefaults.standard
	
	var statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
	var weekTimer = Timer()
	var eventMonitor: EventMonitor?
	
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		
		//'ret' is true at this point

		self.weekTimer = Timer.scheduledTimer(
			timeInterval: 1,
			target: self,
			selector: #selector(AppDelegate.updateWeekNumber(_:)),
			userInfo: nil,
			repeats: true
		)
		weekTimer.fire()
		//constructMenu()
		
		if let statItem = statusItem.button {
			statItem.image = NSImage(named:NSImage.Name("CalendarImageButton"))
			statItem.imagePosition = NSControl.ImagePosition.imageLeft
			statItem.frame = CGRect(x: 0,y: -0.5, width: statItem.frame.width, height: statItem.frame.height)
			statItem.action = #selector(AppDelegate.togglePopover(_:))
		}
		
		popover.contentViewController = WeekNumberViewController.freshController()
		eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
			if let strongSelf = self, strongSelf.popover.isShown {
				strongSelf.closePopover(sender: event)
			}
		}
		
		
	}
	
	@objc func updateWeekNumber(_ sender: Any?) {
		let date = Date()
		let calendar = Calendar.current
		let weekOfYear = calendar.component(.weekOfYear, from: date)
		//let year = calendar.component(.year, from: date)
		//let month = calendar.component(.month, from: date)
		//let day = calendar.component(.day, from: date)
		//let hour = calendar.component(.hour, from: date)
		//let min = calendar.component(.minute, from: date)
		//let weekOfMonth = calendar.component(.weekOfMonth, from: date)
		//let seconds = calendar.component(.second, from: date)
		self.statusItem.title = String(format: " W#%02d", weekOfYear);
	}
	
	@objc func togglePopover(_ sender: Any?) {
		if popover.isShown {
			closePopover(sender: sender)
		} else {
			showPopover(sender: sender)
		}
	}
	
	func showPopover(sender: Any?) {
		if let button = statusItem.button {
			popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
		}
		eventMonitor?.start()
	}
	
	func closePopover(sender: Any?) {
		popover.performClose(sender)
		eventMonitor?.stop()
	}
	
	
	@IBAction func openAtLogin(_ sender: NSMenuItem) {
		// TODO
		
	}
	
	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
		
	}
	
	func constructMenu() {
		let menu = NSMenu()
		/*
		menu.addItem(NSMenuItem(
			title: "Open at login",
			action: #selector(AppDelegate.openAtLogin(_:)),
			keyEquivalent: ""
			
		))
		*/
		menu.addItem(NSMenuItem(
			title: "Quit",
			action: #selector(NSApplication.terminate(_:)),
			keyEquivalent: "q"
		))
		statusItem.menu = menu
	}

}

