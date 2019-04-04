//
//  LFvideoButtonView.m
//  刘飞
//
//  Created by souge 3 on 2018/8/28.
//  Copyright © 2018年 souge 3. All rights reserved.
//
#define kScreenWidth      [UIScreen mainScreen].bounds.size.width
#define kScreenHeight      [UIScreen mainScreen].bounds.size.height

#import "LFvideoButtonView.h"


@interface LFvideoButtonView (){
    UIView *cycView;
    UIView *buttonview;
    UIButton *button;
    CAShapeLayer *layer1;
    CAShapeLayer *layer2;
    
    CAShapeLayer *outLaye;
    CAShapeLayer *progressLayer;
    UILabel *timerLabel;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
}

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) int count;

@end

@implementation LFvideoButtonView

- (instancetype)initWithOriginY:(CGFloat)originY{
    self = [super initWithFrame:CGRectMake(0, originY, kScreenWidth, 140)];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, frame.origin.y, kScreenWidth, 140)];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    cycView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-140)/2.0, 0, 140, 140)];
    cycView.hidden = YES;
    [self addSubview:cycView];
    cycView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:cycView.bounds];
    outLaye = [CAShapeLayer layer];
    outLaye.strokeColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    outLaye.lineWidth = 4;
    outLaye.fillColor =  [UIColor clearColor].CGColor;
    outLaye.path = path.CGPath;
    [cycView.layer addSublayer:outLaye];
    
    progressLayer = [CAShapeLayer layer];
    progressLayer.fillColor = [UIColor clearColor].CGColor;
    progressLayer.strokeColor = [UIColor redColor].CGColor;
    progressLayer.lineWidth = 8;
    progressLayer.lineCap = kCALineCapRound;
    progressLayer.path = path.CGPath;
    progressLayer.strokeEnd = 0;
    [cycView.layer addSublayer:progressLayer];
    
    buttonview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    buttonview.center = cycView.center;
    [self addSubview:buttonview];
    
    timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(cycView.frame.size.width, cycView.frame.size.height/2.0-12, 84, 24)];
    timerLabel.textColor = [UIColor whiteColor];
    timerLabel.font = [UIFont systemFontOfSize:20];
    timerLabel.textAlignment = NSTextAlignmentCenter;
    [cycView addSubview:timerLabel];
    timerLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
    timerLabel.text = @"0:00";
    //    timerLabel.hidden = YES;
    
    button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 50, 50);
    button.center = cycView.center;
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 25;
    //    [button addTarget:self action:@selector(buttonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    //    button.hidden = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0;
    [button addGestureRecognizer:longPress];
    
    [self addSubview:button];
    
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:buttonview.bounds];
    
    layer2 = [CAShapeLayer layer];
    layer2.fillColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    layer2.path = path2.CGPath;
    [buttonview.layer addSublayer:layer2];
    
    button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button1.frame = buttonview.frame;
    //    button1.backgroundColor = [UIColor whiteColor];
    button1.layer.cornerRadius = 35;
    [button1 setTitle:@"返回" forState:(UIControlStateNormal)];
    [button1 setImage:[UIImage imageNamed:@"LFreturn"] forState:(UIControlStateNormal)];
    [button1 addTarget:self action:@selector(returnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:button1];
    button1.hidden = YES;
    button1.alpha = 0;
    
    button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button2.frame = buttonview.frame;
    //    button2.backgroundColor = [UIColor whiteColor];
    button2.layer.cornerRadius = 35;
    [button2 setTitle:@"音乐" forState:(UIControlStateNormal)];
    [button2 setImage:[UIImage imageNamed:@"LFaddMusic"] forState:(UIControlStateNormal)];
    [button2 addTarget:self action:@selector(addMusicClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:button2];
    button2.hidden = YES;
    button2.alpha = 0;
    
    button3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button3.frame = buttonview.frame;
    //    button3.backgroundColor = [UIColor whiteColor];
    button3.layer.cornerRadius = 35;
    [button3 setTitle:@"确认" forState:(UIControlStateNormal)];
    [button3 setImage:[UIImage imageNamed:@"LFconfirm"] forState:(UIControlStateNormal)];
    [button3 addTarget:self action:@selector(confirmClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:button3];
    button3.hidden = YES;
    button3.alpha = 0;
    
    
}

#pragma mark 动画方法

- (void)buttonAnimation{
        
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    animation1.removedOnCompletion = NO;
    //    animation1.duration = 0.2;
    //    animation1.fillMode = kCAFillModeForwards;
    //    animation.fromValue = (UIBezierPath *)layer1.path;
    animation1.toValue = [NSNumber numberWithFloat:0.7];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    // 动画选项设定
    //    animation2.duration = 1; // 动画持续时间
    //    animation2.repeatCount = HUGE_VALF; // 重复次数
    //    animation2.autoreverses = YES; // 动画结束时执行逆动画
    //    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 缩放倍数
    //    animation2.fromValue = [NSNumber numberWithFloat:1]; // 开始时的倍率
    animation2.toValue = [NSNumber numberWithFloat:12]; // 结束时的倍率
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation1,animation2];
    group.duration = 0.2;
    //    group.repeatCount = HUGE_VALF; // 重复次数
    //    group.autoreverses = YES; // 动画结束时执行逆动画
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [button.layer addAnimation:group forKey:nil];
}


- (void)buttonviewAnimate{
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    animation.removedOnCompletion = NO;
    //    animation.fillMode = kCAFillModeForwards;
    //    animation.fromValue = 1;
    // 动画选项设定
    //    animation1.duration = 1; // 动画持续时间
    //    animation1.repeatCount = HUGE_VALF; // 重复次数
    //    animation1.autoreverses = YES; // 动画结束时执行逆动画
    //    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    // 缩放倍数
    //    animation1.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation1.toValue = [NSNumber numberWithFloat:2.0]; // 结束时的倍率
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    // 动画选项设定
    //    animation2.duration = 1; // 动画持续时间
    //    animation2.repeatCount = HUGE_VALF; // 重复次数
    //    animation2.autoreverses = YES; // 动画结束时执行逆动画
    //    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    // 缩放倍数
    //    animation2.fromValue = [NSNumber numberWithFloat:1]; // 开始时的倍率
    animation2.toValue = [NSNumber numberWithFloat:0.2]; // 结束时的倍率
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation1,animation2];
    group.duration = 0.8;
    group.repeatCount = HUGE_VALF; // 重复次数
    group.autoreverses = YES; // 动画结束时执行逆动画
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [buttonview.layer addAnimation:group forKey:nil];
    
}

- (void)repeatShowTime:(NSTimer *)tempTimer {
    
    self.count++;
    timerLabel.text = [NSString stringWithFormat:@"%01d:%02d",self.count/60,self.count%60];
    
    if (self.count==15) {
        
        if ([self.delegate respondsToSelector:@selector(videoEndWithTime:)]) {
            [self.delegate videoEndWithTime:self.count];
        }
        
        [button.layer removeAllAnimations];
        [buttonview.layer removeAllAnimations];
        
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        
        cycView.hidden = YES;
        buttonview.hidden = YES;
        button.hidden = YES;
        [self buttonsMoveAnimation];
    }
}

- (void)setCount:(int)count{
    _count = count;
    int num = self.count+1;
    [self updateProgressWithNumber:num];
}

- (void)updateProgressWithNumber:(NSUInteger)number {
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:1];
    progressLayer.strokeEnd =  number / 15.0;
    [CATransaction commit];
}


- (void)buttonsMoveAnimation{
    
    button1.hidden = NO;
    button2.hidden = NO;
    button3.hidden = NO;
    
    UILabel *label1 = [UILabel new];
    UILabel *label2 = [UILabel new];
    UILabel *label3 = [UILabel new];
    label1.frame = CGRectMake(0, button1.frame.size.height-16, button1.frame.size.width, 16);
    label1.text = @"返回";
    label1.font = [UIFont systemFontOfSize:16];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.alpha = 0;
    [button1 addSubview:label1];
    
    label2.frame = CGRectMake(0, button2.frame.size.height-16, button2.frame.size.width, 16);
    label2.text = @"选择音乐";
    label2.font = [UIFont systemFontOfSize:16];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    label2.alpha = 0;
    [button2 addSubview:label2];
    
    label3.frame = CGRectMake(0, button3.frame.size.height-16, button3.frame.size.width, 16);
    label3.text = @"确认";
    label3.font = [UIFont systemFontOfSize:16];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = [UIColor whiteColor];
    label3.alpha = 0;
    [button3 addSubview:label3];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation1.removedOnCompletion = NO;
    animation1.duration = 0.3;
    animation1.fillMode = kCAFillModeForwards;
    //    animation.fromValue = (UIBezierPath *)layer1.path;
    animation1.toValue = @(M_PI*2);
    [button1.layer addAnimation:animation1 forKey:nil];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation2.removedOnCompletion = NO;
    animation2.duration = 0.3;
    animation2.fillMode = kCAFillModeForwards;
    //    animation.fromValue = (UIBezierPath *)layer1.path;
    animation2.toValue = @(-M_PI*2);
    [button3.layer addAnimation:animation2 forKey:nil];
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        button1.alpha = 1;
        button2.alpha = 1;
        button3.alpha = 1;
        
        CGFloat jiange = ([UIScreen mainScreen].bounds.size.width-70*3)/4.0;
        
        button1.frame = CGRectMake(button1.frame.origin.x-70-jiange, button1.frame.origin.y, button1.frame.size.width, button1.frame.size.height);
        button3.frame = CGRectMake(button3.frame.origin.x+70+jiange, button3.frame.origin.y, button3.frame.size.width, button3.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        label1.frame = CGRectMake(0, button1.frame.size.height+16, button1.frame.size.width, 16);
        label1.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.5 delay:0.7 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        label2.frame = CGRectMake(0, button2.frame.size.height+16, button2.frame.size.width, 16);
        label2.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.5 delay:0.9 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        label3.frame = CGRectMake(0, button3.frame.size.height+16, button3.frame.size.width, 16);
        label3.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    
}



#pragma mark 按键方法

// 录制手势
- (void)btnLong: (UILongPressGestureRecognizer *)sender {
    
    if ([sender state] == UIGestureRecognizerStateBegan){

        if ([self.delegate respondsToSelector:@selector(videoBegin)]) {
            [self.delegate videoBegin];
        }
        
        cycView.hidden = NO;
        [self buttonAnimation];
        [self buttonviewAnimate];
        
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.count = 0;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(repeatShowTime:) userInfo:@"admin" repeats:YES];
        
    }else if ([sender state] == UIGestureRecognizerStateEnded){

        if (self.count!=15) {
            
            if ([self.delegate respondsToSelector:@selector(videoEndWithTime:)]) {
                [self.delegate videoEndWithTime:self.count];
            }
            
            [button.layer removeAllAnimations];
            [buttonview.layer removeAllAnimations];
            
            if (self.timer) {
                [self.timer invalidate];
                self.timer = nil;
            }
            
            cycView.hidden = YES;
            buttonview.hidden = YES;
            button.hidden = YES;
            [self buttonsMoveAnimation];
        }
    }
}


// 返回键
- (void)returnClicked{
    
    if ([self.delegate respondsToSelector:@selector(returnButtonClicked)]) {
        [self.delegate returnButtonClicked];
    }
    
    [cycView removeFromSuperview];
    [buttonview removeFromSuperview];
    [button removeFromSuperview];
    [button1 removeFromSuperview];
    [button2 removeFromSuperview];
    [button3 removeFromSuperview];
    [timerLabel removeFromSuperview];
    
    [self createUI];
}

- (void)addMusicClicked{
    
    if ([self.delegate respondsToSelector:@selector(addMusicButtonClicked)]) {
        [self.delegate addMusicButtonClicked];
    }
    
}

- (void)confirmClicked{
    
    if ([self.delegate respondsToSelector:@selector(confirmButtonClicked)]) {
        [self.delegate confirmButtonClicked];
    }
    
}


@end
