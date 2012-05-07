//
//  gameOver.m
//  defendEarth
//
//  Created by reynoldschristopher on 5/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "gameOver.h"
#import "defendEarthAppDelegate.h"

@implementation gameOver

- (void)goToView:sender {
	NSString *tempString=nameField.text;
	NSLog(@"Here is your NAME!!! %@",tempString);
	defendEarthAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSInteger i = [sender tag];
	[appDelegate displayView:i];
}

- (IBAction)end1:sender;
{		
    
	[nameField resignFirstResponder];	
	
	defendEarthAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate displayView:3];
	
}


- (void)viewDidLoad {
	defendEarthAppDelegate *ontroller = [[UIApplication sharedApplication] delegate];
	someNumber=[ontroller rocketsNumbers];


	UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(60, 60,200,40)];
	
	NSString* myNewString = [NSString stringWithFormat:@"%i", someNumber];
	;
	score.text = [NSString stringWithFormat:@"Your score was %@!", myNewString];
	score.font = [UIFont fontWithName:@"PartyLetPlain" size: 32];
	score.backgroundColor = [UIColor clearColor];
	score.shadowColor = [UIColor grayColor];
	score.shadowOffset = CGSizeMake(1,1);
	score.textColor = [UIColor redColor];
	score.textAlignment = UITextAlignmentCenter;
	[self.view addSubview:score];
	
	// begin a new game
	defendEarthAppDelegate *viewController = [[UIApplication sharedApplication] delegate];
    [viewController game:3]; // unset gameplay variable
	[viewController game:1]; // end game
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stars.png"]]; 
	
    // play again button
	UIButton *playAgain = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	playAgain.frame = CGRectMake(40, 200, 240, 60);
    playAgain.titleLabel.font = [UIFont systemFontOfSize:26];
	[playAgain setTitle:@"Play Again" forState:UIControlStateNormal];
    [(UILabel *)playAgain setTag:4];
	[playAgain addTarget:self action:@selector(goToView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:playAgain];
    
    
    // see high scores button
    UIButton *seeHighScores = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	seeHighScores.frame = CGRectMake(40, 280, 240, 60);
    seeHighScores.titleLabel.font = [UIFont systemFontOfSize:26];
    //[seeHighScores setBackgroundColor:[UIColor redColor]];
	[seeHighScores setTitle:@"High Scores" forState:UIControlStateNormal];
    [(UILabel *)seeHighScores setTag:3];
	[seeHighScores addTarget:self action:@selector(goToView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:seeHighScores];
    
    // back to home button
    UIButton *backToHome = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	backToHome.frame = CGRectMake(40, 360, 240, 60);
    backToHome.titleLabel.font = [UIFont systemFontOfSize:26];
	[backToHome setTitle:@"Main Menu" forState:UIControlStateNormal];
    [(UILabel *)backToHome setTag:1];
	[backToHome addTarget:self action:@selector(goToView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:backToHome];
	
	[super viewDidLoad];
    
    //NSLog(@"Loaded Game Over Screen");
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[super dealloc];
}

@end

