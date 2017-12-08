//
//  SureCanceAlert.h
//  ShareDoctorNew
//
//  Created by iOS on 2017/12/8.
//  Copyright © 2017年 iOS. All rights reserved.
//
/*
 使用方式 1 推荐使用 注意防止循环引用
 [[SureCanceAlert shareAlert] setTitleText:@"确定删除此消息？" withMaxHeight:100 withSureBtnClick:^(UIButton *sender) {
 NSLog(@"确定啦");
 } withCancelBtnClick:^(UIButton *sender) {
 NSLog(@"取消啦");
 }];
 使用方式 2
 [[SureCanceAlert shareAlert] setTitleText:@"确定删除此消息？" withMaxHeight:100];
 [[SureCanceAlert shareAlert] alertShow];
 [[SureCanceAlert shareAlert] setSureBtnClickBlock:^(UIButton *sender) {
 NSLog(@"确定啦");
 }];
 [[SureCanceAlert shareAlert] setCancelBtnClickBlock:^(UIButton *sender) {
 NSLog(@"取消啦");
 }];
 */

#import <UIKit/UIKit.h>

typedef void(^SureBtnClickBlock)(UIButton *sender);
typedef void(^CancelBtnClickBlock)(UIButton *sender);

@interface SureCanceAlert : UIView

/**
 确定按钮点击回调
 */
@property (nonatomic, copy) SureBtnClickBlock sureBtnClickBlock;

/**
 取消按钮点击回调
 */
@property (nonatomic, copy) CancelBtnClickBlock cancelBtnClickBlock;

/**
  单例

 @return  self
 */
+ (instancetype)shareAlert;

/**
 设置标题和回到方法 推荐使用

 @param text 要显示的标题
 @param maxHeight 最大显示的高度
 @param sureBtnClickBlock 确定按钮点击回调
 @param cancelBtnClickBlock 取消按钮点击回到
 */
- (void)setTitleText:(NSString *)text withMaxHeight:(CGFloat)maxHeight withSureBtnClick:(SureBtnClickBlock)sureBtnClickBlock withCancelBtnClick:(CancelBtnClickBlock)cancelBtnClickBlock;

/**
 设置标题无回调

 @param text  要显示的标题
 @param maxHeight 最大显示的高度
 */
- (void)setTitleText:(NSString *)text withMaxHeight:(CGFloat)maxHeight;

/**
 显示
 */
- (void)alertShow;

/**
 隐藏
 */
- (void)alertHidden;

@end
