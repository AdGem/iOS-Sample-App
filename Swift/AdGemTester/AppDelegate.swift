//
//  AppDelegate.swift
//  AdGemTester
//
//  Created by Matthew Knippen on 4/11/18.
//  Copyright © 2018 AdGem. All rights reserved.
//

import UIKit
import AdGemSdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AdGemDelegate {
  
  var window: UIWindow?
  
  internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    AdGem.delegate = self
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    let someDateTime = formatter.date(from: "2016/10/08 22:31")

    let id: String = {
      if let storedId = UserDefaults.standard.string(forKey: "AdGem-UserId") {
          return storedId
      } else {
          let newId = UUID().uuidString
          UserDefaults.standard.set(newId, forKey: "AdGem-UserId")
          return newId
      }
    }()

    let metaData = AdGemPlayerMetadata.Builder
      .initWithPlayerId(playerId: id)
      .playerAge(age: 20)
      .playerGender(gender: .male)
      .playerLevel(level: 5)
      .playerPlacement(place: 1000)
      .playerPayer(spentMoney: true)
      .playerIAPTotal(iapTotal: 10.0)
      .playerCreatedAt(creationDate: someDateTime!)
      .customField1(field: "custom_field_1")
      .customField2(field: "custom_field_2")
      .customField3(field: "custom_field_3")
      .customField4(field: "custom_field_4")
      .customField5(field: "custom_field_5")
      .build()

    AdGem.setPlayerMetaData(metaData: metaData)
      
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func offerwallRewardReceived(amount: Int) {
    print("AdGem Reward User from offerwall.")
    let coins = UserDefaults.standard.integer(forKey: "coins")
    
    UserDefaults.standard.set(coins + amount, forKey: "coins")
    UserDefaults.standard.synchronize()
  }
  
  func offerwallLoadingStarted() {
    print("AdGem Offerwall Started Loading.")
  }
  
  func offerwallLoadingFinished() {
    print("AdGem Offerwall Finished Loading.")
  }
  
  func offerwallLoadingFailed(error: Error) {
    print("AdGem Offerwall Failed to Load: \(error.localizedDescription)")
  }
  
  func offerwallClosed() {
    print("AdGem Offerwall Closed")
  }
  
  
}

