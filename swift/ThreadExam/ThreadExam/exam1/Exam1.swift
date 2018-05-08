//
//  Exam1.swift
//  ThreadExam
//
//  Created by dfang on 2018-5-7.
//  Copyright © 2018年 east. All rights reserved.
//

import Foundation

class Exam1 {
    let conditionLock:NSConditionLock = NSConditionLock.init(condition: 0)
    let threadCount = 3
    let max = 10
    
    let threadName = ["A", "B", "C"]
    let semaphores = [DispatchSemaphore.init(value: 1), DispatchSemaphore.init(value: 0), DispatchSemaphore.init(value: 0)]
    
    class func start() {
//        Exam1.init().printABCThread()
//        Exam1.init().printABCGcd()
        Exam1.init().printABCOperation()
    }
    
    // 使用Operation输出ABC
    func printABCOperation() {
        let oQueue = OperationQueue.init()
        for i in 0..<threadCount {
            oQueue.addOperation({
                for j in 0..<self.max {
                    self.conditionLock.lock(whenCondition: i)
//                    self.semaphores[i].wait()
                    print(self.threadName[i], j, Thread.current)
                    self.conditionLock.unlock(withCondition: (i + 1) % self.threadName.count)
//                    self.semaphores[(i+1)%self.semaphores.count].signal()
                }
            })
        }
    }
    
    // 使用GCD输出ABC
    func printABCGcd() {
        for i in 0..<threadCount {
//            Thread.sleep(forTimeInterval: 1)
            DispatchQueue.init(label: threadName[i]).async {
                for j in 0..<self.max {
//                    self.conditionLock.lock(whenCondition: i)
                    self.semaphores[i].wait()
                    print(self.threadName[i], j, Thread.current)
//                    self.conditionLock.unlock(withCondition: (i + 1) % self.threadName.count)
                    self.semaphores[(i+1)%self.semaphores.count].signal()
                }
            }
        }
    }
    
    // 开启三个线程依次输出ABC
    func printABCThread() {
        for i in 0..<threadCount {
            let thread = Thread.init(target: self, selector:#selector(printCurThreadName(tname:)), object: threadName[i])
            thread.name = threadName[i]
            thread.start()
        }
        
        /**
        let threadA = Thread.init(target: self, selector: #selector(printA), object: nil)
        threadA.name = "A"
        threadA.start()
        
        let threadB = Thread.init(target: self, selector: #selector(printB), object: nil)
        threadB.name = "B"
        threadB.start()
        
        let threadC = Thread.init(target: self, selector: #selector(printC), object: nil)
        threadC.name = "C"
        threadC.start()
         */
    }
    
    @objc func printCurThreadName(tname: String) {
//        Thread.sleep(forTimeInterval: 1)
//        print(tname)
        let threadIndex = threadName.index(of: tname)!
        for i in 0..<max {
            conditionLock.lock(whenCondition: threadIndex)
            print(i, Thread.current)
            conditionLock.unlock(withCondition: (threadIndex + 1) % threadName.count)
        }
    }
   
    /**
    @objc func printA() {
//        Thread.sleep(forTimeInterval: 1)
        for i in 0..<max {
            conditionLock.lock(whenCondition: 0)
            print(i, Thread.current)
            conditionLock.unlock(withCondition: 1)
        }
    }
    
    @objc func printB() {
//        Thread.sleep(forTimeInterval: 1)
        for i in 0..<max {
            conditionLock.lock(whenCondition: 1)
            print(i, Thread.current)
            conditionLock.unlock(withCondition: 2)
        }
    }
    
    @objc func printC() {
//        Thread.sleep(forTimeInterval: 1)
        for i in 0..<max {
            conditionLock.lock(whenCondition: 2)
            print(i, Thread.current)
            conditionLock.unlock(withCondition: 0)
        }
    }
 */
}
