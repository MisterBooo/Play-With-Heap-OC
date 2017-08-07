//
//  ViewController.m
//  Play-With-Heap-OC
//
//  Created by MisterBooo on 2017/8/3.
//  Copyright © 2017年 MisterBooo. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+MBClipCategory.h"
#import "UIView+MBRectCorner.h"
#import <math.h>
@interface ViewController ()
@property (nonatomic, strong) UISegmentedControl *countSegmentControl;
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property(nonatomic, strong) UIImageView *ninjaView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) UIView *heapView;
@property(nonatomic, strong) NSMutableArray *numbers;
@property(nonatomic, assign) NSInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadUI];
    
}
- (void)loadUI{

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(onReset)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"动画" style:UIBarButtonItemStylePlain target:self action:@selector(onSort)];

    CGFloat margin = 8;
    self.countSegmentControl.frame = CGRectMake(margin,margin + 64, CGRectGetWidth(self.view.bounds) - 2 * margin, 30);
    self.segmentControl.frame = CGRectMake(margin, CGRectGetMaxY(self.countSegmentControl.frame) + margin, CGRectGetWidth(self.view.bounds) - 2 * margin, 30);
    
    self.heapView.frame = CGRectMake(0, CGRectGetMaxY(self.segmentControl.frame) + margin, self.view.frame.size.width, self.view.frame.size.height - 2 * margin - self.segmentControl.frame.size.height );
    
    [self setupHeapCount:10];
    
}



#pragma mark - Action
- (void)countSegmentControlChanged:(UISegmentedControl *)segmentControl{
    NSArray *counts = @[@"3", @"7",@"10"];
    [self setupHeapCount:[counts[segmentControl.selectedSegmentIndex] integerValue] ];
}
- (void)segmentControlChanged:(UISegmentedControl *)segmentControl{
    
}

- (void)onReset{
    [self setupHeapCount:self.count];
}
- (void)onSort{
    
}
#pragma mark - loadData
- (void)setupHeapCount:(NSInteger )count{
    for (UIButton *button in self.heapView.subviews) {
        [button removeFromSuperview];
    }
    [self.dataSource removeAllObjects];
    self.count = count;
    //最多有多少层
    int maxSection = (int)log2(count) + 1;
    //一层最多显示多少个
    int maxNumber =  pow(2, maxSection);
    CGFloat buttonW = self.view.frame.size.width / maxNumber;
    CGFloat buttonH = buttonW;
    CGFloat paddingY = 30 ;
    CGFloat centerY = 30 ;
    NSLog(@"最多有%d层\n一层最多显示%d个\n大小是%lf",maxSection ,maxNumber,buttonW);
    //获取数据
    [self packageDataList];
    for (NSInteger i = 1; i <= count; i++) {
        // 9 = 2^3 + 1 第三层第一个
        //  在log(i) + 1层
        int section = (int)log2(i) + 1;
        //每一层分段的宽度
        CGFloat width =  self.view.frame.size.width / (pow(2, section) * 1.0);
        //在每一层的第几个
        //第row个
        int row =  (i - pow(2, section - 1 ) + 1) * 2 - 1;
        UIButton *heap = [UIButton buttonWithType:UIButtonTypeCustom];
        heap.frame = CGRectMake(0, 0, buttonW, buttonH);
        heap.center = CGPointMake(width * row, centerY + (paddingY * 2 + buttonH) * section );
        heap.axcUI_rectCornerRadii = buttonW / 2.0;
        heap.axcUI_rectCorner = UIRectCornerAllCorners;
        [heap setTitle:self.numbers[i-1] forState:UIControlStateNormal];
        [heap setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        heap.titleLabel.adjustsFontSizeToFitWidth = YES;
        heap.backgroundColor = [self normalColor];
        heap.enabled = false;
        [self.heapView addSubview:heap];
        [self.dataSource addObject:heap];
    }
}


/**
 模拟数据
 */
- (void)packageDataList{
    self.numbers = [self generateRandomArrayNumber:self.count rangeL:0 rangeR:100];
}

/**
 生成有n个元素的随机数组,每个元素的随机范围为[rangeL, rangeR]
 
 @param number 元素个数
 @param rangeL 左区间
 @param rangeR 右区间
 @return 数组
 */
- (NSMutableArray *)generateRandomArrayNumber:(NSInteger )number rangeL:(int )rangeL rangeR:(int)rangeR{
    NSAssert(rangeL <= rangeR, @"右区间必须不小于左区间");
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSInteger i = 0; i < number; i++) {
        [arrayM addObject:[NSString stringWithFormat:@"%@",@(arc4random_uniform(rangeR - rangeL) + rangeL)]];
    }
    return arrayM;
}


#pragma mark - Getter && Setter

- (UIColor *)normalColor{
   return  [UIColor colorWithRed:46.0f/255.0f
                    green:204.0f/255.0f
                     blue:113.0f/255.0f
                    alpha:1.0f];
}

- (UISegmentedControl *)countSegmentControl {
    if (!_countSegmentControl) {
        _countSegmentControl = [[UISegmentedControl alloc] initWithItems:@[@"3", @"7",@"10"]];
        _countSegmentControl.selectedSegmentIndex = 2;
        [_countSegmentControl addTarget:self action:@selector(countSegmentControlChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_countSegmentControl];
    }
    return _countSegmentControl;
}
- (UISegmentedControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"Shift up", @"Shift down",@"Heapify", @"原地堆",@"索引堆"]];
        _segmentControl.selectedSegmentIndex = 0;
        [_segmentControl addTarget:self action:@selector(segmentControlChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_segmentControl];
    }
    return _segmentControl;
}
- (UIImageView *)ninjaView{
    if (!_ninjaView) {
        _ninjaView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"Ninja"] mb_clips]];
        [self.view addSubview:_ninjaView];
        
    }
    return _ninjaView;
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (NSMutableArray *)numbers{
    if (!_numbers) {
        _numbers = [[NSMutableArray alloc] init];
    }
    return _numbers;
}
- (UIView *)heapView{
    if (!_heapView) {
        _heapView = [[UIView alloc] init];
        [self.view addSubview:_heapView];
    }
    return _heapView;
}
@end
