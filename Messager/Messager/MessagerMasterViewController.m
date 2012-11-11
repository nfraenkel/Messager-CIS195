//
//  MessagerMasterViewController.m
//  Messager
//
//  Created by Nathan Fraenkel on 11/10/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "MessagerMasterViewController.h"

#import "MessagerDetailViewController.h"

@interface MessagerMasterViewController () {
    NSMutableArray *messages;
    NSMutableData *_data;
}
@end

@implementation MessagerMasterViewController

@synthesize messages, singletonian;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *refresher = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStyleBordered target:self action:@selector(refreshButtonPressed:)];
    
    
    self.navigationItem.leftBarButtonItem = refresher;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    singletonian = [MessageSingleton sharedDataModel];
    
    if (!self.messages){
        self.messages = [[NSMutableArray alloc] init];
    }
    
    [self getMessagesFromAPI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButtonPressed:(id)sender
{
    if (!messages) {
        messages = [[NSMutableArray alloc] init];
    }
    [messages insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)refreshButtonPressed:(id)sender
{
    [self getMessagesFromAPI];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Message *msg = messages[indexPath.row];
    cell.textLabel.text = [msg title];
    cell.detailTextLabel.text = [msg body];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [messages removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showMessage"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Message *object = messages[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

-(void)getMessagesFromAPI {
    
    NSString *url = @"http://cis195-messages.herokuapp.com/messages";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    
    NSLog(@"setHTTPMethod: GET!");
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    
    NSLog(@"connection started");
}

- (void)postMessageToAPI:(NSString *)title andBody:(NSString *)body {
    NSString *url = @"http://cis195-messages.herokuapp.com/messages";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *data = [NSString stringWithFormat:@"message[title]=%@&message[body]=%@", title, body];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}



/**
 * Here are the NSURLConnectionDataDelegate methods that handle the callbacks.
 * This is mostly primarily and three step process, assuming you get no errors.
 *
 * 1. You receive a response.
 * 2. You receive any number of pieces of data.
 * 3. The connection finishes loading. That is, you are ready to use the combined pieces of data.
 */

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"conection did receive response!");
    _data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"conection did receive data!");
    [_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // Please do something sensible here, like log the error.
    NSLog(@"connection failed with error: %@", error.description);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectiondidfinishloading!");
    NSMutableArray *dictResponse = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    for (int i = 0; i < dictResponse.count; i++){
        NSDictionary *thing = [dictResponse objectAtIndex:i];
        NSLog(@"thing: %@", [thing objectForKey:@"title"]);
        Message* msg = [[Message alloc] initWithTitle:[thing objectForKey:@"title"] createdAt:[thing objectForKey:@"createdAt"] updatedAt:[thing objectForKey:@"updatedAt"] body:[thing objectForKey:@"body"]];
        msg.idNumber = [[thing objectForKey:@"id"] intValue];
        [self.messages insertObject:msg atIndex:i];
    }
    // update singleton
    singletonian.messages = messages;
    [self.tableView reloadData];
//    NSLog(@"%@", dictResponse); // If you want to see what the 4SQ response looks like.
}

@end
