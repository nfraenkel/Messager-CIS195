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
@property (nonatomic, retain) IBOutlet NSDate *createdAt;
@property (nonatomic, retain) IBOutlet NSDate *updatedAt;

-(id)initWithName:(NSString *)newTitle createdAt:(NSDate *)newCreatedAt updatedAt:(NSDate *)newUpdatedAt body:(NSString *)newBody;


@end
