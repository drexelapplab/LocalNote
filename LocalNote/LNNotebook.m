//
//  LNNotebook.m
//  LocalNote
//
//  Created by Kyle Levin on 1/6/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

#import "LNNotebook.h"

@interface LNNotebook ()

@end

@implementation LNNotebook

#pragma mark - Object Management

- (id)initWithTitle:(NSString *)title
{
    self = [super init];
    
    if(self)
    {
        _title = title;
        _notes = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if(self)
    {
        _title = [aDecoder decodeObjectForKey:@"title"];
        _notes = [aDecoder decodeObjectForKey:@"notes"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_notes forKey:@"notes"];
}

- (void)newNote:(LNNote *)note
{
    [_notes addObject:note];
}

- (BOOL)deleteNote:(LNNote *)noteToDelete
{
    for(LNNote *note in _notes)
    {
        if([note isEqual:noteToDelete])
        {
            // The note exists, so we remove it.
            [_notes removeObject:noteToDelete];
            return YES;
        }
    }
    
    return NO;
}

@end
