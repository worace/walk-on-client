//
//  WOLastPlayedTracker.h
//  WalkOn
//
//  Created by Horace Williams on 2/19/15.
//  Copyright (c) 2015 WoracesWorkshop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOLastPlayedTracker : NSObject
+ (void)initLastPlayed;
+ (NSString *)formattedLastPlayed;
+ (NSDate *)lastPlayed;
+ (void)updateLastPlayed;
+ (void)backdateLastPlayed;
+ (BOOL)canPlay;
@end
