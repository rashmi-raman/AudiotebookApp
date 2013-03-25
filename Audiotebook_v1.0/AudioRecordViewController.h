//
//  AudioRecordViewController.h
//  Audiotebook_v1.0
//
//  Created by Robert Walport on 2/16/13.
//  Copyright (c) 2013 Hacks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Contact.h"

@interface AudioRecordViewController : UIViewController

@property  (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Contact *currentPicture;
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) IBOutlet UIButton *recordButton;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;

@property (weak, nonatomic) IBOutlet UILabel *recordingLabel;

- (IBAction)recordAudio:(id)sender;
- (IBAction)playAudio:(id)sender;
- (IBAction)stop:(id)sender;

@end
