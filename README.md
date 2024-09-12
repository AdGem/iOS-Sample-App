# iOS-Sample-App
A sample app of the AdGem SDK

Download
--------
Install CocoaPods (v1.9 or newer). You can find more information on how to install CocoaPods [here](https://guides.cocoapods.org/using/getting-started.html)
Edit your Podfile and add the following line:
```
pod 'AdGem'
```
Run `pod install` in your terminal window. Cocoa pods will automatically download the framework and install it into your project.

Configure
--------
Add a new **AdGemAppID** key to the app's `Info.plist` file replacing **ADGEM_APP_ID** with your AdGem app ID from the AdGem publisher dashboard.
```
<key>AdGemAppID</key>
<integer>ADGEM_APP_ID</integer>
```
API Overwiev
--------
All communication with the SDK happens via the **AdGem** class. In order to access it the following import directive is required:
```
import AdGemSdk
```
Please note there is no need to store instance of AdGem globally. The SDK will cache its instance on a first call and will always return the same one for all subsequent calls to AdGem

### Player Metadata:
For increased fraud protection, we require you set the playerId (a unique id for your user) parameter.
```swift
  let metaData = AdGemPlayerMetadata.Builder
    .initWithPlayerId(playerId: "abc123")
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
```
### Offer Wall:
Use the AdGem class to show Offer Wall in your project:
```swift
AdGem.showOfferwall()
```

The following delegate methods are available:
```swift
// Called when the offer wall starts loading on the users device:
func offerwallLoadingStarted() {}
// Called when the offer wall has finished loading on the users device:
func offerwallLoadingFinished() {}
// Called when the offer wall has closed on the users device:
func offerwallClosed() {}
// Called if the offer wall has failed to load due to an error:
func offerwallLoadingFailed(error: Error) {}
// Called to reward the user with your type of currency:
func offerwallRewardReceived(amount: Int) {}
```