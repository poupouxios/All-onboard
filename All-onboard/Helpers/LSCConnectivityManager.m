//
//  LSCConnectivityManager.m
//  Situate
//
//  Created by Valentinos Papasavvas on 27/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "LSCConnectivityManager.h"

@implementation LSCConnectivityManager

+ (NetworkStatus)getNetworkStatus{
    Reachability *reachInternet = [Reachability reachabilityForInternetConnection];
    [reachInternet startNotifier];
    NetworkStatus status = [reachInternet currentReachabilityStatus];
    return status;
}

+ (BOOL) checkIfPhoneIsConnectedToInternet{
    NetworkStatus status = [self getNetworkStatus];
    if (status == NotReachable){
        return false;
    }
    return true;
}

@end
