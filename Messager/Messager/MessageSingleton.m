//
//  MessageSingleton.m
//  Messager
//
//  Created by Nathan Fraenkel on 11/10/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import "MessageSingleton.h"

@implementation MessageSingleton

@synthesize messages;

static MessageSingleton *sharedDataModel = nil;

+ (MessageSingleton *) sharedDataModel {
    @synchronized(self){
        if (sharedDataModel == nil){
            sharedDataModel = [[MessageSingleton alloc] init];
        }
    }
    return sharedDataModel;
}

@end
