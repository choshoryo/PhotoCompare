//
//  IntegrateComparedView.m
//  photoCompare
//
//  Created by 张晓龙 on 2017/7/14.
//  Copyright © 2017年 fenqile. All rights reserved.
//

#import "IntegrateComparedView.h"

@implementation IntegrateComparedView

+ (instancetype)viewWithSourceImage:(UIImage *)sourceImage andComparedImage:(UIImage *)comparedImage {
    if (!sourceImage || !comparedImage) return nil;
    
    UIGraphicsBeginImageContext(sourceImage.size);
    
    CGRect rect = CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height);
   
    [sourceImage drawInRect:rect];
   
    [comparedImage drawInRect:rect blendMode:kCGBlendModeNormal alpha:0.4];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    IntegrateComparedView *selfView = [[self alloc] init];
    selfView.image =resultingImage;
    
    return selfView;
}

@end
