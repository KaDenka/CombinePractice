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
        
        let publisherStageOne = (1...100).publisher
        publisherStageOne
            .filter { $0 > 49 && $0 < 71 }
            .filter { $0 % 2 == 0 }
            .collect()
            .sink(receiveValue: { numbers in
                print(numbers)
            })
            .cancel()
        
        //Lesson 2 Stage 2
        
    }
    
}

extension Notification {
    static var testNotificationLessonOne: Notification.Name {
        Notification.Name("testNotificationLessonOne")
    }
}

