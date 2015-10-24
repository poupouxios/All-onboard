//
//  UIImage+LLMImageAdditions.m
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "UIImage+LLMImageAdditions.h"

@implementation UIImage (LLMImageAdditions)

- (UIImage *)scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (CGSize)calculateSizeOfImageBasedOnDevice{
    CGSize sizeOfImage = self.size;
    CGSize finalSize = self.size;
    CGSize sizeOfDevice = [LSCDeviceDetails getDimensionsOfDevice];
    if(sizeOfDevice.width > sizeOfImage.width){
        return finalSize;
    }else{
        float ratioDifference = sizeOfImage.width / sizeOfDevice.width;
        finalSize = CGSizeMake(sizeOfDevice.width, sizeOfImage.height / ratioDifference);
        return finalSize;
    }
}


@end
