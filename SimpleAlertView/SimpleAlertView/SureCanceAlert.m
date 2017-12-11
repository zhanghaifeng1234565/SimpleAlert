//
//  SureCanceAlert.m
//  ShareDoctorNew
//
//  Created by iOS on 2017/12/8.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "SureCanceAlert.h"

#define Main_Screen_Width [UIScreen mainScreen].bounds.size.width
#define Main_Screen_Height [UIScreen mainScreen].bounds.size.height
#define AlerViewWidth (Main_Screen_Width-60)

const CGFloat vHeight = 40;

@interface SureCanceAlert ()

/**
 容器视图
 */
@property (nonatomic, strong) UIView *alertContainerView;

/**
 透明度视图
 */
@property (nonatomic, strong) UIControl *alphaView;

/**
 内容背景视图
 */
@property (nonatomic, strong) UIView *alertBgView;

/**
 标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 标题滚动视图
 */
@property (nonatomic, strong) UIScrollView *titleLabelScrollView;

/**
 水平分割线
 */
@property (nonatomic, strong) UILabel *hLine;

/**
 垂直分割线
 */
@property (nonatomic, strong) UILabel *vLine;

/**
 确定按钮
 */
@property (nonatomic, strong) UIButton *sureBtn;

/**
 取消按钮
 */
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation SureCanceAlert

#pragma mark -- lazyLoad
- (UIView *)alertContainerView {
    if (_alertContainerView==nil) {
        _alertContainerView = [[UIView alloc] init];
    }
    return _alertContainerView;
}

- (UIView *)alphaView {
    if (_alphaView==nil) {
        _alphaView = [[UIControl alloc] init];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.3;
        [_alphaView addTarget:self action:@selector(alertHidden) forControlEvents:UIControlEventTouchDown];
    }
    return _alphaView;
}

- (UIView *)alertBgView {
    if (_alertBgView==nil) {
        _alertBgView = [[UIView alloc] init];
        _alertBgView.backgroundColor = [UIColor whiteColor];
        _alertBgView.layer.masksToBounds = YES;
        _alertBgView.layer.cornerRadius = 5.0f;
    }
    return _alertBgView;
}

- (UILabel *)titleLabel {
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIScrollView *)titleLabelScrollView {
    if (_titleLabelScrollView==nil) {
        _titleLabelScrollView = [[UIScrollView alloc] init];
    }
    return _titleLabelScrollView;
}

- (UILabel *)hLine {
    if (_hLine==nil) {
        _hLine = [[UILabel alloc] init];
        _hLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _hLine;
}

- (UILabel *)vLine {
    if (_vLine==nil) {
        _vLine = [[UILabel alloc] init];
        _vLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _vLine;
}

- (UIButton *)sureBtn {
    if (_sureBtn==nil) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _sureBtn;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn==nil) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _cancelBtn;
}
#pragma mark -- 单例
+ (instancetype)shareAlert {
    static id _instance;
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        // 添加视图
        [self addAlertSubView];
    }
    return self;
}
#pragma mark -- 添加视图
- (void)addAlertSubView {
    [self.alertContainerView addSubview:self.alphaView];
    [self.alertContainerView addSubview:self.alertBgView];
    [self.alertBgView addSubview:self.titleLabelScrollView];
    [self.titleLabelScrollView addSubview:self.titleLabel];
    [self.alertBgView addSubview:self.vLine];
    [self.alertBgView addSubview:self.hLine];
    [self.alertBgView addSubview:self.sureBtn];
    [self.alertBgView addSubview:self.cancelBtn];
}
#pragma mark -- 布局视图
- (void)layoutAlertSubViewTitleText:(NSString *)text withMaxHeight:(CGFloat)maxHeight {
    self.titleLabel.text = text;
    CGFloat titleLabelHeight = [text boundingRectWithSize:CGSizeMake(AlerViewWidth-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height+1;
    CGFloat titleLableScrollViewHeight = titleLabelHeight>maxHeight?maxHeight:titleLabelHeight;
    CGFloat alertViewHeiht = 30+titleLableScrollViewHeight+vHeight+0.5;
    
    self.alertContainerView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    self.alphaView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    self.alertBgView.frame = CGRectMake((Main_Screen_Width-AlerViewWidth)/2, (Main_Screen_Height-alertViewHeiht)/2, AlerViewWidth, alertViewHeiht);
    self.titleLabelScrollView.frame = CGRectMake(15, 15, self.alertBgView.frame.size.width-30, titleLableScrollViewHeight);
    self.titleLabel.frame = CGRectMake(0, 0, self.titleLabelScrollView.frame.size.width, titleLabelHeight);
    self.hLine.frame = CGRectMake(0, self.alertBgView.frame.size.height-vHeight, self.alertBgView.frame.size.width, 0.5);
    self.vLine.frame = CGRectMake((self.alertBgView.frame.size.width-0.5)/2, self.alertBgView.frame.size.height-vHeight, 0.5, vHeight);
    self.cancelBtn.frame = CGRectMake(self.hLine.frame.origin.x, self.hLine.frame.size.height+self.hLine.frame.origin.y, self.vLine.frame.origin.x, vHeight);
    self.sureBtn.frame = CGRectMake(self.vLine.frame.origin.x+self.vLine.frame.size.width, self.hLine.frame.size.height+self.hLine.frame.origin.y, self.vLine.frame.origin.x, vHeight);
    
    // 设置滚动范围
    self.titleLabelScrollView.contentSize = CGSizeMake(self.alertBgView.frame.size.width-30, titleLabelHeight);
    [self alertShow];
}
#pragma mark -- 确定按钮点击
- (void)sureBtnClick:(UIButton *)sender {
    if (self.sureBtnClickBlock) {
        self.sureBtnClickBlock(sender);
    }
    [self alertHidden];
}
#pragma mark -- 取消按钮点击
- (void)cancelBtnClick:(UIButton *)sender {
    if (self.cancelBtnClickBlock) {
        self.cancelBtnClickBlock(sender);
    }
    [self alertHidden];
}
#pragma mark -- 设置标题 点击事件回调
- (void)setTitleText:(NSString *)text withMaxHeight:(CGFloat)maxHeight withSureBtnClick:(SureBtnClickBlock)sureBtnClickBlock withCancelBtnClick:(CancelBtnClickBlock)cancelBtnClickBlock {
    // 用下划线属性接收否则无效！！！！！！
    _sureBtnClickBlock = sureBtnClickBlock;
    _cancelBtnClickBlock = cancelBtnClickBlock;
    [self setTitleText:text withMaxHeight:maxHeight];
}
#pragma mark -- 设置标题回调
- (void)setTitleText:(NSString *)text withMaxHeight:(CGFloat)maxHeight {
    [self layoutAlertSubViewTitleText:text withMaxHeight:maxHeight];
}
#pragma mark -- 显示弹窗
- (void)alertShow {
    self.alphaView.alpha = 0.0;
    [UIView animateWithDuration:0.25f animations:^{
        self.alphaView.alpha = 0.3;
        [[UIApplication sharedApplication].keyWindow addSubview:self.alertContainerView];
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark -- 隐藏弹窗
- (void)alertHidden {
    [self.alertContainerView removeFromSuperview];
}
@end
