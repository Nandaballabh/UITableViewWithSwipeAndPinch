//
//  MasterViewController.m
//  TableViewPinch
//
//  Created by Nanda Ballabh on 29/08/13.
//  Copyright (c) 2013 nanda. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.modifiedTable = [[NBTableViewController alloc]initWithStyle:UITableViewStylePlain];
    [self.modifiedTable setDeligate:self];
    self.modifiedTable.view.frame = self.view.frame;
    [self.view addSubview:self.modifiedTable.view];
    _objects = [NSMutableArray arrayWithObjects:@"Test 1",@"Test2",@"Test3",@"Test4",@"Test5",@"Test6",@"Test7", nil];
}

#pragma mark -  Deligates

-(NSInteger) nTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.rowHeight = 70;
    return _objects.count;
}

-(UITableViewCell*) configureCellAtIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)nTableView
{
    UITableViewCell *cell = [nTableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [_objects objectAtIndex:indexPath.row];
    return cell;
}

-(void)nTableView:(UITableView *)nTableView commitEditingMode:(UITableEditingMode)editingMode forRowAtIndexPath:(NSArray *)indexPaths
{
    switch (editingMode)
    {
        case UITableViewSwipeLeft:
            NSLog(@"Left Swiped..!!");// you can implement here left swipe case
            break;
        case UITableViewSwipeRight:
            NSLog(@"Right Swiped..!!");// you can implement here right swipe case
            break;
        case UITableViewPinchIn:
            [self deleteRowWithanimation:indexPaths tableView:nTableView];
            NSLog(@"Pinch In...!!");// you can implement here pinchIn case
            break;
        case UITableViewPinchOut:
            NSLog(@"Pinch Out...!!");// you can implement here pinchOut case
            break;
    }
}

-(void)deleteRowWithanimation:(NSArray*)indexPaths tableView:(UITableView*)tableView
{
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (int i = 0; i< indexPaths.count; i++) {
        NSIndexPath *index = [indexPaths objectAtIndex:i];
        [indexSet addIndex:index.row];
    }
    [_objects removeObjectsAtIndexes:indexSet];
    [UIView animateWithDuration:0.7 delay:0.0 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
        [tableView beginUpdates];        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithArray:indexPaths] withRowAnimation:UITableViewRowAnimationMiddle];
        [tableView endUpdates];        
    } completion:^(BOOL finished) {
    }];
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
