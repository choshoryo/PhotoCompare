//
//  ViewController.m
//  photoCompare
//
//  Created by 张晓龙 on 2017/3/23.
//  Copyright © 2017年 fenqile. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sourcePhotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *comparedPhotoBtn;
/** 源图片 */
@property (nonatomic, strong) UIImage *sourceImage;
/** 对比图片 */
@property (nonatomic, strong) UIImage *comparedImage;
/** 原图片选择器 */
@property (nonatomic, strong) UIImagePickerController *sourceImagePicker;
/** 对比图片选择器 */
@property (nonatomic, strong) UIImagePickerController *comparedImagePicker;
@end

static NSString *sourcePickerType = @"sourceImagePicker";
static NSString *comparedPickerType = @"comparedImagePicker";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.hidesBarsOnTap = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sourcePhotoClick:(id)sender {
    [self selectImageWithType:sourcePickerType];
}
- (IBAction)comparedPhotoClick:(id)sender {
    [self selectImageWithType:comparedPickerType];
}
- (IBAction)clearPhotosClick:(id)sender {
    self.sourceImage = nil;
    self.comparedImage = nil;
    self.sourcePhotoBtn.enabled = YES;
    self.comparedPhotoBtn.enabled = YES;
    
}
- (IBAction)compareClick:(id)sender {
    if (self.sourceImage && self.comparedImage) {

        ResultViewController *vc = [[ResultViewController alloc] init];
        vc.sourcePhoto = self.sourceImage;
        vc.comparedPhoto = self.comparedImage;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// 选择图片的方法
- (void)selectImageWithType:(NSString *)type {
    
    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    
    if ([type isEqualToString:sourcePickerType]) {
        self.sourceImagePicker = pickerController;
    }
    
    else if ([type isEqualToString:comparedPickerType]) {
        self.comparedImagePicker = pickerController;
    }
    
    //设置选取的照片是否可编辑
//    pickerController.allowsEditing = YES;
    //设置相册呈现的样式
    pickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
    pickerController.delegate = self;
    //使用模态呈现相册
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        
    }];
}

#pragma mark - UIImagePickerControllerDelegate
//点击取消按钮所执行的方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

//选择照片完成之后的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //info是所选择照片的信息
    
    //    UIImagePickerControllerEditedImage//编辑过的图片
    //    UIImagePickerControllerOriginalImage//原图
    
    
    NSLog(@"%@",info);
    //刚才已经看了info中的键值对，可以从info中取出一个UIImage对象，将取出的对象赋给按钮的image
    
//    UIButton *button = (UIButton *)[self.view viewWithTag:1004];
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // 保存图片
    if (picker == self.sourceImagePicker) {
        self.sourceImage = resultImage;
        self.sourcePhotoBtn.enabled = NO;
    }
    
    else if (picker == self.comparedImagePicker) {
        self.comparedImage = resultImage;
        self.comparedPhotoBtn.enabled = NO;
    }
    
    /*
    [button setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];//如果按钮创建时用的是系统风格UIButtonTypeSystem，需要在设置图片一栏设置渲染模式为"使用原图"
    
    
    //裁成边角
    button.layer.cornerRadius = 100;
    button.layer.masksToBounds = YES;
    */
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

@end
