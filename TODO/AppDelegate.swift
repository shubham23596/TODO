//
//  AppDelegate.swift
//  TODO
//
//  Created by shubham jain on 03/05/18.
//  Copyright © 2018 shubham jain. All rights reserved.
//

import UIKit

import RealmSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       print(Realm.Configuration.defaultConfiguration.fileURL)
        do{
            let realm = try Realm()
        }catch{
            print("error in initialising realm\(error)")
        }
        return true
    }

   
 
    
    // MARK: - Core Data stack
    
   

}

