//
//  ContactsTableViewController.h
//  Audiotebook_v1.0
//
//  Created by Robert Walport on 2/13/13.
//  Copyright (c) 2013 Hacks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayContactViewController.h"

@interface ContactsTableViewController : UITableViewController

@property  (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property  (strong, nonatomic) NSMutableArray *pictureListData;

- (void)readDataForTable;

@end
