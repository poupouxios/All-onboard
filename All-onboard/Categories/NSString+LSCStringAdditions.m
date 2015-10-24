//
//  NSString+LLMStringAdditions.m
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "NSString+LSCStringAdditions.h"

@implementation NSString (LSCStringAdditions)

+ (CGFloat) calculateHeightOfString:(UIFont *)font andStringValue:(NSString *)stringValue andWidthSize:(CGFloat)entityWidth{
    CGSize textSize = [stringValue boundingRectWithSize:CGSizeMake(entityWidth, 9999) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil].size;
    
    return textSize.height;
}

@end
