//
//  UIImage+MBClipCategory.m
//  MBEmitterButton
//
//  Created by MisterBooo on 2017/8/4.
//  Copyright © 2017年 MisterBooo. All rights reserved.
//

#import "UIImage+MBClipCategory.h"

@implementation UIImage (MBClipCategory)
- (instancetype )mb_clips{
    /* UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale);
    size  同UIGraphicsBeginImageContext
    opaque 透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
    scale 缩放因子  设为0后，系统就会自动设置正确的比例了。
    */
    CGSize size = self.size;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    //添加一个椭圆
    UIBezierPath *path =  [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    [self drawInRect:rect];
    UIImage *clipImage =  UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return clipImage;
}

@end
