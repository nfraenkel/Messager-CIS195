//
//  Message.m
//  Messager
//
//  Created by Nathan Fraenkel on 11/10/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize idNumber, title, body, createdAt, updatedAt;

-(id)initWithTitle:(NSString *)newTitle createdAt:(NSDate *)newCreatedAt updatedAt:(NSDate *)newUpdatedAt body:(NSString *)newBody{
    self = [super init];
    if (self) {
        self.title = newTitle;
        self.body = newBody;
        self.createdAt = newCreatedAt;
        self.updatedAt = newUpdatedAt;
        return self;
    }

    return nil;
}

@end
