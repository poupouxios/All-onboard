//
//  NSURL+LSCURLAdditions.m
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "NSURL+LSCURLAdditions.h"

@implementation NSURL (LSCURLAdditions)

+ (NSURL *) getAssetPath:(NSString *) fileName andExtension:(NSString *)fileExtension andFilePath:(NSString *)filePath{
    NSString *fileFullName = [NSString stringWithFormat:@"%@.%@",fileName,fileExtension];
    NSURL *entityUrl = nil;
    if([fileFullName isEqualToString:filePath]){
        entityUrl = [[NSBundle mainBundle] URLForResource:fileName withExtension:fileExtension];
    }else if(filePath != nil){
        entityUrl = [NSURL fileURLWithPath:filePath];
    }
    return entityUrl;
}

@end
