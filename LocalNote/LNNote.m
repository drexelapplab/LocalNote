//
//  LNNote.m
//  LocalNote
//
//  Created by Kyle Levin on 1/6/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

#import "LNNote.h"

@implementation LNNote

- (id)init
{
    self = [super init];
    
    if(self)
    {
        [self updateDateModified];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if(self)
    {
        _title = [aDecoder decodeObjectForKey:@"title"];
        _dateModified = [aDecoder decodeObjectForKey:@"dateModified"];
        _text = [aDecoder decodeObjectForKey:@"text"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_dateModified forKey:@"dateModified"];
    [aCoder encodeObject:_text forKey:@"text"];
}

- (void)updateDateModified
{
    _dateModified = [NSDate date];
}

@end
