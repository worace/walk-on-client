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

@end

@implementation ViewController
- (IBAction)playButton:(id)sender {
    NSLog(@"play the song by sending http req");
    [WOSongPlayer playSongOfName:@"juicy"];
}

- (IBAction)resetLastPlayed:(id)sender {
    [WOLastPlayedTracker backdateLastPlayed];
}
@end
