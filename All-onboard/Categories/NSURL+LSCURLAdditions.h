//
//  NSURL+LSCURLAdditions.h
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (LSCURLAdditions)

+ (NSURL *) getAssetPath:(NSString *) fileName andExtension:(NSString *)fileExtension andFilePath:(NSString *)filePath;

@end
