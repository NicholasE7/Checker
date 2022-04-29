//
//  AppDelegate.swift
//  Checker
//
//  Created by Nicholas Els on 2022/04/26.
//

import UIKit

import Realm
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var WIndow : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        print(Realm.Configuration.defaultConfiguration.encryptionKey)
        

        do{
        
        let realm = try Realm()
        }catch{
            print("Error initialising new realm, \(error)")
        }
        
        return true
    }
    
   
}
    
    
    


