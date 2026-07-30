//
//  AppDelegate.m
//  AdGem-ObjC
//
//  Created by Matthew Knippen on 2/20/19.
//  Copyright © 2019 AdGem LLC. All rights reserved.
//

#import "AppDelegate.h"
@import AdGemSdk;

NSString * const AdGemCoinsUpdatedNotification = @"AdGemCoinsUpdated";


@interface AppDelegate () <AdGemDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1. Set the delegate and initialize the SDK as early as possible.
    //    initialize does not hit the network.
    AdGem.delegate = self;
    [AdGem initializeWithConfiguration:[[AdGemConfiguration alloc] initWithAppId:@"1"]];

    // Persist a stable player id across launches.
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    NSString *playerId = [defaults stringForKey:@"AdGem-UserId"];
    if (playerId == nil) {
        playerId = [[NSUUID UUID] UUIDString];
        [defaults setObject:playerId forKey:@"AdGem-UserId"];
    }

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm";
    NSDate *createdAt = [formatter dateFromString:@"2016/10/08 22:31"];

    // 2. Once the player's identity is known, build the metadata and set the
    //    player. This starts the session and makes the offerwall available.
    AdGemPlayerMetadata *metaData = [[[[[[[[[[[[[[[Builder alloc] initWithPlayerId:playerId]
        age:20]
        gender:AdGemGenderMale]
        level:5]
        placement:1000]
        isPayer:YES]
        iapTotalUsd:10.0]
        createdAt:createdAt]
        customField1:@"custom_field_1"]
        customField2:@"custom_field_2"]
        customField3:@"custom_field_3"]
        customField4:@"custom_field_4"]
        customField5:@"custom_field_5"]
        build];

    [AdGem setPlayer:metaData];

    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)offerwallClosed {
    NSLog(@"AdGem Offerwall Closed");
}

- (void)offerwallLoadingFailedWithError:(NSError * _Nonnull)error {
    NSLog(@"AdGem Offerwall Failed to Load: %@", error.localizedDescription);
}

- (void)offerwallLoadingFinished {
    NSLog(@"AdGem Offerwall Finished Loading.");
}

- (void)offerwallLoadingStarted {
    NSLog(@"AdGem Offerwall Started Loading.");
}

- (void)offerwallRewardReceivedWithAmount:(NSInteger)amount {
    NSLog(@"AdGem Reward User from offerwall.");
    NSInteger coins = [NSUserDefaults.standardUserDefaults integerForKey:@"coins"];
    [NSUserDefaults.standardUserDefaults setInteger:coins + amount forKey:@"coins"];
    // The reward can arrive after the offerwall has closed and the screen has
    // already appeared, so tell any visible screen to refresh its balance.
    [[NSNotificationCenter defaultCenter] postNotificationName:AdGemCoinsUpdatedNotification object:nil];
}

@end
