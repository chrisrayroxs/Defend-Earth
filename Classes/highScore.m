//
//  highScore.m
//  defendEarth
//
//  Created by Student4 on 5/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "highScore.h"
#import "defendEarthAppDelegate.h"
#import "gamePlay.h"
#import "defendEarthViewController.h"





@implementation highScore
@synthesize someNumber;
@synthesize delegate2;

#pragma mark -
#pragma mark View lifecycle


- (void)goToView:sender {
	defendEarthAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSInteger i = [sender tag];
	
	[appDelegate displayView:i];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)viewDidLoad {
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stars.png"]]; 
	defendEarthAppDelegate *viewController = [[UIApplication sharedApplication] delegate];
	someNumber=[viewController rocketsNumbers];
	
	 UIButton *btnTwo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	btnTwo.frame = CGRectMake(40, 360, 240, 60);
	[btnTwo setTitle:@"Main Menu" forState:UIControlStateNormal];
    [(UILabel *)btnTwo setTag:1];
	[btnTwo addTarget:self action:@selector(goToView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnTwo];
    
	//int rocketsTouched=0;
    [super viewDidLoad];
	
	NSString* myNewString = [NSString stringWithFormat:@"%i", someNumber]; //Turn the number of rockets touched into string
	
	//Initialize the Array
	scoreHigh = [[NSMutableArray alloc] init];
	
	NSArray *todayList = [NSArray arrayWithObjects:@"500", @"400", @"300", myNewString,nil];
	NSDictionary *todayListInDict = [NSDictionary dictionaryWithObject:todayList forKey:@"MyGroceries"];
	
	[scoreHigh addObject:todayListInDict];
		
	//Set the title
	self.navigationItem.title = @"scoreHigh List";
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	return [scoreHigh count];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Number of rows it should expect should be based on the section
	NSDictionary *dictionary = [scoreHigh objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"MyGroceries"];
	return [array count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if(section == 0)
		return @"High Scores";
	else if(section == 1)
		return @"Weekly";
	else
		return @"Monthly";
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	
	//First get the dictionary object
	NSDictionary *dictionary = [scoreHigh objectAtIndex:indexPath.section];
	NSArray *array = [dictionary objectForKey:@"MyGroceries"];
	NSString *cellValue = [array objectAtIndex:indexPath.row];
	
	UILabel *label = [cell textLabel]; // get the label for the cell
	label.text = cellValue; // set the text of the label
	cell.textLabel.font = [UIFont systemFontOfSize:30.0];
	cell.textColor = [UIColor whiteColor];
	tableView.separatorColor = [UIColor clearColor];
	
	// make the cell display an arrow on the right side
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

#pragma mark -
#pragma mark Memory management


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

