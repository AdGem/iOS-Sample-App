//
//  ViewController.m
//  AdGem-ObjC
//
//  Created by Matthew Knippen on 2/20/19.
//  Copyright © 2019 AdGem LLC. All rights reserved.
//

#import "ViewController.h"
@import AdGem;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *standardVideoButton;
@property (weak, nonatomic) IBOutlet UIButton *rewardedVideoButton;

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.versionLabel.text = [NSString stringWithFormat:@"iOS - V%@", AdGem.sdkVersion];

    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(videosReady) name:@"VideosReady" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    int coins = (int)[NSUserDefaults.standardUserDefaults integerForKey:@"coins"];
    self.rewardLabel.text = [NSString stringWithFormat:@"%i coins", coins];
}

- (void)videosReady {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.standardVideoButton.hidden = NO;
        self.rewardedVideoButton.hidden = NO;
    });
}

- (IBAction)showOfferwallTapped:(id)sender {
    [AdGem showOfferWall];
}

- (IBAction)showStandardVideoTapped:(id)sender {
    [AdGem showVideoAd];
}

- (IBAction)showRewardedVideoTapped:(id)sender {
    [AdGem showRewardedVideoAd];
}

@end
