//
//  NewMessageViewController.h
//  Messager
//
//  Created by Nathan Fraenkel on 11/12/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewMessageViewController;

@protocol NewMessageViewControllerDelegate <NSObject>
- (void)newMessageViewControllerDidCancel:
(NewMessageViewController *)controller;
- (void)newMessageViewControllerDidSave:
(NewMessageViewController *)controller;
@end

@interface NewMessageViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, NSURLConnectionDataDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) id <NewMessageViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;


- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@end


