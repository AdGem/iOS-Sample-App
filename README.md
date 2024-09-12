# iOS-Sample-App

A sample app demonstrating the integration and usage of the AdGem SDK for iOS.

## Project Structure

This repository contains two sample applications:

1. **Objective-C Sample App**
   - Located in the `Obj-C` directory
   - Project name: `AdGem-ObjC`

2. **Swift Sample App**
   - Located in the `Swift` directory
   - Project name: `AdGemTester`

## Setup Instructions

### Objective-C

1. Navigate to the `Obj-C` directory
2. Open `AdGem-ObjC.xcworkspace` in Xcode
3. Run `pod install` to install dependencies
4. Build and run the project

### Swift

1. Navigate to the `Swift` directory
2. Open `AdGemTester.xcworkspace` in Xcode
3. Run `pod install` to install dependencies
4. Build and run the project

## Basic Usage

The sample apps demonstrate how to integrate and use the AdGem SDK. Here's a basic overview of the integration process:

1. Import the AdGem SDK in your `AppDelegate`:

    ```swift
    import AdGemSdk
    ```

2. Implement the `AdGemDelegate` protocol in your `AppDelegate`:

    ```swift
    class AppDelegate: UIResponder, UIApplicationDelegate, AdGemDelegate {
      // ...
    }
    ```

3. Initialize the AdGem SDK in the `application(_:didFinishLaunchingWithOptions:)` method:

    ```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      AdGem.delegate = self
      AdGem.startSession(appId: YOUR_APP_ID, usesStandardVideo: false, usesRewardedVideo: true, usesOfferwall: true)
      return true
    }
    ```

4. Implement the required delegate methods to handle AdGem events:

    ```swift
    func adGemDidFinishingCaching() {
        // Handle caching completion
    }

    func adGemVideoAdStartedPlaying() {
        // Handle video ad start
    }

    func adGemVideoAdFinishedPlaying(cancelled: Bool) {
        // Handle video ad finish
    }

    func adGemVideoFailedToLoad(errorMessage: String) {
        // Handle video load failure
    }

    func adGemRewardUser(amount: Int) {
        // Handle user reward
    }

    func adGemOfferwallStartedLoading() {
        // Handle offerwall start
    }

    func adGemOfferwallFinishedLoading() {
        // Handle offerwall load completion
    }

    func adGemOfferwallFailedToLoad(error: Error) {
        // Handle offerwall load failure
    }

    func adGemOfferwallClosed() {
        // Handle offerwall close
    }
    ```

## Features Demonstrated

- Integration of AdGem SDK
- Handling of video ads (rewarded and standard)
- Implementation of offerwall functionality
- User reward management

## Requirements

- iOS 11.0+
- Xcode 12.0+
- Swift 5.0+ (for Swift project)

## Dependencies

The project uses CocoaPods for dependency management. The main dependency is:

- **AdGem SDK**

To install dependencies, run `pod install` in the respective project directories.
