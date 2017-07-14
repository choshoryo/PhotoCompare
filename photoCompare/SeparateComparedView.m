//
//  SeparateComparedView.m
//  photoCompare
//
//  Created by 张晓龙 on 2017/7/14.
//  Copyright © 2017年 fenqile. All rights reserved.
//

#import "SeparateComparedView.h"

@implementation SeparateComparedView
/** Create imageView with source photo */
+ (instancetype)viewWithSourceImage:(UIImage *)sourceImage {
    if (!sourceImage) return nil;
    
    UIGraphicsBeginImageContext(sourceImage.size);
    
    CGRect rect = CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height);
   
    [sourceImage drawInRect:rect];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    SeparateComparedView *selfView = [[self alloc] init];
    selfView.image = resultingImage;
    
    return selfView;
}

/** Create imageView with compared photo */
+ (instancetype)viewWithComparedImage:(UIImage *)comparedImage {
    if (!comparedImage) return nil;
    
    UIGraphicsBeginImageContext(comparedImage.size);
    
    CGRect rect = CGRectMake(0, 0, comparedImage.size.width, comparedImage.size.height);
    
    [comparedImage drawInRect:rect blendMode:kCGBlendModeNormal alpha:0.4];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    SeparateComparedView *selfView = [[self alloc] init];
    selfView.image = resultingImage;
    
    return selfView;
}

@end
