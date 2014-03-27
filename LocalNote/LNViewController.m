//
//  LNViewController.m
//  LocalNote
//
//  Created by Kyle Levin on 1/6/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

#import "LNViewController.h"

@interface LNViewController ()

@property (strong, nonatomic) LNDatabase *database;
@property (strong, nonatomic) LNNotebook *selectedNotebook;

@end

@implementation LNViewController

#pragma mark - Object Management

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        _database = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/database", documentsDirectory]];
        
        if(_database == nil)
        {
            // Load from file failed, so create blank database and save it.
            _database = [[LNDatabase alloc] init];
            [_database save];
        }
        
    }
    
    return self;
}

#pragma mark - View Handling

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_notebooksTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // The number of rows is equal to the number of notebooks in the database.
    return _database.notebooks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // A cell identifier is used so that cells can be reused after they've moved off of the screen.
    static NSString *cellIdentifier = @"Cell";
    
    // Here we ask the tableview if it has any table cells for us to reuse.
    UITableViewCell *cell = [_notebooksTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // If it doesn't, we create a new one!
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // Display an arrow on on the cell, indicating that there is a submenu.
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Here we grab a notebook from the database to populate the current table cell.
    LNNotebook *notebook = [_database.notebooks objectAtIndex:indexPath.row];
    cell.textLabel.text = notebook.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // When we select a notebook's cell, we want to transition to the notebook VC.
    // We also need to save the selectednotebook so we can forward it to the notebook VC in the prepareForSegue:sender: method.
    _selectedNotebook = [_database.notebooks objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"showNotebook" sender:self];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This enables "swipe to delete" on the table view's cells.
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Here we grab the post that we want to delete, based on which cell we have swiped and then remove the blog post and save the database.
        LNNotebook *notebookToDelete = [_database.notebooks objectAtIndex:indexPath.row];
        [_database deleteNotebook:notebookToDelete];
        [_database save];
        
        // This line takes care of actually removing the row we want deleted.
        // The deleteRowsAtIndexPaths: method takes in an array of indexPaths, so we have to create an array with one indexPath
        [_notebooksTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Storyboard Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showNotebook"])
    {
        LNNotebookViewController *vc = [segue destinationViewController];
        
        // Pass a reference to the database, so the LNNotebookViewController can save.
        vc.database = _database;
        vc.notebook = _selectedNotebook;
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([[alertView title] isEqualToString:@"New Notebook"] && buttonIndex == 1)
    {
        UITextField *textField = [alertView textFieldAtIndex:0];
        
        LNNotebook *notebook = [[LNNotebook alloc] initWithTitle:textField.text];
        [_database newNotebook:notebook];
        [_database save];
        [_notebooksTableView reloadData];
    }
}
- (IBAction)createNewNotebook:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setDelegate:self];
    [alert setTitle:@"New Notebook"];
    [alert setMessage:@"Please enter a title:"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert addButtonWithTitle:@"Create"];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}
@end
