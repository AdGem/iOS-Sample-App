//
//  ViewController.m
//  AdGem-ObjC
//
//  Created by Matthew Knippen on 2/20/19.
//  Copyright © 2019 AdGem LLC. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@import AdGemSdk;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;

/// Token for the coin-update observer, removed on dealloc.
@property (strong, nonatomic) id coinsObserver;

@end

@implementation ViewController

- (void)dealloc {
    if (_coinsObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:_coinsObserver];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.versionLabel.text = [NSString stringWithFormat:@"iOS - V%@", AdGem.sdkVersion];

    // Refresh the balance whenever a reward is granted, even while this screen
    // is already visible (the reward callback can land after viewDidAppear has
    // already run).
    __weak typeof(self) weakSelf = self;
    self.coinsObserver = [[NSNotificationCenter defaultCenter] addObserverForName:AdGemCoinsUpdatedNotification
                                                                          object:nil
                                                                           queue:[NSOperationQueue mainQueue]
                                                                      usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf refreshRewardLabel];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshRewardLabel];
}

- (void)refreshRewardLabel {
    NSInteger coins = [NSUserDefaults.standardUserDefaults integerForKey:@"coins"];
    self.rewardLabel.text = [NSString stringWithFormat:@"%ld coins", (long)coins];
}

- (IBAction)showOfferwallTapped:(id)sender {
    [AdGem showOfferwall];
}


@end
