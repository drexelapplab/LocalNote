//
//  LNNotebookViewController.h
//  LocalNote
//
//  Created by Kyle Levin on 1/6/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

#import "LNNoteViewController.h"

@interface LNNotebookViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *notesTableView;

// This notebook contains the notes that will be displayed in the notesTableView.
@property (strong, nonatomic) LNNotebook *notebook;

// A reference to the database, so we can save from this view controller.
@property (strong, nonatomic) LNDatabase *database;

@end
