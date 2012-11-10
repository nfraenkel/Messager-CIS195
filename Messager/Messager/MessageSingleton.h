//
//  MessageSingleton.h
//  Messager
//
//  Created by Nathan Fraenkel on 11/10/12.
//  Copyright (c) 2012 Nathan Fraenkel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageSingleton : NSObject {
    NSMutableArray *messages;
}

@property (nonatomic, copy) NSMutableArray *messages;


+ (MessageSingleton *) sharedDataModel;
@end
