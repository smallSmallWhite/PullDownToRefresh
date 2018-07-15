//
//  PSRefreshGifHeader.m
//  RefreshControler
//
//  Created by mac on 2018/7/15.
//  Copyright © 2018 mac. All rights reserved.
//

#import "PSRefreshGifHeader.h"
NSString *const PSRefreshControlResourceName = @"PSRefreshControl";

@implementation PSRefreshGifHeader

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self _initialize];
    }
    return self;
}

-(void)_initialize {
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:PSRefreshControlResourceName ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSMutableArray *images = [NSMutableArray array];
//    for (int i = 0; i < 50; i++) {
//        
////        NSString *path = [bundle pathForResource:[NSString stringWithFormat:@"%@_%d@2x", BKRefreshControlResourceName, i] ofType:@"png"];
//        NSString *path = [NSString stringWithFormat:@"BKRefreshControl_%d@2x.png",i];
////        UIImage *image = [UIImage imageWithContentsOfFile:path];
//        UIImage *image = [UIImage imageNamed:path];
//        if (image != nil) {
//            
//            [images addObject:image];
//        }
//    }
    for (int i = 0; i <= 11; i++)
    {
        NSString *imageStr = @"";
        if (i < 10) {
            
            imageStr = [NSString stringWithFormat:@"refresh0%d",i];
        }else{
            
            imageStr = [NSString stringWithFormat:@"refresh%d",i];
        }
        UIImage *image = [UIImage imageNamed:imageStr];
        [images addObject:image];
    }
    
    [self setImages:@[images[0]] forState:MJRefreshStateIdle];
    [self setImages:@[images[0]] forState:MJRefreshStatePulling];
    [self setImages:@[images[0]] forState:MJRefreshStateWillRefresh];
    [self setImages:images duration:1 forState:MJRefreshStateRefreshing];
    [self setImages:@[images[0]] forState:MJRefreshStateNoMoreData];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) return;
    
    self.gifView.frame = self.bounds;
    
    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
        //16 8 15 修改；
        self.gifView.contentMode = UIViewContentModeScaleAspectFit;
    } else {
        self.gifView.contentMode = UIViewContentModeRight;
        self.gifView.mj_w = self.mj_w * 0.5 - 90;
    }
}

- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state
{
    if (images == nil) return;
    
    NSMutableDictionary *stateImages = [super valueForKey:@"stateImages"];
    NSMutableDictionary *stateDurations = [super valueForKey:@"stateDurations"];
    stateImages[@(state)] = images;
    stateDurations[@(state)] = @(duration);
    
    
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.mj_h) {
        //        self.mj_h = image.size.height;
    }
}

-(void)endRefreshing {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [super endRefreshing];
    });
}


@end
