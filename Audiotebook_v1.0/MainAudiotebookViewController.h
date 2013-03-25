//
//  MainAudiotebookViewController.h
//  Audiotebook_v1.0
//
//  Created by Robert Walport on 2/13/13.
//  Copyright (c) 2013 Hacks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UserPrefs.h"
#import "DisplayContactViewController.h"
#import "MenuViewController.h"
#import "CoreDataHelper.h"



@interface MainAudiotebookViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate>
{
@public
    NSString *selectedAudioFile;
    UIImage *selectedImageFile;
    NSArray *directoryContents;
    NSFileManager *fileManager ;
    NSArray *paths;
    NSString *documentsDirectory;
    NSString *latitudeString;
    NSString *longitudeString;
    
}

@property  (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) CLLocation *startingPoint;

@property (strong, nonatomic) Contact *currentPicture;

@property (weak, nonatomic) IBOutlet UITextField *contactName;

@property (weak, nonatomic) IBOutlet UITextField *slug;

@property (weak, nonatomic) IBOutlet UITextField *notes;

@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;

@property (weak, nonatomic) IBOutlet UILabel *photoMessage;

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;

@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;

@property (strong, nonatomic) NSString *currentContact;

@property (weak,nonatomic) NSMutableData *responseData;

- (IBAction)addPhoto:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)addAudio:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)submit:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)reset:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)textFieldDoneEditing:(id)sender;

- (IBAction)backgroundTap:(id)sender;



@end

