//
//  AppDelegate.swift
//  AdGemTester
//
//  Created by Matthew Knippen on 4/11/18.
//  Copyright © 2018 AdGem. All rights reserved.
//

import UIKit
import AdGemSdk

extension Notification.Name {
  /// Posted whenever the stored coin balance changes so any visible screen can refresh.
  static let adGemCoinsUpdated = Notification.Name("AdGemCoinsUpdated")
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AdGemDelegate {

  var window: UIWindow?

  internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // 1. Set the delegate and initialize the SDK as early as possible.
    //    initialize() does not hit the network.
    AdGem.delegate = self
    AdGem.initialize(configuration: AdGemConfiguration(appId: "1"))

    // Persist a stable player id across launches.
    let playerId: String = {
      if let storedId = UserDefaults.standard.string(forKey: "AdGem-UserId") {
          return storedId
      }
      let newId = UUID().uuidString
      UserDefaults.standard.set(newId, forKey: "AdGem-UserId")
      return newId
    }()

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    let createdAt = formatter.date(from: "2016/10/08 22:31") ?? Date()

    // 2. Once the player's identity is known, build the metadata and set the
    //    player. This starts the session and makes the offerwall available.
    let metaData = AdGemPlayerMetadata.Builder(playerId: playerId)
      .age(20)
      .gender(.male)
      .level(5)
      .placement(1000)
      .isPayer(true)
      .iapTotalUsd(10.0)
      .createdAt(createdAt)
      .customField1("custom_field_1")
      .customField2("custom_field_2")
      .customField3("custom_field_3")
      .customField4("custom_field_4")
      .customField5("custom_field_5")
      .build()

    AdGem.setPlayer(metaData)

    return true
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func offerwallRewardReceived(amount: Int) {
    print("AdGem Reward User from offerwall.")
    let coins = UserDefaults.standard.integer(forKey: "coins")
    UserDefaults.standard.set(coins + amount, forKey: "coins")
    // The reward can arrive after the offerwall has closed and the screen has
    // already appeared, so tell any visible screen to refresh its balance.
    NotificationCenter.default.post(name: .adGemCoinsUpdated, object: nil)
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

