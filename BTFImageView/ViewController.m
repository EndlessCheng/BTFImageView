//
//  ViewController.m
//  BTFImageView
//
//  Created by chengyh on 15/8/27.
//  Copyright (c) 2015年 jianyan. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize circleImageView;
@synthesize rectImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *circleImage = [self getCircleOfImage:[UIImage imageNamed:@"1.png"]];
    circleImageView.contentMode = UIViewContentModeScaleAspectFit;
    circleImageView.image = circleImage;
    
    CGRect aRect = CGRectMake(10, 10, 200, 200);
    rectImageView.image = [self getRectPartOfImage:[UIImage imageNamed:@"1.png"] withRect:aRect];
}

- (UIImage *)getCircleOfImage:(UIImage *)image {
    CGSize imageSize = image.size;
    CGRect centerRect;
    if (imageSize.width >= imageSize.height) {
        centerRect = CGRectMake((imageSize.width - imageSize.height) / 2, 0.0f, imageSize.height, imageSize.height);
    } else {
        centerRect = CGRectMake(0.0f, (imageSize.height - imageSize.width) / 2, imageSize.width, imageSize.width);
    }
    image = [self getRectPartOfImage:image withRect:centerRect];
    centerRect = (CGRect){CGPointZero, image.size};
    
    UIGraphicsBeginImageContext(imageSize);
    [[UIBezierPath bezierPathWithRoundedRect:centerRect cornerRadius:centerRect.size.height / 2] addClip];
    [image drawInRect:centerRect];
    UIImage *cirlceImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cirlceImage;
}

- (UIImage *)getRectPartOfImage:(UIImage *)image withRect:(CGRect)rect{
    CGImageRef rectImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *rectImage = [UIImage imageWithCGImage:rectImageRef];
    return rectImage;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
