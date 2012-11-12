//
//  MessagerMasterViewController.h
//  Messager
//
//  Created by Nathan Fraenkel on 11/10/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "MessageSingleton.h"
#import "NewMessageViewController.h"

@interface MessagerMasterViewController : UITableViewController <NSURLConnectionDataDelegate, NewMessageViewControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) NSMutableArray *messages;

@property (retain) MessageSingleton *singletonian;

@property (nonatomic, retain) IBOutlet UIViewController *postViewController;

@end
