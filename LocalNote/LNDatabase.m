//
//  LNDatabase.m
//  LocalNote
//
//  Created by Kyle Levin on 1/6/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

#import "LNDatabase.h"

@implementation LNDatabase

#pragma mark - Object Management

- (id)init
{
    self = [super init];
    
    if(self)
    {
        _notebooks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if(self)
    {
        // Loads the notebooks array from the disk.
        _notebooks = [aDecoder decodeObjectForKey:@"notebooks"];
        
        // Check to see that the array actually existed on the disk.
        // If not, we'll just create an empty array.
        if(_notebooks == nil)
        {
            _notebooks = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_notebooks forKey:@"notebooks"];
}

#pragma mark - Data Persistence

- (void)save
{
    NSLog(@"Saved");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    [NSKeyedArchiver archiveRootObject:self toFile:[NSString stringWithFormat:@"%@/database", documentsDirectory]];
}

#pragma mark - Notebook Management

- (BOOL)newNotebook:(LNNotebook *)newNotebook
{
    for(LNNotebook *notebook in _notebooks)
    {
        if([notebook.title isEqualToString:newNotebook.title])
        {
            // A notebook with the same title already exists. Return failure.
            return NO;
        }
    }
    
    // If we've reached this point, there are no notebooks with the same title.
    // Add the notebook to the database and return YES.
    [_notebooks addObject:newNotebook];
    return YES;
}

- (BOOL)deleteNotebook:(LNNotebook *)notebookToDelete
{
    for(LNNotebook *notebook in _notebooks)
    {
        if([notebook isEqual:notebookToDelete])
        {
            // The notebook is in the array. Time to remove it and return success.
            [_notebooks removeObject:notebookToDelete];
            return YES;
        }
    }
    
    // If we've reached this point, the notebook is not in the array.
    return NO;
}

@end
