//
//  UILabel+LLMLabelAdditions.h
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LSCLabelAdditions)

- (float) getHeightOfLabel:(UILabel *) entityLabel andNumberOfCharactersPerLine:(int) noOfChars;

@end
