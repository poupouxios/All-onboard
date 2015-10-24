//
//  AOBApiHandler.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBApiHandler.h"

@implementation AOBApiHandler

- (void)getAllCarData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/cars",kApiUrl] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *respondedData = (NSArray *)responseObject;
        [self.delegate aobAPiHAndlerGetNumberOfUpdates:respondedData.count];
        [respondedData enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.delegate aobAPiHandlerNextUpdate];
            [self callTheProperMapper:@"Car" andProperties:obj andStatusChange:@"add"];
        }];
        [self.delegate aobAPIHandlerDidFinishSuccessfully];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"Failed to save: %@",operation]];
    }];
}

- (void) callTheProperMapper:(NSString *) className andProperties:(NSDictionary *)properties andStatusChange:(NSString *) status{
    NSString *mapperName = [NSString stringWithFormat:@"AOB%@Mapper",className];
    [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"mapper to call = %@",mapperName]];
    Class mapper = NSClassFromString(mapperName);
    if(mapper){
        [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"Calling %@ with the %@ method",mapperName,status]];
        if([status isEqualToString:@"add"] || [status isEqualToString:@"insert"]){
            [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"Call the Add method of %@",mapperName]];
            [mapper performSelector:@selector(addToDatabase:) withObject:properties];
        }else if([status isEqualToString:@"update"]){
            [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"Call the Update method of %@",mapperName]];
            [mapper performSelector:@selector(updateRecord:) withObject:properties];
        }else if([status isEqualToString:@"delete"]){
            [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"Call the Delete method of %@",mapperName]];
            [mapper performSelector:@selector(deleteRecord:) withObject:properties];
        }
    }
}


@end
