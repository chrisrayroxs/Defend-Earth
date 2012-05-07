//
//  highScore.h
//  defendEarth
//
//  Created by Student4 on 5/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "defendEarthViewController.h"


@protocol FlipsideViewControllerDelegate2;

@interface highScore : UITableViewController {
	id <FlipsideViewControllerDelegate2> delegate2;
	NSMutableArray *scoreHigh;
	NSMutableArray *array;

	

}
@property (nonatomic, assign) id <FlipsideViewControllerDelegate2> delegate2;
@property (nonatomic) int *someNumber;

@end
