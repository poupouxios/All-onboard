//
//  AOBBaseMapper.h
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"
#import "ImageEnt.h"

@interface AOBBaseMapper : NSObject

+ (NSArray *) findAll;
+ (void) printData;
+ (id) addToDatabase:(NSDictionary *) properties;
+ (id) updateRecord:(NSDictionary *) properties;
+ (void) deleteRecord:(NSDictionary *) properties;
+ (NSString *) getCurrentDateValueInString: (NSDate *) dateObject;
+ (NSDate *) getDateObjectFromString: (NSString *) dateString andDateFormat:(NSString *) dateFormat;
+ (NSNumber *) convertStringToNumber:(NSString *) stringValue;
+ (id) getValueOfField:(id) entityField andAssigningField:(id)assignField;
+ (NSString *)pathToCustomFolder:(NSString *) customFolder;
+ (NSString *) writeFileToPath:(NSString *)fileName andFileExtension:(NSString *) fileExtension
                   andFileData:(NSData *) fileData andStoreFolder:(NSString *) customFolder;
+ (void) removeFileFromPath:(NSString *) fileName andFileExtension:(NSString *) fileExtension
             andStoreFolder:(NSString *) customFolder;
+ (BOOL) isFileExistsAtPath:(NSString *)fileFullName andStoreFolder:(NSString *)storeFolder;
+ (NSString *) getPathOfFile:(NSString *) fileFullName andFolder:(NSString *) storeFolder;
+ (NSDictionary *) convertStringToDictionary:(NSString *) str;
+ (NSString *) convertDictionaryToString:(NSDictionary *) dict;
+ (NSString *) get1970Date;
+ (NSString *) getCorrectImageUrl:(NSDictionary *)imageUrls andMainImageUrl:(NSString *)imageUrl andIsThumbnail:(BOOL)isThumbnail;

@end
