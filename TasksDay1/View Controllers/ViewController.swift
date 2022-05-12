//
//  ViewController.swift
//  TasksDay1
//
//  Created by Rehan Shah on 09/05/2022.
//

import UIKit
import NotificationCenter

class ViewController: UIViewController {
    
    var Array = [CoreDataTask]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Array = Database.shareinstance.GetData()
        
        
        
        //MARK:- Local Notification
        
        let notify = UNUserNotificationCenter.current()
        
        notify.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
            // TODO: Fetch notification settings
        }
        //Notification Content
        let content = UNMutableNotificationContent()
        content.title = Constant.notification_Title
        content.body = Constant.notification_Body
        //Notification Trigger
        let date = Date().addingTimeInterval(5)
        let datecomponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let triger = UNCalendarNotificationTrigger(dateMatching: datecomponent, repeats: false)
        
        let UStr = UUID().uuidString
        let request = UNNotificationRequest(identifier: UStr, content: content, trigger: triger)
        
        notify.add(request) { (_: Error?) in
            print("Done")
        }
        
        //MARK: - Crashlytics
        
//        fatalError()
        
        //   Database.shareinstance.DeleteAllData()
        
    }
    
    

    @IBAction func SaveData(_ sender: Any) {
        
        Database.shareinstance.DeleteAllData()
    }
    
    @IBAction func Apicall(_ sender: Any) {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ApiViewController") as! ApiViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    @IBAction func Animation(_ sender: Any) {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AnimationViewController") as! AnimationViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}

