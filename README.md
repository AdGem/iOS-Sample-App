# iOS-Sample-App

[![Build/Tests](https://github.com/AdGem/iOS-Sample-App/actions/workflows/build.yml/badge.svg)](https://github.com/AdGem/iOS-Sample-App/actions/workflows/build.yml)
[![Release](https://github.com/AdGem/iOS-Sample-App/actions/workflows/release.yml/badge.svg)](https://github.com/AdGem/iOS-Sample-App/actions/workflows/release.yml)
[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

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

Both sample apps consume the AdGem SDK via Swift Package Manager. Xcode resolves
the package automatically on open — there is no separate install step.

### Objective-C

1. Navigate to the `Obj-C` directory
2. Open `AdGem-ObjC.xcodeproj` in Xcode
3. Wait for Xcode to resolve the Swift package dependencies
4. Build and run the project

### Swift

1. Navigate to the `Swift` directory
2. Open `AdGemTester.xcodeproj` in Xcode
3. Wait for Xcode to resolve the Swift package dependencies
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

- iOS 15.0+
- Xcode 14.0+
- Swift 5.0+ (for Swift project)

## Dependencies

The project uses Swift Package Manager for dependency management. The main dependency is:

- **AdGem SDK** — [`github.com/AdGem/ios-sdk-package`](https://github.com/AdGem/ios-sdk-package)

As a dogfooding demo app, both projects track the SDK package's `main` branch so
they always build against the latest AdGem SDK. Xcode resolves the package
automatically when you open either project; `Package.resolved` is intentionally
not committed so each build picks up the newest release.
