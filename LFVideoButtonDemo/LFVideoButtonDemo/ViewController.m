//
//  ViewController.m
//  LFVideoButtonDemo
//
//  Created by souge 3 on 2019/4/4.
//  Copyright © 2019 LiuFei. All rights reserved.
//

#import "ViewController.h"
#import "LFvideoButtonView.h"

@interface ViewController ()<LFvideoButtonDelegate>

@property (nonatomic, strong)LFvideoButtonView *videoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.videoView = [[LFvideoButtonView alloc] initWithOriginY:100];
    self.videoView.center = self.view.center;
    self.videoView.delegate = self;
    [self.view addSubview:self.videoView];
}

- (void)videoBegin{
    NSLog(@"开始");
}
- (void)videoEndWithTime:(NSInteger)time{
    NSLog(@"结束，时长%ld",(long)time);
}

@end
