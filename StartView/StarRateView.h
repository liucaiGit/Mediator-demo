//
//  StarRateView.h
//  XHStarRateView
//
//  Created by liucai on 2017/10/16.
//  Copyright © 2017年 jxh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,StarRateStyle) {
    wholeStarRate = 0,                  //完整星评分
    halfStarRate = 1,                  //半星评分
    incompleteStarRate = 2            //不完整星评分
};

@interface StarRateView : UIView

//留给外部设置星级的入口  默认为0
@property (nonatomic, assign) float currentScore;

//评分总星星数  默认为5
@property (nonatomic, assign) NSInteger numberOfStars;

//是否响应用户点击  默认不响应
@property (nonatomic, assign) BOOL isResponseUserInteractionEnabled;

//评分类型  默认是完整星评分
@property (nonatomic, assign) StarRateStyle rateStyle;

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame CurrentScore:(CGFloat) currentScore numberOfStars:(NSInteger)numberOfStars isResponseUserInteractionEnabled:(BOOL)isResponUserinteractionEnabled rateStyle:(StarRateStyle)rateStyle;

@end
