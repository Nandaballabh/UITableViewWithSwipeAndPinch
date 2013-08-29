//  NBTableViewController.m
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

#import "NBTableViewController.h"

@interface NBTableViewController ()
@property(nonatomic, strong) UISwipeGestureRecognizer *swipeGesture;
@property(nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;
@property(nonatomic) BOOL isStartPinch;
@property(nonatomic) CGPoint touchPoint1;
@property(nonatomic) CGPoint touchPoint2;
@end

@implementation NBTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.swipeGesture.direction = (UISwipeGestureRecognizerDirectionLeft |UISwipeGestureRecognizerDirectionRight);
    self.swipeGesture.delegate = self;
    self.pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchInOut:)];
    self.pinchGesture.delegate = self;
    [self.tableView addGestureRecognizer:self.swipeGesture];
    [self.tableView addGestureRecognizer:self.pinchGesture];

}

-(IBAction)handleSwipe:(UISwipeGestureRecognizer*)swipeSender
{
    CGPoint touchPoint = [swipeSender locationOfTouch:0 inView:self.tableView];
    if(CGRectContainsPoint(self.tableView.frame,touchPoint)) {
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
        NSInteger swipeMode = 3;
        if(swipeSender.direction | UISwipeGestureRecognizerDirectionLeft)
            swipeMode = 2;
        if(_deligate && [_deligate conformsToProtocol:@protocol(NBTableViewControllerDeligate)])
            return [self.deligate nTableView:self.tableView commitEditingMode:swipeMode forRowAtIndexPath:@[indexPath]];
    }
}

-(IBAction)handlePinchInOut:(UIPinchGestureRecognizer*)pinchSender
{
    if(!self.isStartPinch) {
        _touchPoint1 = [pinchSender locationOfTouch:0 inView:self.tableView];
        _touchPoint2 = [pinchSender locationOfTouch:1 inView:self.tableView];
        self.isStartPinch = YES;
    }
    if(CGRectContainsPoint(self.tableView.frame,_touchPoint1) && CGRectContainsPoint(self.tableView.frame,_touchPoint2))
    {
        if(pinchSender.state == UIGestureRecognizerStateEnded && pinchSender.scale < 1.0)
        { 
            self.isStartPinch = NO;
            NSIndexPath *index2 = [self.tableView indexPathForRowAtPoint:_touchPoint1];
            NSIndexPath *index1 = [self.tableView indexPathForRowAtPoint:_touchPoint2];
            NSMutableArray *indexes = [NSMutableArray arrayWithCapacity:2];
            // one row between two pinched row will delete
            if (index2.row - index1.row == abs(2) && index1.section == index2.section) {
                NSIndexPath *deleteIndex = [NSIndexPath indexPathForRow:(index2.row-1) inSection:index2.section];
                [indexes addObject:deleteIndex];
            } else if (index2.row - index1.row == abs(1) && index1.section == index2.section) {
                // both pinched row is deleted 
                [indexes addObject:index1];
                [indexes addObject:index2];
            }
            if(_deligate && [_deligate conformsToProtocol:@protocol(NBTableViewControllerDeligate)])
                return [self.deligate nTableView:self.tableView commitEditingMode:pinchSender.scale > 1 ? UITableViewPinchOut : UITableViewPinchIn forRowAtIndexPath:indexes];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_deligate && [_deligate conformsToProtocol:@protocol(NBTableViewControllerDeligate)]) {
        if([_deligate respondsToSelector:@selector(numberOfSections:)])
            return [self.deligate numberOfSections:tableView];
    }
        
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_deligate && [_deligate conformsToProtocol:@protocol(NBTableViewControllerDeligate)]) {
        if([_deligate respondsToSelector:@selector(nTableView:numberOfRowsInSection:)])
            return [self.deligate nTableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_deligate && [_deligate conformsToProtocol:@protocol(NBTableViewControllerDeligate)]) {
        if([_deligate respondsToSelector:@selector(configureCellAtIndexPath:andTableView:)])
            return [self.deligate configureCellAtIndexPath:indexPath andTableView:tableView];
    }
    return nil;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing)
    {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_deligate && [_deligate conformsToProtocol:@protocol(NBTableViewControllerDeligate)]) {
        if([_deligate respondsToSelector:@selector(nTableView:didSelectRowAtIndexPath:)])
            [self.deligate nTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
