//
//  IntegrateComparedView.h
//  photoCompare
//
//  Created by 张晓龙 on 2017/7/14.
//  Copyright © 2017年 fenqile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegrateComparedView : UIImageView
/** Create imageView with source photo */
+ (instancetype)viewWithSourceImage:(UIImage *)sourceImage andComparedImage:(UIImage *)comparedImage;
@end
