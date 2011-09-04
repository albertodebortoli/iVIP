//
//  QuotesTVC.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import "QuotesTVC.h"
#import "QuotesDetailsVC.h"

@implementation QuotesTVC

@synthesize parent;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationItem.title = @"Quotes";
	
	UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc]initWithTitle:@"Close"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(doneButton)];
	
	self.tableView.separatorColor = [UIColor viewFlipsideBackgroundColor];
	
	[self.navigationItem setRightBarButtonItem:dismissButton];
	[dismissButton release];
	[super viewDidLoad];
}

- (IBAction)doneButton
{	
	[self.navigationController dismissModalViewControllerAnimated:YES];	
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *altCellColor;
	if (indexPath.row == 0 || indexPath.row%2 == 0) {
		altCellColor = [UIColor colorWithWhite:kWhiteColorForEvenCells alpha:1.0];
	}
	else {
		altCellColor = [UIColor colorWithWhite:kWhiteColorForOddCells alpha:1.0];
	}
    cell.backgroundColor = altCellColor;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{	
	return 1;	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
	return [parent.arrayDB count];	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
    static NSString *CellIdentifier = @"QuoteCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [[parent.arrayDB objectAtIndex:indexPath.row] objectForKey:@"Citation"];
	cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
	cell.detailTextLabel.text = [[parent.arrayDB objectAtIndex:indexPath.row] objectForKey:@"Year"];
	
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.parent showInfoSetEntry:[parent.arrayDB objectAtIndex:indexPath.row] setIndex:indexPath.row];
	[self doneButton];
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
	[super dealloc];
}


@end

