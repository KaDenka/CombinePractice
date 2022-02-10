//
//  ViewController.swift
//  CombinePractice
//
//  Created by Denis Kazarin on 01.02.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        // MARK: Example One
        //
        //        let publisherLessonOne = NotificationCenter.default.publisher(for: Notification.testNotificationLessonOne, object: nil)
        //        let subscriberLessonOne = publisherLessonOne.sink { notification in
        //            print("Received \(notification.name.rawValue)")
        //        }
        //        NotificationCenter.default.post(name: Notification.testNotificationLessonOne, object: nil, userInfo: nil)
        //        subscriberLessonOne.cancel()
        //
        //        // MARK: Example Two
        //
        //        let publisherTwo = ["Hello Combine"].publisher
        //        let subscriberTwo = publisherTwo.sink { receivedValue in
        //            print("Received from publisherTwo: ", receivedValue)
        //        }
        //        subscriberTwo.cancel()
        
        //MARK: Lesson 2 Home work
        
        //Lesson 2 Stage 1
        
//        let publisherStageOne = (1...100).publisher
//        publisherStageOne
//            .filter { $0 > 49 && $0 < 71 }
//            .filter { $0 % 2 == 0 }
//            .collect()
//            .sink(receiveValue: { numbers in
//                print(numbers)
//            })
//            .store(in: &cancellables)
        
        //Lesson 2 Stage 2
        
//        let publisherStageTwo = ["1", "20", "A", "C", "50", "70", "100"].publisher
//        var total = 0
//        publisherStageTwo
//            .map { Double($0) ?? 0.0 }
//            .filter { $0 != 0.0 }
//            .scan(0, { lastNum, currentNum in
//                lastNum + currentNum
//            })
//            .sink { number in
//                total += 1
//                print("Current sum: \(number)")
//                print("Current iteration: \(total)")
//                print("Average = \(number / Double(total))\n")
//            }
//            .store(in: &cancellables)
        
   // MARK: - Lesson 3 Home Work
        
        let queue = DispatchQueue(label: "Collect")
        let publisherString = PassthroughSubject<String, Never>()
        
        queue.asyncAfter(deadline: .now() + 1.0, execute: {
            publisherString.send("Hello ")
            publisherString.send("world, ")
            publisherString.send("Combine!")
        } )
       
        
        publisherString
            .collect(.byTime(queue, .seconds(0.5)))
            .map(UnicodeScalar)
            .sink(receiveCompletion: { completion in
            print("received the completion", String(describing: completion)) }, receiveValue: { responseValue in
            print(responseValue)
            })
            .store(in: &cancellables)
       
    }
    
}

extension Notification {
    static var testNotificationLessonOne: Notification.Name {
        Notification.Name("testNotificationLessonOne")
    }
}

