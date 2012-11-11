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
        NSDateFormatter *formy = [[NSDateFormatter alloc] init];
        [formy setDateStyle:NSDateFormatterMediumStyle];
        NSString *created = [formy stringFromDate:_detailItem.createdAt];
        NSString *updated = [formy stringFromDate:_detailItem.updatedAt];
        self.titleLabel.text = _detailItem.title;
        self.bodyLabel.text = _detailItem.body;
        self.createdLabel.text = created;
        self.updatedLabel.text = updated;
                
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
