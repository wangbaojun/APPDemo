//
//  VTFireButton.m
//  SZDT_Partents
//
//  Created by 杨胜超 on 15/5/28.
//  Copyright (c) 2015年 szdt. All rights reserved.
//

#import "VTFireButton.h"
#import "VTFireView.h"
@interface VTFireButton ()

@property (nonatomic,strong)VTFireView *fireworksView;

@end

@implementation VTFireButton


- (void)setup {
    self.clipsToBounds = NO;
    
    _fireworksView = [[VTFireView alloc] init];
    [self insertSubview:_fireworksView atIndex:0];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.fireworksView.frame = self.bounds;
    
    [self insertSubview:self.fireworksView atIndex:0];
}

#pragma mark - Methods

- (void)animate {
    [self.fireworksView animate];
}

- (void)popOutsideWithDuration:(NSTimeInterval)duration {
    __weak typeof(self) weakSelf = self;
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:nil];
}

- (void)popInsideWithDuration:(NSTimeInterval)duration {
    __weak typeof(self) weakSelf = self;
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 2.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:nil];
}

#pragma mark - Properties

- (UIImage *)particleImage {
    return self.fireworksView.particleImage;
}

- (void)setParticleImage:(UIImage *)particleImage {
    self.fireworksView.particleImage = particleImage;
}

- (CGFloat)particleScale {
    return self.fireworksView.particleScale;
}

- (void)setParticleScale:(CGFloat)particleScale {
    self.fireworksView.particleScale = particleScale;
}

- (CGFloat)particleScaleRange {
    return self.fireworksView.particleScaleRange;
}

- (void)setParticleScaleRange:(CGFloat)particleScaleRange {
    self.fireworksView.particleScaleRange = particleScaleRange;
}


@end
