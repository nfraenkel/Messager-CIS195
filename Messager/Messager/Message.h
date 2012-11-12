//
//  Message.h
//  Messager
//
//  Created by Nathan Fraenkel on 11/10/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic) int idNumber;
@property (nonatomic, retain) IBOutlet NSString *title;
@property (nonatomic, retain) IBOutlet NSString *body;
@property (nonatomic, retain) IBOutlet NSString *createdAt;
@property (nonatomic, retain) IBOutlet NSString *updatedAt;

-(id)initWithTitle:(NSString *)newTitle createdAt:(NSString *)newCreatedAt updatedAt:(NSString *)newUpdatedAt body:(NSString *)newBody;


@end
