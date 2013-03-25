//
//  ContactsSectionViewController.h
//  Audiotebook_v1.0
//
//  Created by Robert Walport on 3/24/13.
//  Copyright (c) 2013 Hacks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsEditViewController.h"

@interface ContactsSectionViewController : UITableViewController

@property  (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property  (strong, nonatomic) NSMutableArray *pictureListData;

- (void)readDataForTable;

@end
