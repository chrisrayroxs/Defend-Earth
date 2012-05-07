//
//  defendEarthViewController.h
//  defendEarth
//
//  Created by reynoldschristopher on 4/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CoreAnimation.h>
#import <AVFoundation/AVFoundation.h>

@interface defendEarthViewController : UIViewController {
	
	NSMutableArray *astroids; // stores the astroid images
	NSMutableArray *earthObject; // stores the astroid images
	//NSMutableArray *lives; // stores the Views representing remaining lives
	AVAudioPlayer *hitPlayer; // plays a sound when a astroid is touched
	AVAudioPlayer *missPlayer; // plays a sound when a astroid is missed
	AVAudioPlayer *disappearPlayer; // plays a sound when a astroid disappears
	int astroidsTouched; // number of astroids touched
	//int score; // current score
	//int level; // current level
	float drawTime; // how long each astroid remains on the screen
	BOOL gameOver; // has the game ended?
	UIImage *earthImage; // touched astroid image
	UIImage *touchedImage; // touched astroid image
	UIImage *untouchedImage; // untouched astroid image
	BOOL gameMode;
	
}
- (void) displayView:(int)intNewView;

- (void)game:(int)option; // starts a new game
- (void)addEarth; // adds a new astroid to the game
- (void)addNewastroid; // adds a new astroid to the game
- (int) rocketsNumbers; // counts rockets


// called when astroids disappear
- (void)finishedAnimation:(NSString *)animationId finished:(BOOL)finished context:(void *)context;
- (void)touchedastroid:(UIImageView *)astroid; // called when a astroid is touched

@end
