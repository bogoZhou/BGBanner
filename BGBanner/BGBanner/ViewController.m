//
//  ViewController.m
//  BGBanner
//
//  Created by 周博 on 16/8/25.
//  Copyright © 2016年 BogoZhou. All rights reserved.
//

#import "ViewController.h"
#import "BGBannerView.h"
#import "BGControl.h"

@interface ViewController ()<BGBannerDelegate>
{
    
}
@property (nonatomic,strong) BGBannerView *banner;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creatBanner];
    [self creatColorView];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChanged:) name:kGetMessage object:nil];
}

- (void)creatBanner{
    _banner = [[BGBannerView alloc] initWithFrame:CGRectMake(0, 20, kScreen.width, 180)];
    _banner.delegate = self;
//    _banner.picArray = @[@"1.jpg",@"2.jpg"];
    _banner.isWebImage = NO;
    _banner.bannerType = 1;
    _banner.timerDuration = 2;
    [_banner showBannerWithType];
    [self.view addSubview:_banner];
}

- (void)creatColorView{
    UIView *view = [BGControl creatViewWithFrame:CGRectMake(0, 200, kScreen.width, 100) backgroundColor:kColorFrom0x(0xeeeeee) isLayer:NO cornerRadius:0];
    [self.view addSubview:view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
