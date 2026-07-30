//
//  AppDelegate.h
//  AdGem-ObjC
//
//  Created by Matthew Knippen on 2/20/19.
//  Copyright © 2019 AdGem LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Posted whenever the stored coin balance changes so any visible screen can refresh.
extern NSString * const AdGemCoinsUpdatedNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

