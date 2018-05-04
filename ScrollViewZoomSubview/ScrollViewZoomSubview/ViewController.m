//
//  ViewController.m
//  ScrollViewZoomSubview
//
//  Created by LiDinggui on 2018/5/4.
//  Copyright © 2018年 LiDinggui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIImage *image = [UIImage imageNamed:@"spot_photograph_banner"];
    //initWithImage会设置imageView.bounds.size==image.size
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self setFrameWithViewForZooming:imageView inScrollView:self.scrollView];
    imageView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    self.scrollView.contentSize = self.imageView.bounds.size;
    
    self.scrollView.maximumZoomScale = 10.0;
    self.scrollView.minimumZoomScale = 0.1;
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)setFrameWithViewForZooming:(UIView *)view inScrollView:(UIScrollView *)scrollView
{
    CGRect frame = view.frame;
    frame.origin.y = (scrollView.frame.size.height - view.frame.size.height) > 0 ? (scrollView.frame.size.height - view.frame.size.height) * 0.5 : 0;
    frame.origin.x = (scrollView.frame.size.width - view.frame.size.width) > 0 ? (scrollView.frame.size.width - view.frame.size.width) * 0.5 : 0;
    view.frame = frame;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view
{
    
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    [self setFrameWithViewForZooming:view inScrollView:scrollView];
    
    NSLog(@"\n\nview.frame == %@\n\nscale == %lf\n\nscrollView.contentSize == %@",NSStringFromCGRect(view.frame),scale,NSStringFromCGSize(scrollView.contentSize));
}

@end
