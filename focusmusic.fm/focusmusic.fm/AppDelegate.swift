//
//  AppDelegate.swift
//  focusmusic.fm
//
//  Created by Vitaliy Podolskiy on 05.04.2020.
//  Copyright © 2020 DEVLAB Studio, LLC. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let statusBarItem = NSStatusBar.system.statusItem(withLength: -2)
    let popover = NSPopover()

    var eventMonitor: EventMonitor?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.window.titlebarAppearsTransparent = true
        self.window.isMovableByWindowBackground = true

        window?.contentView?.superview?.subviews[1].subviews.last?.subviews[1].isHidden = true
        window?.contentView?.superview?.subviews[1].subviews.last?.subviews[2].isHidden = true

        if let button = statusBarItem.button {
            button.image = NSImage(named: "status-bar-icon")
            button.action = #selector(statusBarAction(_:))
        }

        popover.contentViewController = PopoverViewController(nibName: "PopoverViewController", bundle: nil)
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [unowned self] event in
            if self.popover.isShown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()

        dockAppearance()
    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }

    private func dockAppearance() {
        NSApp.setActivationPolicy(.accessory)
    }

    // MARK: - StatusBar Popover

    @objc func statusBarAction(_ sender: AnyObject) {
        if popover.isShown { closePopover(sender) } else {
            showPopover(sender)
        }
    }

    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }

    func showPopover(_ sender: AnyObject?) {
        if let button = statusBarItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
        eventMonitor?.start()
    }

}

