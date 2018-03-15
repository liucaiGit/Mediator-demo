//
//  StarRateView.m
//  XHStarRateView
//
//  Created by liucai on 2017/10/16.
//  Copyright © 2017年 jxh. All rights reserved.
//

#import "StarRateView.h"

#define eachStarWidth (self.bounds.size.width / _numberOfStars)

#define eachStarHeight self.bounds.size.height

static NSString *grayImageName = @"b27_icon_star_gray";
static NSString *yellowImageName = @"b27_icon_star_yellow";

@interface StarRateView ()

@property (nonatomic, strong) UIView *foregroundView;

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation StarRateView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfStars = 5;
        self.isResponseUserInteractionEnabled = NO;
        self.rateStyle = wholeStarRate;
        self.currentScore = 0.f;
        
        [self createSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame CurrentScore:(CGFloat)currentScore numberOfStars:(NSInteger)numberOfStars isResponseUserInteractionEnabled:(BOOL)isResponUserinteractionEnabled rateStyle:(StarRateStyle)rateStyle  {
    if (self = [super initWithFrame:frame]) {
        self.currentScore = currentScore;
        self.numberOfStars = numberOfStars;
        self.isResponseUserInteractionEnabled = isResponUserinteractionEnabled;
        self.rateStyle = rateStyle;
        
        [self createSubviews];
    }
    return self;
}
#pragma mark - initialization
- (void)createSubviews {
    self.foregroundView = [self createStarView:yellowImageName];
    self.backgroundView = [self createStarView:grayImageName];
    
    self.foregroundView.frame = CGRectMake(0, 0, eachStarWidth * self.currentScore, eachStarHeight);
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.foregroundView];
}

- (UIView *)createStarView:(NSString *)imageName {
    UIView *starView = [[UIView alloc] initWithFrame:self.bounds];
    starView.clipsToBounds = YES;
    starView.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < self.numberOfStars; i++) {
        UIImageView *starImageV = [[UIImageView alloc] init];
        starImageV.frame = CGRectMake(i * eachStarWidth, 0, eachStarWidth, eachStarHeight);
        starImageV.image = [UIImage imageNamed:imageName];
        starImageV.contentMode = UIViewContentModeScaleAspectFit;
        [starView addSubview:starImageV];
    }
    return starView;
}

- (void)userTapRateView:(UITapGestureRecognizer *)gestureRecognizer {
    //获取点击的位置
    CGPoint tapPoint = [gestureRecognizer locationInView:self];
    CGFloat pointX = tapPoint.x;
    //计算评分0~1
    CGFloat starRate = pointX / self.bounds.size.width * _numberOfStars;
    /** ceilf 向上取整   roundf 四舍五入  floorf 向下取整*/
    switch (self.rateStyle) {
        case wholeStarRate:
        {
            self.currentScore = ceilf(starRate);
        }
            break;
        case halfStarRate:
        {
            self.currentScore = roundf(starRate) > starRate ? roundf(starRate) : (floorf(starRate) + 0.5);
        }
            break;
        case incompleteStarRate:
        {
            self.currentScore = starRate;
        }
            break;
        default:
            break;
    }
}

- (void)setCurrentScore:(float)currentScore {
    if (_currentScore == currentScore) {
        return;
    }
    if (_currentScore < 0) {
        _currentScore = 0;
    }else if (_currentScore > _numberOfStars) {
        _currentScore = _numberOfStars;
    }else {
        _currentScore = currentScore;
    }
    self.foregroundView.frame = CGRectMake(0, 0, eachStarWidth * self.currentScore, eachStarHeight);
    
}

- (void)setIsResponseUserInteractionEnabled:(BOOL)isResponseUserInteractionEnabled {
    if (_isResponseUserInteractionEnabled != isResponseUserInteractionEnabled) {
        _isResponseUserInteractionEnabled = isResponseUserInteractionEnabled;
        
        if (_isResponseUserInteractionEnabled) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
            tapGesture.numberOfTapsRequired = 1;
            [self addGestureRecognizer:tapGesture];
        }
    }
}

@end
