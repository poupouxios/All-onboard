//
//  NSString+LLMStringAdditions.h
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LSCStringAdditions)

+ (CGFloat) calculateHeightOfString:(UIFont *)font andStringValue:(NSString *)stringValue andWidthSize:(CGFloat)entityWidth;

@end
