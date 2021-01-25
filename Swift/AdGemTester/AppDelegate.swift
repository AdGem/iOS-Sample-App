//
//  AppDelegate.swift
//  AdGemTester
//
//  Created by Matthew Knippen on 4/11/18.
//  Copyright © 2018 AdGem. All rights reserved.
//

import UIKit
import AdGemSdk

let videosReadyNotification = Notification.Name(rawValue: "VideosReady")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AdGemDelegate {
  
  var window: UIWindow?
  
  internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    AdGem.delegate = self
    AdGem.startSession(appId: 1, usesStandardVideo: true, usesRewardedVideo: true, usesOfferwall: true)
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
  
  func adGemDidFinishingCaching() {
    print("AdGem Videos did Finish Caching")
    NotificationCenter.default.post(name: videosReadyNotification, object: nil)
  }
  
  func adGemVideoAdStartedPlaying() {
    print("AdGem Ad Started Playing")
  }
  
  func adGemVideoAdFinishedPlaying(cancelled: Bool) {
    print("AdGem Ad Finished Playing. Cancelled: \(cancelled)")
  }
  
  func adGemVideoFailedToLoad(errorMessage: String) {
    print("AdGem Ad Failed to Load: \(errorMessage)")
  }
  
  func adGemVideoDidClickAfterVideo() {
    print("AdGem Ad Did Click After Video")
    
  }
  
  func adGemRewardUser(amount: Int) {
    print("AdGem Reward User from offerwall.")
    let coins = UserDefaults.standard.integer(forKey: "coins")
    
    UserDefaults.standard.set(coins + amount, forKey: "coins")
    UserDefaults.standard.synchronize()
  }
  
  func adGemOfferwallStartedLoading() {
    print("AdGem Offerwall Started Loading.")
  }
  
  func adGemOfferwallFinishedLoading() {
    print("AdGem Offerwall Finished Loading.")
  }
  
  func adGemOfferwallFailedToLoad(error: Error) {
    print("AdGem Offerwall Failed to Load: \(error.localizedDescription)")
  }
  
  func adGemOfferwallClosed() {
    print("AdGem Offerwall Closed")
  }
  
  
}

