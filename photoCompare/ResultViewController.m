//
//  ResultViewController.m
//  photoCompare
//
//  Created by 张晓龙 on 2017/3/23.
//  Copyright © 2017年 fenqile. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.hidesBarsOnTap = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [self getComparedView];
    [self.view addSubview:imageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 展示对比图层
- (UIImage *)getComparedView {
    if (!self.sourcePhoto || !self.comparedPhoto) return nil;
    
    UIImage *sourcePic = self.sourcePhoto;
    UIImage *comparedPic = self.comparedPhoto;
    
    UIGraphicsBeginImageContext(self.sourcePhoto.size);

    CGRect rect = CGRectMake(0, 0, sourcePic.size.width, sourcePic.size.height);
    // 绘制底图
    [sourcePic drawInRect:rect];
    // 绘制对比图
    [comparedPic drawInRect:rect blendMode:kCGBlendModeNormal alpha:0.4];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

@end
