//
//  WOSongPlayer.m
//  WalkOn
//
//  Created by Horace Williams on 2/19/15.
//  Copyright (c) 2015 WoracesWorkshop. All rights reserved.
//

#import "WOSongPlayer.h"

@implementation WOSongPlayer
+ (void)playSongOfName:(NSString *)name {

    NSURL *url = [NSURL URLWithString:[self serverUrl:(name)]];
    NSLog(@"url %@", url);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response
                                                     error:&error];
    if (error == nil) {
        NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"successs data: %@", message);
    } else {
        NSLog(@"error playing song: %@", error);
    }
}

+ (NSString *)serverUrl:(NSString *)name{
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:@"http://3d7d2602.ngrok.com/play?name="];
    [url appendString:name];
    return [url copy];
}


@end
