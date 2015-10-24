//
//  UITableViewCell+LLMTableCellAdditions.m
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "UITableViewCell+LLMTableCellAdditions.h"

@implementation UITableViewCell (LLMTableCellAdditions)

- (void) applyColorForCells:(BOOL)addChevron andSecondaryColour:(NSString *)secondaryColour{
    [self configureFlatCellWithColor:[UIColor colorFromHexString:kBackgroundColor] selectedColor:[UIColor colorFromHexString:kBorderColour]];
    self.separatorHeight = 5.0f;
    if(addChevron){
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chevron"]];
    }
}

@end
