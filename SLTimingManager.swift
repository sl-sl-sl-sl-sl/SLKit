//
//  SLTimingManager.swift
//  SLTimingTask
//
//  Created by zhenyu li on 2016/12/11.
//  Copyright © 2016年 zhenyu li. All rights reserved.
//

import Foundation


open class SLTimingTask: NSObject {
    
    public let identifier: String
    public let repeatTime: TimeInterval
    public let action: () -> Void
    public let queue: DispatchQueue
    public lazy var timer: DispatchSource = {
        let t = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(), queue: self.queue) as! DispatchSource
        t.scheduleRepeating(deadline: DispatchTime.now(), interval: DispatchTimeInterval.microseconds(Int(self.repeatTime * 1000 * 1000)), leeway: DispatchTimeInterval.milliseconds(100))
        t.setEventHandler(handler: DispatchWorkItem.init(block: { [weak self] in
            self?.action()
        }))
        return t
    }()
    
    open func suspend() {
        guard !self.timer.isCancelled else {
            print("\(self) timer isCancelled")
            return
        }
        self.timer.suspend()
    }
    
    open func resume() {
        guard !self.timer.isCancelled else {
            print("\(self) timer isCancelled")
            return
        }
        self.timer.resume()
    }
    
    open func cancel() {
        self.timer.cancel()
    }
    
    public init(identifier: String, repeatTime: TimeInterval, queue: DispatchQueue = DispatchQueue.main, _ action: @escaping () -> Void) {
        self.identifier = identifier
        self.repeatTime = repeatTime
        self.queue = queue
        self.action = action
        super.init()
    }
    
    deinit {
        print("\(self) deinit")
    }
    
}


open class SLTimingManager: NSObject {
    
    private static let shareManager = SLTimingManager()
    private lazy var tasks = [String : SLTimingTask]()
    
    private let syncQueue = DispatchQueue.init(label: "com.sltimingmanager.syncqueue", attributes: DispatchQueue.Attributes.concurrent)
    
    open func currentTasks() -> [String]? {
        var localTasks: [String : SLTimingTask]?
        syncQueue.async {
            localTasks = self.tasks
        }
        guard let lt = localTasks else {
            return nil
        }
        return Array(lt.keys)
    }
    
    open func addTask(_ task: SLTimingTask) {
        syncQueue.async(flags: .barrier, execute: {
            self.tasks[task.identifier] = task
            task.resume()
        })
    }
    
    open func getTask(_ identifier: String) -> SLTimingTask? {
        var localTask: SLTimingTask?
        syncQueue.async {
            localTask = self.tasks[identifier]
        }
        return localTask
    }
    
    open func cancelTask(_ identifier: String) {
        guard let task = self.getTask(identifier) else {
            print("\(self) do not exist this task \(identifier)")
            return
        }
        task.cancel()
        self.tasks[identifier] = nil
    }
    
    open static func addTask(_ task: SLTimingTask) {
        SLTimingManager.shareManager.addTask(task)
    }
    
    open static func getTask(_ identifier: String) -> SLTimingTask? {
        return SLTimingManager.shareManager.getTask(identifier)
    }
    
    open static func cancelTask(_ identifier: String) {
        return SLTimingManager.shareManager.cancelTask(identifier)
    }
    
    open static func addTask(_ identifier: String, repeatTime: TimeInterval, queue: DispatchQueue = DispatchQueue.main, _ action: @escaping () -> ()) {
        let task = SLTimingTask(identifier: identifier, repeatTime: repeatTime, queue: queue, action)
        SLTimingManager.shareManager.addTask(task)
    }
    
}


