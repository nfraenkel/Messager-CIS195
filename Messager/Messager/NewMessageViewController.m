//
//  NewMessageViewController.m
//  Messager
//
//  Created by Nathan Fraenkel on 11/12/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "NewMessageViewController.h"

@interface NewMessageViewController ()

@end

@implementation NewMessageViewController

@synthesize delegate, bodyTextView, titleField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitMessagePost {
    NSString *url = @"http://cis195-messages.herokuapp.com/messages";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *data = [NSString stringWithFormat:@"message[title]=%@&message[body]=%@", titleField.text, bodyTextView.text];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error with POST request: %@", error.description);
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Error with POST"
                          message: @"There was an error when trying to post your new message to the CIS195 message board."
                          delegate: nil
                          cancelButtonTitle:@"Whatever"
                          otherButtonTitles:@"Retry", nil];
    [alert show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
		NSLog(@"newmessageviewcontroller user pressed WHATEVS");
	}
	else {
		NSLog(@"newmessageviewcontroller user pressed Retry");
        [self submitMessagePost];
	}
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
   
    [self.delegate newMessageViewControllerDidSave:self];

}

- (IBAction)cancelButtonPressed:(id)sender
{    
	[self.delegate newMessageViewControllerDidCancel:self];
}
- (IBAction)doneButtonPressed:(id)sender
{
    [self submitMessagePost];
    
}

@end
