//
//  UIView+MBRectCorner.h
//  Play-With-Heap-OC
//
//  Created by MisterBooo on 2017/8/7.
//  Copyright © 2017年 MisterBooo. All rights reserved.
//

#import <UIKit/UIKit.h>

//来源： https://github.com/axclogo/AxcUIKit-Sample

@interface UIView (MBRectCorner)
/**
 *  圆角半径 默认 5
 */
@property(nonatomic,assign)CGFloat axcUI_rectCornerRadii;

/**
 *  圆角方位
 */
@property(nonatomic,assign)UIRectCorner axcUI_rectCorner;

@end
