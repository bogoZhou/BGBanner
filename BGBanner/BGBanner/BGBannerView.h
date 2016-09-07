//
//  BGBannerView.h
//  BGBanner
//
//  Created by 周博 on 16/8/25.
//  Copyright © 2016年 BogoZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreen [UIScreen mainScreen].bounds.size



@protocol BGBannerDelegate <NSObject>

/**
 *  设置代理选择点击图片的index
 *
 *  @param index 点击图片的下标
 */
- (void)clickBannerImage:(int)index;

@end

@interface BGBannerView : UIView

enum BannerType{
    BannerType_Cube = 1,//立方体
    BannerType_Fade,//渐变
    BannerType_MoveIn,//推挤
    BannerType_Push,//类似push
    BannerType_Reveal,//上层移动
    BannerType_PageCurl,//向上翻页
    BannerType_PageUnCurl,//向下翻页
    BannerType_RippleEffect,//水滴效果
    BannerType_SuckEffect,//收缩效果
    BannerType_OglFlip//上下翻转效果
};

//图片下标
@property (nonatomic,assign) int picIndex;

//图片
@property (nonatomic,strong) UIImageView *picImageView;

//图片数组
@property (nonatomic,strong) NSMutableArray *picArray;

//是否是网络图片
@property (nonatomic,assign) BOOL isWebImage;

//计时器转动间隔
@property (nonatomic,assign) NSTimeInterval timerDuration;

//选择banner类型
@property (nonatomic,assign) enum BannerType bannerType;

@property (nonatomic,assign) id <BGBannerDelegate> delegate;

/**
 *  @param bannerType BannerType;
 */
- (void)showBannerWithType;

@end
