//
//  LNDatabase.h
//  LocalNote
//
//  Created by Kyle Levin on 1/6/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNNotebook.h"

@interface LNDatabase : NSObject <NSCoding>

// An array of LNNotebook objects.
// Don't modify this property directly.
// To add and remove objects, use the methods below.
@property (strong, nonatomic) NSMutableArray *notebooks;

// Snapshots the database and saves it to disk
- (void)save;

// Creates a new notebook in the database from the input notebook object.
// If a notebook with the same name already exists, it will return NO.
- (BOOL)newNotebook:(LNNotebook *)notebook;

// Deletes a given notebook if it exists.
// Returns NO if the notebook is not found.
- (BOOL)deleteNotebook:(LNNotebook *)notebookToDelete;

@end
