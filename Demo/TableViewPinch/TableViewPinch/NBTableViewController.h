//
//  NBTableViewController.h
//  TableViewPinch
//
//  Created by Nanda Ballabh on 29/08/13.
//  Copyright (c) 2013 nanda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UITableEditingMode) {
    UITableViewPinchIn = 0,
    UITableViewPinchOut,        // insert new item;
    UITableViewSwipeLeft,
    UITableViewSwipeRight
};

@protocol NBTableViewControllerDeligate;


@interface NBTableViewController : UITableViewController<UIGestureRecognizerDelegate>

@property (nonatomic, strong) id<NBTableViewControllerDeligate> deligate;


@end

@protocol NBTableViewControllerDeligate <NSObject>

@required

- (UITableViewCell*)configureCellAtIndexPath:(NSIndexPath*)indexPath andTableView:(UITableView*)nTableView;

- (NSInteger)nTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

@optional

-(void)nTableView:(UITableView *)nTableView commitEditingMode:(UITableEditingMode)editingMode forRowAtIndexPath:(NSArray *)indexPaths;

-(void)nTableView:(UITableView *)nTableView deleteRowAtIndexPath:(NSArray *)indexPaths;

-(void)handleLeftSwipe:(UITableView*)nTableView indexPath:(NSIndexPath*)indexPath;

- (NSInteger)numberOfSections:(UITableView *)nTableView;

- (void)nTableView:(UITableView *)nTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
