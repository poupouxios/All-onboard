//
//  UILabel+LLMLabelAdditions.m
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "UILabel+LSCLabelAdditions.h"

@implementation UILabel (LSCLabelAdditions)

- (float) getHeightOfLabel:(UILabel *) entityLabel andNumberOfCharactersPerLine:(int)noOfChars{
    int defaultCharactersFitInOneLine = noOfChars;
    if([entityLabel.text length] <= defaultCharactersFitInOneLine){
        return 35.0f;
    }else{
        BOOL foundProperMultiple = NO;
        int numberOfLines = 2;
        NSUInteger labelLength = [entityLabel.text length];
        while(!foundProperMultiple){
            if(labelLength >= defaultCharactersFitInOneLine && ((labelLength <= defaultCharactersFitInOneLine * numberOfLines) )){
                foundProperMultiple = YES;
            }else{
                defaultCharactersFitInOneLine = defaultCharactersFitInOneLine * numberOfLines;
                numberOfLines++;
            }
        }
        return (numberOfLines * 35);
    }
}

@end
