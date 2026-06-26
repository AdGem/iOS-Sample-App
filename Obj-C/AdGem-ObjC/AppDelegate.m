//
//  AppDelegate.m
//  AdGem-ObjC
//
//  Created by Matthew Knippen on 2/20/19.
//  Copyright © 2019 AdGem LLC. All rights reserved.
//

#import "AppDelegate.h"
@import AdGemSdk;


@interface AppDelegate () <AdGemDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    AdGem.delegate = self;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm";
    NSDate *someDateTime = [formatter dateFromString:@"2016/10/08 22:31"];

    NSString *idString;

    if ([NSUserDefaults.standardUserDefaults stringForKey:@"AdGem-UserId"] != nil) {
      idString = [NSUserDefaults.standardUserDefaults stringForKey:@"AdGem-UserId"];
    } else {
      [NSUserDefaults.standardUserDefaults setObject:[[NSUUID UUID] UUIDString] forKey:@"AdGem-UserId"];
      [NSUserDefaults.standardUserDefaults synchronize];
    }

    AdGemPlayerMetadata *metaData = [[Builder initWithPlayerIdWithPlayerId:idString] build];
    [AdGem setPlayerMetaDataWithMetaData:metaData];

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
    [NSUserDefaults.standardUserDefaults synchronize];
}

@end
