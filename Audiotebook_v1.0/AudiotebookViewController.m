//
//  AudiotebookViewController.m
//  Audiotebook_v1.0
//
//  Created by Robert Walport on 2/13/13.
//  Copyright (c) 2013 Hacks. All rights reserved.
//

#import "AudiotebookViewController.h"
#import "MenuViewController.h"
#import "MainAudiotebookViewController.h"

@interface AudiotebookViewController ()

@end

@implementation AudiotebookViewController

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
        MenuViewController* logView = segue.destinationViewController;
        if( [logView respondsToSelector: @selector (setManagedObjectContext:)] ) {
            [logView setValue:self.managedObjectContext forKey:@"managedObjectContext"];
    }
}


@end
