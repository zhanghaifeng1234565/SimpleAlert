# SimpleAlert
 一个简单的确定取消弹窗
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
