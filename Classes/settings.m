    //
//  settings.m
//  defendEarth
//
//  Created by reynoldschristopher on 4/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "settings.h"
#import "defendEarthAppDelegate.h"

@implementation settings

- (void)goToView:sender {
	defendEarthAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSInteger i = [sender tag];
	[appDelegate displayView:i];
}

- (void)setDifficuly:sender {
    defendEarthAppDelegate *viewController = [[UIApplication sharedApplication] delegate];
    NSInteger i = [sender tag];
	[viewController game:i];
}

- (void)viewDidLoad {
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stars.png"]]; 
	UIButton *mainMenu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	mainMenu.frame = CGRectMake(40, 40, 240, 60);
    mainMenu.titleLabel.font = [UIFont systemFontOfSize:26];
	[mainMenu setTitle:@"Main Menu" forState:UIControlStateNormal];
    [(UILabel *)mainMenu setTag:1];
	[mainMenu addTarget:self action:@selector(goToView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:mainMenu];
    
    UIButton *easy = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	easy.frame = CGRectMake(40, 160, 240, 60);
    easy.titleLabel.font = [UIFont systemFontOfSize:26];
	[easy setTitle:@"Chill" forState:UIControlStateNormal];
    [(UILabel *)easy setTag:4];
	
	[easy addTarget:self action:@selector(setDifficuly:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:easy];
    
    UIButton *medium = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	medium.frame = CGRectMake(40, 230, 240, 60);
    medium.titleLabel.font = [UIFont systemFontOfSize:26];
	[medium setTitle:@"Moderate" forState:UIControlStateNormal];
    [(UILabel *)medium setTag:5];
	[medium addTarget:self action:@selector(setDifficuly:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:medium];

    UIButton *hard = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	hard.frame = CGRectMake(40, 300, 240, 60);
    hard.titleLabel.font = [UIFont systemFontOfSize:26];
	[hard setTitle:@"Apocalypse" forState:UIControlStateNormal];
    [(UILabel *)hard setTag:6];
	[hard addTarget:self action:@selector(setDifficuly:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:hard];
	
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
