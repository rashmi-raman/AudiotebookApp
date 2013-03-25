//
//  MainAudiotebookViewController.m
//  Audiotebook_v1.0
//
//  Created by Robert Walport on 2/13/13.
//  Copyright (c) 2013 Hacks. All rights reserved.
//

#import "MainAudiotebookViewController.h"
#import "ContactsTableViewController.h"
#import "AudioRecordViewController.h"
#import "UserPrefs.h"

@interface MainAudiotebookViewController ()

@end

@implementation MainAudiotebookViewController

@synthesize contactName;
@synthesize slug;
@synthesize notes;
@synthesize photoMessage;
@synthesize selectedImage;
@synthesize locationManager;
@synthesize startingPoint;
@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize responseData;
@synthesize currentContact;
@synthesize currentPicture;
@synthesize managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    //Hide labels
    [latitudeLabel setHidden:TRUE];
    [longitudeLabel setHidden:TRUE];
    
    contactName.enabled = NO;
    
    if (currentPicture)
    {
        [contactName setText:[currentPicture name]];
    }
    
    
	
    //gets all files from App sandbox Documents folder
    self->fileManager = [NSFileManager defaultManager];
    self->paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self->documentsDirectory = [paths objectAtIndex:0];
    
    self->directoryContents = [self->fileManager contentsOfDirectoryAtPath:self->documentsDirectory error:nil];
    
    //creates file picker
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.frame = CGRectMake(0, 283, 320, 216);
    pickerView.tag = 100;
    pickerView.hidden = YES;
    [self.view addSubview:pickerView];
    
    //location information
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPhoto:(UIButton *)sender forEvent:(UIEvent *)event {
    
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	
    
	[self presentModalViewController:picker animated:YES];
    
    
}

//Tells the delegate that the user picked a still image or movie.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    self.selectedImage.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    self->selectedImageFile = self.selectedImage.image;
    self.selectedImage.hidden = NO;
    self.photoMessage.hidden = NO;
    
}


- (IBAction)addAudio:(UIButton *)sender forEvent:(UIEvent *)event {
    
    UIView *pickerView = [self.view viewWithTag:100];
    pickerView.hidden = NO;
    pickerView.userInteractionEnabled = true;
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    self->selectedAudioFile  = [NSString stringWithFormat:@"%d",row];
    
    pickerView.userInteractionEnabled = false;
    pickerView.hidden = YES;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    
    return [directoryContents count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    
    return [directoryContents objectAtIndex:row];
}

// Location Manager Methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
}


- (IBAction)submit:(UIButton *)sender forEvent:(UIEvent *)event {
    
    NSLog(@"in submit");
    
    
    NSString *name = nil;
    NSString *slugged = nil;
    NSString *noted = nil;
    NSString *job = nil;
    NSString *phone = nil;
    
    
    NSDate *longdate = [NSDate date];
    
    NSString *today = [NSDateFormatter localizedStringFromDate:longdate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle];
    
    name = [currentPicture valueForKey:@"name"];
    job = [currentPicture valueForKey:@"job"];
    phone = [currentPicture valueForKey:@"phone"];
    
    NSString *sendSmallImage = [UserPrefs base64forData:[currentPicture valueForKey:@"smallPicture"]];
    
    if (slug.text.length > 0)
        slugged =  slug.text;
    
    if (notes.text.length > 0)
        noted = notes.text;
    
    if (longitudeLabel.text.length > 0)
        longitudeString =  longitudeLabel.text;
    
    if (latitudeLabel.text.length > 0)
        latitudeString = latitudeLabel.text;
    
    [locationManager stopUpdatingLocation];
    
    NSString *soundFilePath = [self->documentsDirectory
                               stringByAppendingPathComponent:@"sound.caf"];
    
    
    NSData *storableAudio = [[NSData alloc] initWithContentsOfFile:soundFilePath];
    NSString *sendAudio = [UserPrefs base64forData:storableAudio];
    
    NSData *storableImage = UIImageJPEGRepresentation(self->selectedImageFile, 1.0);
    NSString *sendImage = [UserPrefs base64forData:storableImage];
    
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                name,@"cname",
                                job,@"job",
                                phone,@"phone",
                                sendSmallImage,@"contactimage",
                                slugged, @"slug",
                                noted,@"noted",
                                longitudeString,@"longitude",
                                latitudeString,@"latitude",
                                today,@"todayDate",
                                sendAudio,@"audio",
                                sendImage,@"image",
                                nil];
    
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //NSLog(@"JsonString = %@",jsonString);
    
    /* local testing
     /NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8000/api/reportinghistory/?username=rashmiraman"]; */
    
    NSURL *url = [NSURL URLWithString:@"http://fast-dusk-7046.herokuapp.com/api/reportinghistory/?username=rashmiraman"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:[[NSOperationQueue alloc] init]
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error)
     {
         
         if (error == nil)
         {
             NSLog(@"Success");
             UIAlertView *statusMessage = [[UIAlertView alloc] initWithTitle: @"Status" message: @"Data sent to server" delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil];
             
             [statusMessage show];
             self.contactName.text = nil;
             self.slug.text = nil;
             self.notes.text = nil;
             self.selectedImage.image = nil;
             self.photoMessage.hidden = YES;
             self.currentPicture = nil;
             
         }
         else{
             NSLog(@"Error = %@", error);
             UIAlertView *statusMessage = [[UIAlertView alloc] initWithTitle: @"Status" message: @"Error sending data to server" delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil];
             
             [statusMessage show];
         }
         
     }];
    
    
    
    
    
}


- (IBAction)reset:(UIButton *)sender forEvent:(UIEvent *)event {
    self.contactName.text = nil;
    self.slug.text = nil;
    self.notes.text = nil;
    self.selectedImage.image = nil;
    self.photoMessage.hidden = YES;
    self.currentPicture = nil;
    
    
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [contactName resignFirstResponder];
    [slug resignFirstResponder];
    [notes resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ContactSelecter"])
    {
        UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
        ContactsTableViewController *piclist = (ContactsTableViewController *)[[navController viewControllers] lastObject];
        piclist.managedObjectContext = managedObjectContext;
    }
    else {
        AudioRecordViewController * logView = segue.destinationViewController;
        if( [logView respondsToSelector: @selector (setManagedObjectContext:)] ) {
            [logView setValue:self.managedObjectContext forKey:@"managedObjectContext"];
        }
        if (currentPicture)
        {
            logView.currentPicture = self.currentPicture;
        }
        
    }
}

@end
