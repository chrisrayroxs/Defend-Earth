//
//  gamePlay.m
//  defendEarth
//
//  Created by reynoldschristopher on 4/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "gamePlay.h"
#import "defendEarthAppDelegate.h"
//#import "defendEarthViewController.h"

@implementation gamePlay

- (void)goToView:sender {
	defendEarthAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSInteger i = [sender tag];
	[appDelegate displayView:i];
}

- (void)viewDidLoad {
	
    //[partyDetails removeFromSuperview];

    // begin a new game
	defendEarthAppDelegate *viewController = [[UIApplication sharedApplication] delegate];
	[viewController game:0];

	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stars.png"]]; 
/*
	UIButton *btnTwo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	btnTwo.frame = CGRectMake(120, 420, 80, 30);
	[btnTwo setTitle:@"Give Up" forState:UIControlStateNormal];
    [(UILabel *)btnTwo setTag:5];
	[btnTwo addTarget:self action:@selector(goToView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnTwo];
*/
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[super dealloc];
}

@end

