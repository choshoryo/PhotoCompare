//
//  ResultViewController.m
//  photoCompare
//
//  Created by 张晓龙 on 2017/3/23.
//  Copyright © 2017年 fenqile. All rights reserved.
//

#import "ResultViewController.h"

#import "IntegrateComparedView.h"
#import "SeparateComparedView.h"

@interface ResultViewController ()<UIScrollViewDelegate>
#pragma mark Navigation Items
/** Right item one */
@property (nonatomic, strong) UIBarButtonItem *rightItemOne;
/** Right item button one */
@property (nonatomic, strong) UIButton *rightItemBtnOne;
/** Right item two */
@property (nonatomic, strong) UIBarButtonItem *rightItemTwo;
#pragma mark Components
/** Container */
@property (nonatomic, strong) UIScrollView *container;
/** Compared view */
@property (nonatomic, strong) UIImageView *comparedView;
/** Source photo view */
@property (nonatomic, strong) UIImageView *sourcePhotoView;
/** Compared photo view */
@property (nonatomic, strong) UIImageView *comparedPhotoView;
#pragma mark Global State
/** Switcher */
@property (nonatomic, assign, getter=isIntegrate) BOOL integrate;
@end

static NSString *titleRestore = @"Restore";
static NSString *titleIntegrateMode = @"IntegrateMode";
static NSString *titleSeparateMode = @"SeparateMode";
@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.hidesBarsOnTap = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor grayColor];
    
    // Default integrate mode
    self.integrate = YES;
    
    [self setupNaviItems];
    
    // Scroll view container
    UIScrollView *container = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:container];
    self.container = container;
    
    // Source photo view
    [self createSourcePhotoView];
    
    // Compared photo view
    [self createComparedPhotoView];
    
    // Compared view with compared and source photo
    [self createComparedView];
    
    [self.container addSubview:self.sourcePhotoView];
    [self.container addSubview:self.comparedPhotoView];
    [self.container addSubview:self.comparedView];
    
    // Components default visibility
    self.sourcePhotoView.hidden = YES;
    self.comparedPhotoView.hidden = YES;
    self.comparedView.hidden = NO;
    
    // Set up container can zoom
    container.delegate = self;
    container.maximumZoomScale = 3.0;
    container.minimumZoomScale = 1.0;
    
    // Gesture
    [self longPressGestureRecognizer];

}

// Set up navi items
- (void)setupNaviItems {
    // Right item one
    UIButton *rightBtnOne = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtnOne addTarget:self action:@selector(modeSwitch) forControlEvents:UIControlEventTouchUpInside];
    [rightBtnOne setTitle:titleIntegrateMode forState:UIControlStateNormal];
    [rightBtnOne sizeToFit];
    UIBarButtonItem *rightItemOne = [[UIBarButtonItem alloc] initWithCustomView:rightBtnOne];
    self.rightItemOne = rightItemOne;
    self.rightItemBtnOne = rightBtnOne;
    
    // Right item two
    UIButton *rightBtnTwo = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtnTwo addTarget:self action:@selector(zoomRestore) forControlEvents:UIControlEventTouchUpInside];
    [rightBtnTwo setTitle:titleRestore forState:UIControlStateNormal];
    [rightBtnTwo sizeToFit];
    UIBarButtonItem *rightItemTwo = [[UIBarButtonItem alloc] initWithCustomView:rightBtnTwo];
    self.rightItemTwo = rightItemTwo;
    
    // Add items
    self.navigationItem.rightBarButtonItems = @[rightItemTwo, rightItemOne];
    
}

// Create compared view with compared and source photo
- (void)createComparedView {
    UIImageView *comparedView = [IntegrateComparedView viewWithSourceImage:self.sourcePhoto andComparedImage:self.comparedPhoto];
    comparedView.frame = self.view.bounds;
    self.comparedView = comparedView;
}

// Create source photo view
- (void)createSourcePhotoView {
    UIImageView *sourcePhotoView = [[UIImageView alloc] initWithImage:self.sourcePhoto];
    sourcePhotoView.frame = self.view.bounds;
    self.sourcePhotoView = sourcePhotoView;
}

// Create compared photo view
- (void)createComparedPhotoView {
    UIImageView *comparedPhotoView = [SeparateComparedView viewWithComparedImage:self.comparedPhoto];
    comparedPhotoView.frame = self.view.bounds;
    self.comparedPhotoView = comparedPhotoView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (self.isIntegrate) {
        return self.comparedView;
    }
    else {
        return nil;
    }
}

#pragma mark - User Interaction
- (void)zoomRestore {
    [self.container setZoomScale:1.0];
}

- (void)modeSwitch {
    self.integrate = !self.isIntegrate;
    
    BOOL flag = self.isIntegrate;
    
    self.sourcePhotoView.hidden = flag;
    self.comparedPhotoView.hidden = YES;
    self.comparedView.hidden = !flag;
    
    // Set navi items
    if (flag) {
        [self.rightItemBtnOne setTitle:titleIntegrateMode forState:UIControlStateNormal];
        
        self.navigationItem.rightBarButtonItems = @[self.rightItemTwo, self.rightItemOne];
    }
    else {
        [self.rightItemBtnOne setTitle:titleSeparateMode forState:UIControlStateNormal];
        
        self.navigationItem.rightBarButtonItems = @[self.rightItemOne];
    }
}

#pragma mark - Long Press Gesture
-(void)longPressGestureRecognizer
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    
    longPress.minimumPressDuration = 0.5;
    
    longPress.allowableMovement = 1;
    
    [self.container addGestureRecognizer:longPress];
    
}

-(void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    if (self.isIntegrate == YES) return;
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        self.comparedPhotoView.hidden = NO;
    }
    else if (longPress.state == UIGestureRecognizerStateEnded) {
        self.comparedPhotoView.hidden = YES;
    }
    
}

@end
