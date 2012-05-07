//
//  defendEarthViewController.m
//  defendEarth
//
//  Created by reynoldschristopher on 4/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

static const int EARTH_RADIUS = 80;
#define radianConst M_PI/180.0
#import "defendEarthViewController.h"

// you have to import the header files for
// any views that this parent controls
#import "welcome.h"
#import "settings.h"
#import "highScore.h"
#import "gamePlay.h"
#import "gameOver.h"

@implementation defendEarthViewController

UIViewController  *currentView;

//init gameplay
BOOL gameplay = FALSE;
BOOL globeSet = FALSE;
int gameDifficulty = 0;
int BALL_RADIUS = 30;
int hitCount = 0;

- (void) displayView:(int)intNewView {
	[currentView.view removeFromSuperview];
	[currentView release];
	switch (intNewView) {
		case 1:
			currentView = [[welcome alloc] init];
			break;
		case 2:
			currentView = [[settings alloc] init];
			break;
		case 3:
			currentView = [[highScore alloc] init];
			break;
		case 4:
			currentView = [[gamePlay alloc] init];
			break;
		case 5:
			currentView = [[gameOver alloc] init];
			break;
	}
	
	[self.view addSubview:currentView.view];
}


// enum for detecting touched astroids
enum TouchConstants { NOT_TOUCHED, TOUCHED };

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
// called when the view finishes loading
- (void)viewDidLoad
{
	
	// display Welcome screen
	currentView = [[welcome alloc] init];
	[self.view addSubview:currentView.view];
	
	[super viewDidLoad]; // pass the message to the superclass
	srandom(time(0)); // seed random number generation
	astroids = [[NSMutableArray alloc] init]; // initialize astroids
	earthObject = [[NSMutableArray alloc] init]; // initialize earth object
	//lives = [[NSMutableArray alloc] init]; // initialize lives
	
	// initialize the gameplay images
	earthImage = [UIImage imageNamed:@"globe.png"];
	touchedImage = [UIImage imageNamed:@"explosion.png"];
	
	
	// get the path of the sound file
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"explosion_1" ofType:@"wav"];
	
	// create a URL with the given path
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundPath];
	
	// initialize the AVAudioPlayer with the sound file
	hitPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL
													   error:nil];
	hitPlayer.volume = 0.3; // set hitPlayer's volume
	
	// get the path of the sound file
	soundPath = [[NSBundle mainBundle] pathForResource:@"miss" ofType:@"wav"];
	
	// create a URL with the given path
	[fileURL release];
	fileURL = [[NSURL alloc] initFileURLWithPath:soundPath];
	
	// initialize the AVAudioPlayer with the sound file
	missPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL
														error:nil];
	missPlayer.volume = 0.7; // set missPlayer's volume
	
	// get the path of the sound file
	soundPath =  [[NSBundle mainBundle] pathForResource:@"disappear" ofType:@"wav"];
	
	// create a URL with the given path
	[fileURL release];
	fileURL = [[NSURL alloc] initFileURLWithPath:soundPath];
	
	// initialize the AVAudioPlayer with the sound file
	disappearPlayer =
	[[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
	disappearPlayer.volume = 0.3; // set disappearPlayer's volume
	[fileURL release]; // release the fileURL NSURL
	
	
} // end method viewDidLoad

// removes old objects and begins a new game
- (void)game:(int)option
{   
    //start a new game
    if (option == 0){
        //set gameplay variable
        gameplay = TRUE;
        hitCount = 0; //reset hitcount
        [astroids removeAllObjects]; // empty the array of astroids
        
        drawTime = 6.0; // reset the draw time
        astroidsTouched = 0; // reset the number of astroids touched
		
        NSTimeInterval delay = 1;
        
        if (gameDifficulty == 3) {
			untouchedImage = [UIImage imageNamed:@"asteroid3.png"];
			BALL_RADIUS = 50;
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay*2];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay*2];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay*2];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay];
		}
		
        else if (gameDifficulty == 2) {
			untouchedImage = [UIImage imageNamed:@"asteroid2.png"];
			BALL_RADIUS = 70;
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay*2];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay*2];
        }
        
        else {
			untouchedImage = [UIImage imageNamed:@"asteroid1.png"];
			BALL_RADIUS = 100;
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay*2];
			[self performSelector:@selector(addNewastroid) withObject:nil afterDelay:delay];
		}
		
    }
	
    //end game
    else if(option == 1){
        //[NSObject cancelPreviousPerformRequestsWithTarget:astroids];
        [astroids removeAllObjects]; // empty the array of astroids
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(addNewastroid) object:nil];
        //[NSObject cancelPreviousPerformRequestsWithTarget:self];
		globeSet = FALSE;
        NSLog(@"end Game");
    }
    
    //add more astroids because one was just tapped
	else if(option == 2 && gameplay){
		[self addNewastroid];
	}
    
    //unset gameplay variable
    else if(option == 3){
        gameplay = FALSE;
	}
    
    //set game difficulty
    else if(option == 4){
        gameDifficulty = 1;
        NSLog(@"game difficulty switched to 1");
	}
	
    //set game difficulty
    else if(option == 5){
        gameDifficulty = 2;
        NSLog(@"game difficulty switched to 2");
	}
	
    //set game difficulty
    else if(option == 6){
        gameDifficulty = 3;
        NSLog(@"game difficulty switched to 3");
	}
	
} // end method game

-(int) rocketsNumbers {
	NSLog(@"The function was called!");
	return astroidsTouched;
}


// put the earth in the center of the screen!
- (void)addEarth
{
	// get the view width and height
	float viewWidth = self.view.bounds.size.width;
	float viewHeight = self.view.bounds.size.height;
	
	float x = viewWidth/2;
	float y = viewHeight/2;
	
	// create a new astroid
	UIImageView *earth = [[UIImageView alloc] initWithImage:earthImage]; 
	[earthObject addObject:earth]; // add the earth to the earthObject NSMutableArray
	[self.view addSubview:earth]; // add the Object to the main view
	
	// set the frame of variable astroid with the random coordinates
	[earth setFrame:CGRectMake(x-EARTH_RADIUS, y-EARTH_RADIUS, EARTH_RADIUS * 2, EARTH_RADIUS * 2)];
	
	//NSLog(@"x = %f", x);
	//NSLog(@"y = %f", y);
	
	[earth release]; // release the astroid UIImageView
	NSLog(@"added globe");
	
} // end method addEarth


/*
 //rotate image
 -(void) rotateImage:(float)angleRadians{
 
 self.transform = CGAffineTransformMakeRotation(angleRadians);
 CATransform3D rotatedTransform = self.layer.transform;
 self.layer.transform = rotatedTransform;    
 }
 */

// adds a new astroid at a random location
- (void)addNewastroid
{
	//add globe
	if(!globeSet){
		[self addEarth];
		globeSet = TRUE;
	}
	
	// get the view width and height
	float viewWidth = self.view.bounds.size.width;
	float viewHeight = self.view.bounds.size.height;
	
	// pick random coordinates inside the view
    int x, y;
    
    if ((arc4random() % (int)10) <= 5) {
        x = arc4random() % 320;
        y = BALL_RADIUS*2;
        if ((arc4random() % (int)10) <= 5) {
            y += 480;
        }
        else {
            y *= -1;
        }
    }
    else {
        x = BALL_RADIUS*2;
        y = arc4random() % 480;
        if ((arc4random() % (int)10) <= 5) {
            x += 320;
        }
        else {
            x *= -1;
        }
    }
	
    //int y = (480+BALL_RADIUS) + arc4random() % ((520+BALL_RADIUS) - (480+BALL_RADIUS));
    
    
    
	//float x = arc4random() % 160;
	//float y = arc4random() % 240;
    /*
	 if((320 - x) > 0)
	 x = x + ((320 - x) + BALL_RADIUS);
	 if((480 - y) > 0)
	 y = y + ((480 - y) + BALL_RADIUS);
	 */  
	NSLog(@"x = %i, y = %i", x, y);
	//160, 240
    
    //quad 1
	//float x = 20;
	//float y = 30;
    //quad 2
    //float x = 200;
	//float y = 30;
    //quad 3
    //float x = 20;
	//float y = 260;
    //quad 4
    //float x = 200;
	//float y = 260;
	
	// create a new astroid
	UIImageView *astroid = [[UIImageView alloc] initWithImage:untouchedImage]; 
	[astroids addObject:astroid]; // add the astroid to the astroids NSMutableArray
	[self.view addSubview:astroid]; // add the astroid to the main view
	
	//get angle of astroid towards the center of the view
	float x1 = viewWidth/2;
	float y1 = viewHeight/2 +10;
	
	float x2 = x1 - x;
	float y2 = y1 - y;
	
	float adj = abs(y2);
	float opp = abs(x2);
	float hyp = abs(sqrt(adj*adj + opp*opp));
	float angle = ((sin(hyp/opp)));
	
	/*
	 NSLog(@"adj = %f", adj);
	 NSLog(@"opp = %f", opp);
	 NSLog(@"hyp = %f", hyp);
	 */
    float varAngle = (angle*180)/M_PI;
    //varAngle /= 180;
	NSLog(@"angle in Degrees: = %f", (angle*180)/M_PI);
    //NSLog(@"angle2 = %f", angle);
	
	//set point of rotation
	NSLog(@"adj = %f", adj);
	NSLog(@"opp = %f", opp);
    NSLog(@"hyp = %f", hyp);
    NSLog(@"angle1 = %f", angle);
	
	//NSLog(@"x = %f, viewWidth = %f, y = %f, viewHeight = %f", x,viewWidth/2,y,viewHeight/2);
	//first quadrant
	if(x < viewWidth/2 && y < viewHeight/2){
		NSLog(@"astroid is in Q1");
		varAngle += 90;
	}
	//second quadrant
	if(x > viewWidth/2 && y < viewHeight/2){
		NSLog(@"astroid is in Q2");
		varAngle *= -1;
        varAngle += 90;
	}
	//third quadrant
	if(x < viewWidth/2 && y > viewHeight/2){
		NSLog(@"astroid is in Q3");
		//varAngle = (varAngle * -1) + 90;
	}
	//fourth quadrant
	if(x > viewWidth/2 && y > viewHeight/2){
		NSLog(@"astroid is in Q4");
		varAngle *= -1;
	}
    
    /*
     //animation
	 [UIView beginAnimations:nil context:NULL];
	 [UIView setAnimationDuration:2];
	 // other animations goes here
	 astroid.transform = CGAffineTransformMakeRotation(M_PI*1);
	 // other animations goes here
	 [UIView commitAnimations];
	 */
    
	//rotate astroid towards the center of the screen
    astroid.center = CGPointMake(x+67, y+67);
    //[astroid.layer setAnchorPoint:CGPointMake(x,y)];
    //varAngle = 2;
	//astroid.transform = CGAffineTransformMakeRotation(M_PI * varAngle / 180);
    //astroid.transform = CGAffineTransformRotate(astroid.transform, angle);
	//NSLog(@"");
	
	// set the frame of variable astroid with the random coordinates
	[astroid setFrame:CGRectMake(x, y, BALL_RADIUS * 2, BALL_RADIUS * 2)];
	astroid.tag = NOT_TOUCHED; // indicate that the astroid has not been touched
	
	// delay beginning animation to give the astroid time to redraw
	[self performSelector:@selector(beginastroidAnimation:) withObject:astroid afterDelay:0.5];
	
	[astroid release]; // release the astroid UIImageView
} // end method addNewastroid

// start the animation of the given astroid
- (void)beginastroidAnimation:(UIImageView *)astroid
{
	// get the width and height of view
	float viewWidth = [self.view bounds].size.width;
	float viewHeight = [self.view bounds].size.height;
	
	// pick random coordinates inside the view
	float x = viewWidth/2;//random() % (int)(viewWidth - 2 * BALL_RADIUS);
	float y = viewHeight - 2 * BALL_RADIUS ; //random() % (int)(viewHeight - 2 * BALL_RADIUS);
	
	[UIView beginAnimations:nil context:astroid]; // begin the animation block
	[UIView setAnimationDelegate:self]; // set the delegate as this object
	
	// call the given method of the delegate when the animation ends
	[UIView setAnimationDidStopSelector:  @selector(finishedAnimation:finished:context:)];
	[UIView setAnimationDuration:drawTime]; // set the animation length
	
	// make the animation start slow and speed up
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	//[UIView setAnimationCurve:UIViewAnimationTransitionCurlDown];
	//[UIView setAnimationCurve:??];
    
    //assign a random drift affect to astroid animation
    float ran = random() % 2;
    astroid.transform = CGAffineTransformMakeRotation(M_PI*ran);	
	// set the ending location of the astroid
	[astroid setFrame:CGRectMake(viewWidth/2, viewHeight/2, 5, 5)];
	
	[UIView commitAnimations]; // end the animation block
} // end method beginastroidAnimation:

// method is called when the player touches the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	BOOL hitastroid = NO; // initialize hitastroid
	
	for (UITouch *touch in touches) // loop through all the new touches
	{
		// get the location of the touch in the main view
		CGPoint point = [touch locationInView:self.view];
		
		// loop through all the astroids to check if the player hit any;
		// iterate backwards so foreground astroids get checked first
		for (int i = astroids.count - 1; i >= 0 && !hitastroid; i--)
		{
			UIImageView *astroid = [astroids objectAtIndex:i];
			
			// We need to get the current location of astroid, but the frame
			// of astroid is already set to its ending location. To get the
			// displayed frame, we need to access the Core Animation layer.
			CGRect frame = [[astroid.layer presentationLayer] frame];
			
			// compute the point at the center of the astroid
			CGPoint origin = CGPointMake(frame.origin.x + frame.size.width /
										 2, frame.origin.y + frame.size.height / 2);
			
			// compute the distance between the astroid's center and the touch
			float distance = pow(origin.x - point.x, 2) + pow(origin.y - point.y, 2);
			
			distance = sqrt(distance); // square root to complete formula
			
			// if astroid hasn't been touched, check if touch is within the astroid
			if (astroid.tag == NOT_TOUCHED && distance <= frame.size.width / 2)
			{
				astroid.image = touchedImage; // change to touched astroid image
				[self touchedastroid:astroid]; // call the touchedastroid: method
				hitastroid = YES; // a astroid has been touched
				astroid.tag = TOUCHED; // this astroid has been touched  
			} // end if
		} // end for
	} // end for
	
	if (!hitastroid) // if the player missed
	{
		//[missPlayer play]; // play the miss sound
		
	} // end if
} // end method touchesBegan:withEvent:

- (void)touchedastroid:(UIImageView *)astroid
{	
	hitPlayer.currentTime = 0; // reset the playback to the beginning
	[hitPlayer play]; // play the sound for when the player hits a astroid
	astroidsTouched=astroidsTouched+1;//increment the numbe of astroids touched
	NSLog(@"Astroid Touched! %i",astroidsTouched);
	// stop the current animation and start a new one at the same place
	CGRect frame = [[astroid.layer presentationLayer] frame]; // get the frame
	[astroid.layer removeAllAnimations]; // stop the animation
	astroid.frame = frame; // move the astroid to where the old animation ended
	[astroid setNeedsDisplay]; // redraw the astroid
	
	// give the astroid time to redraw by delaying the end animation
	[self performSelector:@selector(beginastroidEndAnimation:) withObject:astroid
			   afterDelay:0.01];
} // end method touchedastroid:

// starts the fade-away animation for a astroid that's been touched
- (void)beginastroidEndAnimation:(UIImageView *)astroid
{
	[UIView beginAnimations:@"end" context:astroid]; // begin animation block
	[UIView setAnimationDuration:0.8]; // set the time for the animation
	[UIView setAnimationDelegate:self]; // set the animation delegate
	
	// set the method to call when the animation ends
	[UIView setAnimationDidStopSelector: @selector(finishedAnimation:finished:context:)];
	
	// make the astroid stay in the same place and disappear
	CGRect frame = astroid.frame; // get the current frame
	frame.origin.x += frame.size.width / 2; // set x to the center
	frame.origin.y += frame.size.height / 2; // set y to the center
	frame.size.width = 0; // set the width to 0
	frame.size.height = 0; // set the height to 0
	[astroid setFrame:frame]; // assign the new frame
	[astroid setAlpha:0.0]; // set the astroid to be fully transparent
	[UIView commitAnimations]; // end the animation block
} // end method beginastroidEndAnimation:

// method is automatically called when an animation ends
- (void)finishedAnimation:(NSString *)animationId finished:(BOOL)finished  context:(void *)context
{	
	// if the game has already been lost, exit
    
	UIImageView *astroid = (UIImageView *)context; // get the finished astroid
	
	// if it was an ending animation that finished, add a new astroid
	if (animationId == @"end")
	{
		// remove astroid from the astroids NSMutableArray
		[astroids removeObject:astroid];
		[astroid removeFromSuperview]; // remove the old astroid
		[self game:2]; // add a new astroid
	} // end if
	else if ([astroid.image isEqual:untouchedImage]) // a astroid was missed
	{
		//[disappearPlayer play]; // play disappearing astroid sound effect		
        hitCount++;
        
        if (hitCount > 5) {
            [self displayView:5]; // too many hits, end game
        }
		// remove the old astroid and create a new one
		[astroid removeFromSuperview]; // remove old astroid
		[self game:2]; // add a new astroid
	} // end else
} // end method finishedAnimation:finished:context:




// free astroidOnViewController's memory
- (void)dealloc
{
	[currentView release];
	[astroids release]; // release the astroids NSMutableArray
	[hitPlayer release]; // release the hitPlayer AVAudioPlayer
	[missPlayer release]; // release the missPlayer AVAudioPlayer
	[disappearPlayer release]; // release the disappearPlayer AVAudioPlayer
	[super dealloc]; // invokes the superclass's dealloc method
} // end method dealloc


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

@end