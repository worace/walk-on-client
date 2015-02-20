//
//  WOLastPlayedTracker.m
//  WalkOn
//
//  Created by Horace Williams on 2/19/15.
//  Copyright (c) 2015 WoracesWorkshop. All rights reserved.
//

#import "WOLastPlayedTracker.h"

@implementation WOLastPlayedTracker

+ (void) initLastPlayed {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastPlayedTime"] == nil) {
        [self backdateLastPlayed];
    }
}
+ (BOOL)canPlay {
    NSComparisonResult compare = [[self lastPlayed] compare:[self fourHoursAgo]];
    if (compare == NSOrderedAscending) {
        return true;
    } else {
        return false;
    }
}

+ (NSDate *)lastPlayed {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastPlayedTime"];
}

+ (NSString *)formattedLastPlayed {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mma"];
    return [formatter stringFromDate:[self lastPlayed]];
}

+ (void)backdateLastPlayed {
    [[NSUserDefaults standardUserDefaults] setObject:[self fourHoursAgo] forKey:@"lastPlayedTime"];
}

+ (void)updateLastPlayed {
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"lastPlayedTime"];
}

+ (NSDate *)fourHoursAgo {
    NSTimeInterval interval = -(4*60*60); // 4 hours ago
    return [NSDate dateWithTimeIntervalSinceNow:interval];
}
@end
