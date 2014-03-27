//
//  LNNoteViewController.m
//  LocalNote
//
//  Created by Kyle Levin on 1/7/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

#import "LNNoteViewController.h"

@implementation LNNoteViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_titleField setText:_note.title];
    [_noteTextView setText:_note.text];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
    if(![_titleField.text isEqualToString:@""])
    {
        [_note setTitle:_titleField.text];
    }
    else
    {
        [_note setTitle:@"Untitled"];
    }
    
    [_note setText:_noteTextView.text];
    [_note updateDateModified];
    
    [_database save];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard Management

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    CGRect frame = _noteTextView.frame;
    frame.size.height -= keyboardHeight;
    _noteTextView.frame = frame;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    CGRect frame = _noteTextView.frame;
    frame.size.height += keyboardHeight;
    _noteTextView.frame = frame;
}

@end
