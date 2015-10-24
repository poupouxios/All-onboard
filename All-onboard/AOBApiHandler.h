//
//  AOBApiHandler.h
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AOBApiHandlerDelegate <NSObject>

@required

- (void) aobAPIHandlerDidFinishSuccessfully;
- (void) aobAPIHandlerDidFailUpdate:(NSString *)failedMessage;
- (void) aobAPiHandlerNextUpdate;
- (void) aobAPiHAndlerGetNumberOfUpdates:(float)numberOfUpdates;

@end

@interface AOBApiHandler : NSObject

@property (nonatomic,weak) id<AOBApiHandlerDelegate> delegate;
- (void)getAllCarData;

@end
