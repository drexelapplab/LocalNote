//
//  LNNote.h
//  LocalNote
//
//  Created by Kyle Levin on 1/6/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNNote : NSObject <NSCoding>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *dateModified;
@property (strong, nonatomic) NSString *text;

- (void)updateDateModified;

@end
