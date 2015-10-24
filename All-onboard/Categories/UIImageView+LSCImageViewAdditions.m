//
//  UIImageView+LLMImageViewAdditions.m
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "UIImageView+LSCImageViewAdditions.h"

@implementation UIImageView (LSCImageViewAdditions)

- (void)scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [self.image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = newImage;
}

- (CGSize)calculateSizeOfImageBasedOnDevice{
    CGSize sizeOfImage = self.image.size;
    CGSize finalSize = self.image.size;
    CGSize sizeOfDevice = [LSCDeviceDetails getDimensionsOfDevice];
    if(sizeOfDevice.width > sizeOfImage.width){
        return finalSize;
    }else{
        float ratioDifference = sizeOfImage.width / sizeOfDevice.width;
        finalSize = CGSizeMake(sizeOfDevice.width, sizeOfImage.height / ratioDifference);
        return finalSize;
    }
}

- (void) setImageUI:(NSString *) fileName andExtension:(NSString *)fileExtension{
    UIImage *imageUIObject = [UIImage imageNamed:[NSString stringWithFormat:@"%@.%@",fileName,fileExtension]];
    self.image = imageUIObject;
}



@end
