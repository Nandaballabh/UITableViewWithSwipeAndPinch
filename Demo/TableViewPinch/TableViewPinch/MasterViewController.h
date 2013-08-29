//
//  MasterViewController.h
//  TableViewPinch
//
//  Created by Nanda Ballabh on 29/08/13.
//  Copyright (c) 2013 nanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBTableViewController.h"
@class DetailViewController;

@interface MasterViewController : UIViewController<NBTableViewControllerDeligate>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NBTableViewController *modifiedTable;

@end
