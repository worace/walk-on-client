//
//  ViewController.m
//  WalkOn
//
//  Created by Horace Williams on 2/19/15.
//  Copyright (c) 2015 WoracesWorkshop. All rights reserved.
//

#import "ViewController.h"
#import "WOSongPlayer.h"
#import "WOLastPlayedTracker.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lastPlayedLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [self renderLastPlayedTime];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self registerForSongPlayedNotif];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

- (void)registerForSongPlayedNotif {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(songPlayed)
                                                 name:@"WalkOnPlayedSong" object:nil];
}

- (void)songPlayed {
    NSLog(@"view controller received song played notif");
    [self renderLastPlayedTime];
}

- (void)renderLastPlayedTime {
    self.lastPlayedLabel.text = [WOLastPlayedTracker formattedLastPlayed];
}
- (IBAction)playButton:(id)sender {
    NSLog(@"play the song by sending http req");
    [WOSongPlayer playSongOfName:@"imperial_march"];
}

- (IBAction)resetLastPlayed:(id)sender {
    [WOLastPlayedTracker backdateLastPlayed];
    [self renderLastPlayedTime];
}
@end
