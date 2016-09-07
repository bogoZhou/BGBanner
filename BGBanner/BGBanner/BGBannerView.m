//
//  BGBannerView.m
//  BGBanner
//
//  Created by 周博 on 16/8/25.
//  Copyright © 2016年 BogoZhou. All rights reserved.
//

#import "BGBannerView.h"
#define kImageTag 10000

@interface BGBannerView ()
{
    int count;
}
@property (nonatomic,strong) NSTimer *bannerTimer;
@end

@implementation BGBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _picImageView = [[UIImageView alloc] initWithFrame:frame];
        _picImageView.userInteractionEnabled = YES;
        _picImageView.layer.masksToBounds = YES;
        _picImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)showBannerWithType{
    self.userInteractionEnabled = YES;
    _picArray = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"];
    
    //是否是网路图片
    if (_isWebImage) {//使用网络图片加载方法
        //使用sdwebImage
    }else{//创建默认图片
        _picImageView.image = [UIImage imageNamed:_picArray[0]];//默认图片
    }
    _picImageView.tag = kImageTag;
    [self addSubview:_picImageView];
    
    //单击选中图片手势
    UITapGestureRecognizer *oneClickGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneClickGesture:)];
    [_picImageView addGestureRecognizer:oneClickGesture];
    
    //添加左右滑动手势
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftMoveGesture:)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [_picImageView addGestureRecognizer:leftGesture];

    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightMoveGesture:)];
    rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [_picImageView addGestureRecognizer:rightGesture];
    
    if (_picArray.count > 1) {
        count = 0;//页面刚出现时不出现转动动画
        //创建Timer
        _bannerTimer = [NSTimer scheduledTimerWithTimeInterval:_timerDuration target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        [_bannerTimer setFireDate:[NSDate distantPast]];
    }
}

- (void)timerRun{
    if (count == 0) {
        count ++;
    }else{
        [self leftMoveGesture:nil];
    }
    
}

#pragma mark - 过场动画
- (void)transitionAnimation:(BOOL)isPass{
    CATransition *transitionA = [[CATransition alloc] init];
    NSString *type;
    switch (_bannerType) {
        case BannerType_Cube:
            type = @"cube";
            break;
        case BannerType_Fade:
            type = kCATransitionFade;
            break;
        case BannerType_MoveIn:
            type = kCATransitionMoveIn;
            break;
        case BannerType_Push:
            type = kCATransitionPush;
            break;
        case BannerType_Reveal:
            type = kCATransitionReveal;
            break;
        case BannerType_PageCurl:
            type = @"pageCurl";
            break;
        case BannerType_PageUnCurl:
            type = @"pageUnCurl";
            break;
        case BannerType_RippleEffect:
            type = @"rippleEffect";
            break;
        case BannerType_SuckEffect:
            type = @"suckEffect";
            break;
        case BannerType_OglFlip:
            type = @"oglFlip";
            break;
        default:
            type = kCATransitionPush;
            break;
    }
    transitionA.type = type;//设置动画效果
    
    //设置左右滑动类型
    if (isPass) {
        transitionA.subtype = kCATransitionFromRight;
    }else{
        transitionA.subtype = kCATransitionFromLeft;
    }
    
    transitionA.duration = 0.7;
    
    //转场动画结束后更换新图片
    [self getNewImage:isPass];
    [_picImageView.layer addAnimation:transitionA forKey:@"KCTransitionAnimation"];
    
}

//更换新的图片
- (void)getNewImage:(BOOL)isPass{
    if (isPass) {
        _picIndex = (++_picIndex)%(int)_picArray.count;
    }else{
        _picIndex = (--_picIndex + _picArray.count)%(int)_picArray.count;
    }
    _picImageView.tag = _picIndex + kImageTag;
    
    UITapGestureRecognizer *oneClickGresture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneClickGesture:)];
    [_picImageView addGestureRecognizer:oneClickGresture];
    if (_isWebImage){
        //使用sdWebImage
    }else{
        _picImageView.image = [UIImage imageNamed:_picArray[_picIndex]];
    }
}

#pragma mark - 手势
//单击图片手势
- (void)oneClickGesture:(UITapGestureRecognizer *)gesture{
    [_delegate clickBannerImage:(int)gesture.view.tag - kImageTag];
}

//左滑手势
- (void)leftMoveGesture:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}

//右滑手势
- (void)rightMoveGesture:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}
@end
