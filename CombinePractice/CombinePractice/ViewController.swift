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
        
        let subject: [(TimeInterval, String)] = [
            (0.0, "H"),
            (0.1, "He"),
            (0.2, "Hel"),
            (0.3, "Hell"),
            (0.5, "Hello"),
            (0.6, "Hello "),
            (2.0, "Hello W"),
            (2.1, "Hello Wo"),
            (2.2, "Hello Wor"),
            (2.4, "Hello Worl"),
            (2.5, "Hello World")
        ]
        
        let queue = DispatchQueue(label: "Collect")
        let publisher = PassthroughSubject<String, Never>()
        
        let subscriberString = publisher
            .collect(.byTime(queue, .seconds(0.5)))
            .sink(receiveCompletion: { completion in
                print("String Subscriber received the completion ", String(describing: completion)) },
                  receiveValue: { responseValue in
                print("String Subscriber received: \(responseValue)") })
            .store(in: &cancellables)
        
        let subscriberEmoji = publisher
            .debounce(for: .seconds(0.9) , scheduler: queue)
            .share()
            .sink(receiveCompletion: { completion in
                print("Emoji Subscriber received the completion", String(describing: completion)) },
                  receiveValue: { responseValue in
                print("Emoji subscriber received: \(responseValue)") })
            .store(in: &cancellables)
        
        for item in subject {
            queue.asyncAfter(deadline: .now() + item.0) {
                publisher.send(item.1)
            }
        }
        queue.asyncAfter(deadline: .now() + subject.last!.0 + 2) {
            publisher.send(completion: .finished)
        }
    }
    
}

extension Notification {
    static var testNotificationLessonOne: Notification.Name {
        Notification.Name("testNotificationLessonOne")
    }
}

