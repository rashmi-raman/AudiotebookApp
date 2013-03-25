//
//  Contact.h
//  Audiotebook_v1.0
//
//  Created by Robert Walport on 3/10/13.
//  Copyright (c) 2013 Hacks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * job;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * smallPicture;

@end
