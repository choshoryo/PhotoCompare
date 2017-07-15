//
//  ViewController.m
//  photoCompare
//
//  Created by 张晓龙 on 2017/3/23.
//  Copyright © 2017年 fenqile. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

#import <Photos/Photos.h>

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sourcePhotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *comparedPhotoBtn;
/** source image */
@property (nonatomic, strong) UIImage *sourceImage;
/** compared image */
@property (nonatomic, strong) UIImage *comparedImage;
/** source image picker */
@property (nonatomic, strong) UIImagePickerController *sourceImagePicker;
/** compared image picker */
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
    
    // request & check photo library authorization
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusDenied) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Permission Denied" message:@"Please check the permission of Photo Library" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:alertAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction
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

- (void)selectImageWithType:(NSString *)type {
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    
    if ([type isEqualToString:sourcePickerType]) {
        self.sourceImagePicker = pickerController;
    }
    
    else if ([type isEqualToString:comparedPickerType]) {
        self.comparedImagePicker = pickerController;
    }
    
    // library source type
    pickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;//图片分组列表样式
    
    pickerController.delegate = self;
    
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        
    }];
}

#pragma mark - UIImagePickerControllerDelegate
// Photo library cancel button click capture
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

// Photo library finish picking media
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // save image
    if (picker == self.sourceImagePicker) {
        self.sourceImage = resultImage;
        self.sourcePhotoBtn.enabled = NO;
    }
    
    else if (picker == self.comparedImagePicker) {
        self.comparedImage = resultImage;
        self.comparedPhotoBtn.enabled = NO;
    }

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

@end
