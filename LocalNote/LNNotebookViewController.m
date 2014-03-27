//
//  LNNotebookViewController.m
//  LocalNote
//
//  Created by Kyle Levin on 1/6/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

#import "LNNotebookViewController.h"

@interface LNNotebookViewController ()

@property (strong, nonatomic) LNNote *selectedNote;

@end

@implementation LNNotebookViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTitle:_notebook.title];
    [_notesTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // The number of rows is equal to the number of notes in our notebook.
    return _notebook.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // A cell identifier is used so that cells can be reused after they've moved off of the screen.
    // static means that the string will only be created once and sticks around even after the method has returned the cell
    static NSString *cellIdentifier = @"Cell";
    
    // Here we ask the tableview if it has any table cells for us to reuse.
    UITableViewCell *cell = [_notesTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // If it doesn't, we create a new one!
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // Here we grab a notebook from the database to populate the current table cell.
    LNNote *note = [[_notebook notes] objectAtIndex:indexPath.row];
    cell.textLabel.text = note.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    cell.detailTextLabel.text = [formatter stringFromDate:note.dateModified];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedNote = [[_notebook notes] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showNote" sender:self];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This enables "swipe to delete" on the table view's cells.
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Here we grab the post that we want to delete, based on which cell we have swiped and then remove the blog post and save the database.
        LNNote *noteToDelete = [[_notebook notes] objectAtIndex:indexPath.row];
        [_notebook deleteNote:noteToDelete];
        [_database save];
        
        // This line takes care of actually removing the row we want deleted.
        [_notesTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Storyboard Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showNote"])
    {
        LNNoteViewController *vc = [segue destinationViewController];
        
        // Pass a reference to the database, so the LNNoteViewController can save.
        [vc setDatabase:_database];
        [vc setNote:_selectedNote];
    }
    else if([segue.identifier isEqualToString:@"newNote"])
    {
        LNNoteViewController *vc = [segue destinationViewController];
        
        // Create new note, add it to the database, and pass it to the LNNoteViewController
        LNNote *note = [[LNNote alloc] init];
        [_notebook newNote:note];
        [vc setNote:note];
        
        // Pass a reference to the database, so the LNNoteViewController can save.
        [vc setDatabase:_database];
    }
}

@end
