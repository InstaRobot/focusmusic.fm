//
//  EventMonitor.swift
//  focusmusic.fm
//
//  Created by Vitaliy Podolskiy on 05.04.2020.
//  Copyright © 2020 DEVLAB Studio, LLC. All rights reserved.
//

import Cocoa

final class EventMonitor {

    private var monitor: AnyObject?
    private let mask: NSEvent.EventTypeMask
    private let handler: (NSEvent?) -> ()

    init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> ()) {
        self.mask = mask
        self.handler = handler
    }

    deinit {
        stop()
    }

    func start() {
        self.monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler) as AnyObject?
    }

    func stop() {
        if let monitor = monitor {
            NSEvent.removeMonitor(monitor)
            self.monitor = nil
        }
    }

}
