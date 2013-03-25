//
//  MenuViewController.m
//  Audiotebook_v1.0
//
//  Created by Robert Walport on 3/24/13.
//  Copyright (c) 2013 Hacks. All rights reserved.
//

#import "MenuViewController.h"
#import "MainAudiotebookViewController.h"
#import "ContactsSectionViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Interview"])
    {
    MainAudiotebookViewController* logView = segue.destinationViewController;
    if( [logView respondsToSelector: @selector (setManagedObjectContext:)] ) {
        [logView setValue:self.managedObjectContext forKey:@"managedObjectContext"];
    }
    }
    if ([[segue identifier] isEqualToString:@"Contact"])
    {
        UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
        ContactsSectionViewController *piclist = (ContactsSectionViewController *)[[navController viewControllers] lastObject];
        piclist.managedObjectContext = managedObjectContext;
    }
}


@end
