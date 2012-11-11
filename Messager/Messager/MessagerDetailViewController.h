//
//  MessagerDetailViewController.h
//  Messager
//
//  Created by Nathan Fraenkel on 11/10/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "MessageSingleton.h"

@interface MessagerDetailViewController : UIViewController

@property (strong, nonatomic) Message *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedLabel;
@end
