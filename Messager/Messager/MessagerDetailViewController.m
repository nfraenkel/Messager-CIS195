//
//  MessagerDetailViewController.m
//  Messager
//
//  Created by Nathan Fraenkel on 11/10/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "MessagerDetailViewController.h"

@interface MessagerDetailViewController ()
- (void)configureView;
@end

@implementation MessagerDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Message *)newMessage
{
    if (_detailItem != newMessage) {
        _detailItem = newMessage;

        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        NSDateFormatter *formy = [NSDateFormatter new];        
        [formy setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        
        NSDateFormatter *stringFormy = [NSDateFormatter new];
        [stringFormy setDateStyle:NSDateFormatterShortStyle];
        
        NSDate *created = [formy dateFromString:_detailItem.createdAt];
        NSDate *updated = [formy dateFromString:_detailItem.updatedAt];

        
        NSString *createdDay = [stringFormy stringFromDate:created];
        NSString *createdTime = [created.description substringWithRange:NSMakeRange(11, 8)];
        NSString *createdString = [NSString stringWithFormat:@"%@ on %@", createdTime, createdDay];
        
        NSString *updatedDay = [stringFormy stringFromDate:updated];
        NSString *updatedTime = [updated.description substringWithRange:NSMakeRange(11, 8)];
        NSString *updatedString = [NSString stringWithFormat:@"%@ on %@", updatedTime, updatedDay];

        self.titleLabel.text = _detailItem.title;
        self.bodyLabel.text = _detailItem.body;
        self.createdLabel.text = [NSString stringWithFormat:@"Created at: %@", createdString ];
        self.updatedLabel.text = [NSString stringWithFormat:@"Updated at: %@", updatedString ];
        
                
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
