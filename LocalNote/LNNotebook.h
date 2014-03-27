//
//  LNNotebook.h
//  LocalNote
//
//  Created by Kyle Levin on 1/6/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNNote.h"

@interface LNNotebook : NSObject <NSCoding>

// The notebook's title.
@property (strong, nonatomic) NSString *title;

// An array of LNNote/subclass objects.
@property (strong, nonatomic) NSMutableArray *notes;

// Creates a new notebook with the given title.
// The resulting notebook will be public.
- (id)initWithTitle:(NSString *)title;

// Adds a new note if the notebook is unlocked. We don't need to check for duplicates because
// If the user wants to make notes with the same title, they should be able to.
- (void)newNote:(LNNote *)note;

// Search for the given note and delete it if possible.
// Returns NO if note is not found or the notebook is locked.
- (BOOL)deleteNote:(LNNote *)noteToDelete;

@end
