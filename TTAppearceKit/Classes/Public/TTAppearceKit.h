//
//  TTAppearceKit.h
//  Expecta
//
//  Created by Chao Tan on 2020/8/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TTAppearceKitProtocal <NSObject>
@optional
- (void)appearceKitDidUpdateKey:(NSString *)key;
@end
@interface UIColor (TTAppearceKitSupport)

/// 根据当前主题生成颜色
+ (UIColor *)colorInAppearce:(UIColor * _Nonnull (^)(NSString * _Nonnull appearce))colorInAppearce;
@end
@interface UIImage (TTAppearceKitSupport)

/// 根据当前主题生成图片
+ (UIImage *)imageInAppearce:(UIImage * _Nonnull (^)(NSString * _Nonnull appearce))imageInAppearce;
@end
@interface TTAppearceKit : NSObject
+ (void)setUpAppearceKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
