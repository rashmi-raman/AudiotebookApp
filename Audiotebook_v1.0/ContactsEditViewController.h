//
//  ContactsEditViewController.h
//  Audiotebook_v1.0
//
//  Created by Robert Walport on 3/24/13.
//  Copyright (c) 2013 Hacks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsSectionViewController.h"
#import "MenuViewController.h"
#import "Contact.h"

@interface ContactsEditViewController : UITableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@property (strong, nonatomic) Contact *currentPicture;

@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UITextField *descriptionField;
@property (strong, nonatomic) IBOutlet UIImageView *imageField;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;

@property (strong, nonatomic) UIImagePickerController *imagePicker;
- (IBAction)MakeCall:(id)sender;

@end
