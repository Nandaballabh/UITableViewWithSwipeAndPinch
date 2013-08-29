//  NBTableViewController.h
//  TableViewPinch
//
//  Created by Nanda Ballabh on 29/08/13.
//  Copyright (c) 2013 nanda. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.//


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
