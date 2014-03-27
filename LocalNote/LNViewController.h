//
//  LNViewController.h
//  LocalNote
//
//  Created by Kyle Levin on 1/6/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

#import "LNNotebookViewController.h"

@interface LNViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *notebooksTableView;

- (IBAction)createNewNotebook:(id)sender;

@end
