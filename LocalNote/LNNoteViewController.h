//
//  LNNoteViewController.h
//  LocalNote
//
//  Created by Kyle Levin on 1/7/14.
//  Copyright (c) 2014 Kyle Levin. All rights reserved.
//

@interface LNNoteViewController : UIViewController

@property (strong, nonatomic) LNDatabase *database;

@property (strong, nonatomic) LNNote *note;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end
