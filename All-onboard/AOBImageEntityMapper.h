//
//  LSCImageEntityMapper.h
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//


#import "AOBBaseMapper.h"

@interface AOBImageEntityMapper : AOBBaseMapper

+ (NSString *) getImageName:(NSURL *)imageUrl;
+ (ImageEnt *)findOneByImageName:(NSString *)imageName;
+ (ImageEnt *) generateImage:(NSString *)imageUrl;

@end
