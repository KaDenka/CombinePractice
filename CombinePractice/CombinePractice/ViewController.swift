//
//  ViewController.swift
//  CombinePractice
//
//  Created by Denis Kazarin on 01.02.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let publisherLessonOne = NotificationCenter.default.publisher(for: Notification.testNotificationLessonOne)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            NotificationCenter.default.post(Notification(name: Notification.testNotificationLessonOne))
        }
    }


}

extension Notification {
    static var testNotificationLessonOne: Notification.Name {
        Notification.Name("testNotificationLessonOne")
    }
}

