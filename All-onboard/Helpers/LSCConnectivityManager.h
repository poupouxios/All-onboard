//
//  LSCConnectivityManager.h
//  Situate
//
//  Created by Valentinos Papasavvas on 27/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Reachability/Reachability.h>

@interface LSCConnectivityManager : NSObject

+ (NetworkStatus)getNetworkStatus;
+ (BOOL) checkIfPhoneIsConnectedToInternet;

@end
