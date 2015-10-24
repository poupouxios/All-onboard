//
//  UIImage+LLMImageAdditions.h
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LLMImageAdditions)

- (CGSize) calculateSizeOfImageBasedOnDevice;
- (UIImage *)scaledToSize:(CGSize)newSize;

@end
