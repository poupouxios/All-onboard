//
//  AOBBaseMapper.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBBaseMapper.h"

@implementation AOBBaseMapper

+ (NSArray *)findAll{
    return [NSArray array];
}

+ (void)printData{
    
}

+ (id) addToDatabase:(NSDictionary *) properties{
    return nil;
}

+ (id) updateRecord:(NSDictionary *) properties{
    return nil;
}

+ (void) deleteRecord:(NSDictionary *) properties{
    
}

+ (NSString *) getCurrentDateValueInString: (NSDate *) dateObject{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd+HH:mm:ss+z"];
    NSString *dateString = [dateFormat stringFromDate:dateObject];
    return dateString;
}

+ (NSDate *) getDateObjectFromString: (NSString *) dateString andDateFormat:(NSString *) dateFormat{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    if(dateFormat.length <= 1){
        dateFormat = @"yyyy-MM-dd+HH:mm:ss+z";
    }
    if(dateString.length <=1){
        dateString = [self get1970Date];
    }
    [df setDateFormat:dateFormat];
    NSDate *date = [[NSDate alloc] init];
    date = [df dateFromString:dateString];
    return date;
}

+ (NSString *) get1970Date{
    NSString *firstDateOn1970 = @"1970-01-01+00:00:00+z";
    return firstDateOn1970;
}

#pragma mark - Convertion

+ (NSNumber *) convertStringToNumber:(NSString *) stringValue{
    if([stringValue isKindOfClass:[NSNumber class]]){
        return (NSNumber *)stringValue;
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *finalNumber = [formatter numberFromString:stringValue];
    return finalNumber;
}

+ (NSNumber *) convertCoordinateStringToNumber:(NSString *)stringValue{
    NSNumber *toNumber = [NSNumber numberWithDouble:stringValue.doubleValue];
    return toNumber;
}

+ (NSString *) convertDictionaryToString:(NSDictionary *) dict{
    NSData *plist = [NSPropertyListSerialization
                     dataWithPropertyList:dict
                     format:NSPropertyListXMLFormat_v1_0
                     options:kNilOptions
                     error:NULL];
    
    NSString *str = [[NSString alloc] initWithData:plist encoding:NSUTF8StringEncoding];
    return str;
}

+ (NSDictionary *) convertStringToDictionary:(NSString *) str{
    NSDictionary *dict = [NSPropertyListSerialization
                          propertyListWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                          options:kNilOptions
                          format:NULL
                          error:NULL];
    return dict;
}

+ (BOOL) checkIfFieldIsNull:(id) entityField{
    if([entityField isKindOfClass:[NSNull class]]){
        return YES;
    }else{
        return NO;
    }
}

+ (id) getValueOfField:(id) entityField andAssigningField:(id)assignField{
    bool isNull = [self checkIfFieldIsNull:entityField];
    if(isNull == YES){
        bool isNull = [self checkIfFieldIsNull:assignField];
        if(!isNull){
            return assignField;
        }else if ([assignField isKindOfClass:[NSNumber class]]){
            return nil;
        }else{
            return @"";
        }
    }
    return entityField;
}

+ (NSString *)pathToCustomFolder:(NSString *) customFolder {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                        NSUserDomainMask,
                                                                        YES) lastObject];
    NSString *customFolderPath = [documentsDirectory stringByAppendingPathComponent:customFolder];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![fileManager fileExistsAtPath:customFolderPath
                           isDirectory:&isDir] && isDir == NO) {
        [fileManager createDirectoryAtPath:customFolderPath
               withIntermediateDirectories:NO
                                attributes:nil
                                     error:nil];
    }
    return customFolderPath;
}

+ (NSString *) writeFileToPath:(NSString *)fileName andFileExtension:(NSString *) fileExtension
                   andFileData:(NSData *) fileData andStoreFolder:(NSString *) customFolder{
    NSString *path = [self  getPathOfFile:fileName andFolder:customFolder];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [fileData writeToFile:path atomically:YES];
        //[[NSFileManager defaultManager] createFileAtPath:path contents:fileData attributes:nil];
        return path;
    }else{
        return @"";
    }
    
}

+ (NSString *) getPathOfFile:(NSString *) fileFullName andFolder:(NSString *) storeFolder{
    NSString *documentsDirectory = [AOBBaseMapper pathToCustomFolder:storeFolder];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileFullName];
    return path;
}

+ (BOOL) isFileExistsAtPath:(NSString *)fileFullName andStoreFolder:(NSString *)storeFolder{
    NSString *documentsDirectory = [AOBBaseMapper pathToCustomFolder:storeFolder];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileFullName];
    if([[NSFileManager defaultManager] fileExistsAtPath:path]){
        return YES;
    }else{
        return NO;
    }
}

+ (void) removeFileFromPath:(NSString *) fileName andFileExtension:(NSString *) fileExtension
             andStoreFolder:(NSString *) customFolder{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [AOBBaseMapper pathToCustomFolder:customFolder];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSError *error = nil;
    if([fileManager fileExistsAtPath:path]){
        [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"File exists: %d", [fileManager fileExistsAtPath:path]]];
        [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"Is deletable file at path: %d", [fileManager isDeletableFileAtPath:path]]];
        BOOL success = [fileManager removeItemAtPath:path error:&error];
        if(!success){
            [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"error occured = %@",[error description]]];
        }
    }else{
        [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"File not exist at path %@",path]];
    }
}

+ (NSString *) getCorrectImageUrl:(NSDictionary *)imageUrls andMainImageUrl:(NSString *)imageUrl andIsThumbnail:(BOOL)isThumbnail{
    NSString *finalImageUrl = imageUrl;
    if(![imageUrls isEqual:[NSNull null]]){
        if (isThumbnail){
            finalImageUrl = [imageUrls objectForKey:@"xxxhdpi_url"];
        }else if([LSCUIDeviceIdentifier isIphone6Plus]){
            finalImageUrl = [imageUrls objectForKey:@"xxhdpi_url"];
        }else if([LSCUIDeviceIdentifier isIpad]){
            finalImageUrl = [imageUrls objectForKey:@"xxxhdpi_url"];
        }else{
            finalImageUrl = [imageUrls objectForKey:@"xhdpi_url"];
        }
    }
    return finalImageUrl;
}

@end
