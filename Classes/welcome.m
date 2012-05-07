    //
//  welcome.m
//  defendEarth
//
//  Created by reynoldschristopher on 4/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "welcome.h"
#import "defendEarthAppDelegate.h"

@implementation welcome

- (void)goToView:sender {
	defendEarthAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSInteger i = [sender tag];
	[appDelegate displayView:i];
}

- (void)viewDidLoad {
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"metal-floor-with-stars.png"]]; 
	
    // begin a new game
	defendEarthAppDelegate *viewController = [[UIApplication sharedApplication] delegate];
	//[viewController game:1];
	
	UIButton *playView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	playView.frame = CGRectMake(40, 100, 240, 60);
    playView.titleLabel.font = [UIFont systemFontOfSize:26];
	[playView setTitle:@"Play" forState:UIControlStateNormal];
    [(UILabel *)playView setTag:4];
	[playView addTarget:self action:@selector(goToView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:playView];
	
    UIButton *switchView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	switchView.frame = CGRectMake(40, 180, 240, 60);
    switchView.titleLabel.font = [UIFont systemFontOfSize:26];
	[switchView setTitle:@"High Scores" forState:UIControlStateNormal];
    [(UILabel *)switchView setTag:3];
	[switchView addTarget:self action:@selector(goToView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:switchView];
	
    UIButton *settingsView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	settingsView.frame = CGRectMake(40, 260, 240, 60);
    settingsView.titleLabel.font = [UIFont systemFontOfSize:26];
	[settingsView setTitle:@"Settings" forState:UIControlStateNormal];
    [(UILabel *)settingsView setTag:2];
	[settingsView addTarget:self action:@selector(goToView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:settingsView];
	
	[super viewDidLoad];
    
    //NSLog(@"welcome screen loaded.");
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[super dealloc];
}

@end
