//
//  LFvideoButtonView.h
//  刘飞
//
//  Created by souge 3 on 2018/8/28.
//  Copyright © 2018年 souge 3. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LFvideoButtonDelegate <NSObject>

@optional

//录制开始
-(void)videoBegin;

//录制结束
- (void)videoEndWithTime:(NSInteger)time;

//返回
- (void)returnButtonClicked;

//配乐
- (void)addMusicButtonClicked;

//确认
- (void)confirmButtonClicked;


@end

@interface LFvideoButtonView : UIView

@property (nonatomic ,weak)id <LFvideoButtonDelegate>delegate;


@end
