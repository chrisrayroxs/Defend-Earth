//
//  defendEarthAppDelegate.h
//  defendEarth
//
//  Created by reynoldschristopher on 4/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class defendEarthViewController;

@interface defendEarthAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    defendEarthViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet defendEarthViewController *viewController;

@end

