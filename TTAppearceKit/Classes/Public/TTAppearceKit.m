//
//  TTAppearceKit.m
//  Expecta
//
//  Created by Chao Tan on 2020/8/15.
//

#import "TTAppearceKit.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
@interface NSObject (TTAppearceKitSupport)<TTAppearceKitProtocal>
@property (copy, nonatomic)  __kindof NSObject *(^TTAppearceKitSupportAction)(NSString *);
@end
@implementation NSObject (TTAppearceKitSupport)
- (void)appearceKitDidUpdateKey:(NSString *)key{
    
}
- (void)setTTAppearceKitSupportAction:(__kindof NSObject *(^)(NSString *))TTAppearceKitSupportAction{
    __kindof NSObject *(^block)(NSString *) = ^__kindof NSObject *(NSString *key) {
        NSObject *obj = !TTAppearceKitSupportAction?nil:TTAppearceKitSupportAction(key);
        obj.TTAppearceKitSupportAction = TTAppearceKitSupportAction;
        return obj;
    };
    objc_setAssociatedObject(self, @selector(TTAppearceKitSupportAction), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (__kindof NSObject *(^)(NSString *))TTAppearceKitSupportAction{
    return objc_getAssociatedObject(self, _cmd);
}
@end
@interface TTAppearceKit()
@property (copy, nonatomic) NSString *key;
@property (strong, nonatomic) NSHashTable<UIView *> *table;
+ (instancetype)shared;
@end
@implementation TTAppearceKit

+ (instancetype)shared{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}
+ (void)setUpAppearceKey:(NSString *)key{
    [[self shared] setKey:key];
    for (UIView *view in [TTAppearceKit shared].table.allObjects) {
        if ([view respondsToSelector:@selector(appearceKitDidUpdateKey:)]) {
            [view appearceKitDidUpdateKey:key];
        }
    }
}
- (NSHashTable<UIView *> *)table{
    if (!_table) {
        _table = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:10000];
    }
    return _table;
}
@end
@implementation UIColor (TTAppearceKitSupport)
+ (UIColor *)colorInAppearce:(UIColor * _Nonnull (^)(NSString * _Nonnull appearce))colorInAppearce{
    return ({
        UIColor *color = !colorInAppearce?nil:colorInAppearce(TTAppearceKit.shared.key);
        color.TTAppearceKitSupportAction = colorInAppearce;
        color;
    });
}
@end
@implementation UIImage (TTAppearceKitSupport)
+ (UIImage *)imageInAppearce:(UIImage * _Nonnull (^)(NSString * _Nonnull))imageInAppearce{
    return ({
        UIImage *image = !imageInAppearce?nil:imageInAppearce(TTAppearceKit.shared.key);
        image.TTAppearceKitSupportAction = imageInAppearce;
        image;
    });
}

@end
@interface UIView (TTAppearceKit)

@end
@implementation UIView (TTAppearceKit)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(didMoveToSuperview);
        SEL swizzledSelector = @selector(__TT__TTAppearceKit__didMoveToSuperview);
        // 原方法结构体和替换方法结构体
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        // 如果当前类没有原方法的实现IMP，先调用class_addMethod来给原方法添加默认的方法实现IMP
        BOOL didAddMethod = class_addMethod(class,
                                                originalSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod));
    
        if (didAddMethod) {// 添加方法实现IMP成功后，修改替换方法结构体内的方法实现IMP和方法类型编码TypeEncoding
            class_replaceMethod(class,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod));
            } else { // 添加失败，调用交互两个方法的实现
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
    });
}
- (void)__TT__TTAppearceKit__didMoveToSuperview{
    [self __TT__TTAppearceKit__didMoveToSuperview];
    [[[TTAppearceKit shared] table] addObject:self];
}
@end


@interface UIView (TTAppearceKitSupport)

@end
@implementation UIView (TTAppearceKitSupport)
- (void)appearceKitDidUpdateKey:(NSString *)key{
    if (self.backgroundColor.TTAppearceKitSupportAction) {
        self.backgroundColor = self.backgroundColor.TTAppearceKitSupportAction(key);
    }
    if (self.tintColor.TTAppearceKitSupportAction) {
        self.tintColor = self.tintColor.TTAppearceKitSupportAction(key);
    }
}
@end
@interface UIButton (TTAppearceKitSupport)

@end
@implementation UIButton(TTAppearceKitSupport)
- (void)appearceKitDidUpdateKey:(NSString *)key{
    if (self.backgroundColor.TTAppearceKitSupportAction) {
        self.backgroundColor = self.backgroundColor.TTAppearceKitSupportAction(key);
    }
    if (self.tintColor.TTAppearceKitSupportAction) {
        self.tintColor = self.tintColor.TTAppearceKitSupportAction(key);
    }
    [self updateColorState:UIControlStateNormal with:key];
    [self updateColorState:UIControlStateHighlighted with:key];
    [self updateColorState:UIControlStateDisabled with:key];
    [self updateColorState:UIControlStateSelected with:key];
    if (@available(iOS 9.0, *)) {
        [self updateColorState:UIControlStateFocused with:key];
    }
    [self updateColorState:UIControlStateApplication with:key];
    
    [self updateColorState:UIControlStateReserved with:key];
    [self updateImageState:UIControlStateNormal with:key];
    [self updateImageState:UIControlStateHighlighted with:key];
    [self updateImageState:UIControlStateDisabled with:key];
    [self updateImageState:UIControlStateSelected with:key];
    if (@available(iOS 9.0, *)) {
        [self updateImageState:UIControlStateFocused with:key];
    }
    [self updateImageState:UIControlStateApplication with:key];
    
    [self updateImageState:UIControlStateReserved with:key];
    if (self.tintColor.TTAppearceKitSupportAction) {
        self.tintColor = self.tintColor.TTAppearceKitSupportAction(key);
    }
}
- (void)updateImageState:(UIControlState) state with:(NSString *)key{
    UIImage *image = [self imageForState:state];
    if (image.TTAppearceKitSupportAction) {
        [self setImage:image.TTAppearceKitSupportAction(key) forState:state];
    }
    UIImage *backImage = [self backgroundImageForState:state];
    if (backImage.TTAppearceKitSupportAction) {
        [self setImage:backImage.TTAppearceKitSupportAction(key) forState:state];
    }
}
- (void)updateColorState:(UIControlState) state with:(NSString *)key{
    UIColor *color = [self titleColorForState:state];
    if (color.TTAppearceKitSupportAction) {
        [self setTitleColor:color.TTAppearceKitSupportAction(key) forState:state];
    }
}
@end
@interface UIImageView (TTAppearceKitSupport)<TTAppearceKitProtocal>

@end
@implementation UIImageView (TTAppearceKitSupport)
- (void)appearceKitDidUpdateKey:(NSString *)key{
    if (self.backgroundColor.TTAppearceKitSupportAction) {
        self.backgroundColor = self.backgroundColor.TTAppearceKitSupportAction(key);
    }
    if (self.tintColor.TTAppearceKitSupportAction) {
        self.tintColor = self.tintColor.TTAppearceKitSupportAction(key);
    }
    if (self.image.TTAppearceKitSupportAction) {
        self.image = self.image.TTAppearceKitSupportAction(key);
    }
}
@end
@interface UILabel (TTAppearceKitSupport)

@end
@implementation UILabel (TTAppearceKitSupport)
- (void)appearceKitDidUpdateKey:(NSString *)key{
    if (self.backgroundColor.TTAppearceKitSupportAction) {
        self.backgroundColor = self.backgroundColor.TTAppearceKitSupportAction(key);
    }
    if (self.tintColor.TTAppearceKitSupportAction) {
        self.tintColor = self.tintColor.TTAppearceKitSupportAction(key);
    }
    if (self.textColor.TTAppearceKitSupportAction) {
        self.textColor = self.textColor.TTAppearceKitSupportAction(key);
    }
}
@end
@interface UITextView (TTAppearceKitSupport)

@end
@implementation UITextView (TTAppearceKitSupport)
- (void)appearceKitDidUpdateKey:(NSString *)key{
    if (self.backgroundColor.TTAppearceKitSupportAction) {
        self.backgroundColor = self.backgroundColor.TTAppearceKitSupportAction(key);
    }
    if (self.tintColor.TTAppearceKitSupportAction) {
        self.tintColor = self.tintColor.TTAppearceKitSupportAction(key);
    }
    if (self.textColor.TTAppearceKitSupportAction) {
        self.textColor = self.textColor.TTAppearceKitSupportAction(key);
    }
}
@end
@interface UITextField (TTAppearceKitSupport)

@end
@implementation UITextField (TTAppearceKitSupport)
- (void)appearceKitDidUpdateKey:(NSString *)key{
    if (self.backgroundColor.TTAppearceKitSupportAction) {
        self.backgroundColor = self.backgroundColor.TTAppearceKitSupportAction(key);
    }
    if (self.tintColor.TTAppearceKitSupportAction) {
        self.tintColor = self.tintColor.TTAppearceKitSupportAction(key);
    }
    if (self.textColor.TTAppearceKitSupportAction) {
        self.textColor = self.textColor.TTAppearceKitSupportAction(key);
    }
}
@end

@interface UISwitch (TTAppearceKitSupport)

@end
@implementation UISwitch (TTAppearceKitSupport)
- (void)appearceKitDidUpdateKey:(NSString *)key{
    if (self.backgroundColor.TTAppearceKitSupportAction) {
        self.backgroundColor = self.backgroundColor.TTAppearceKitSupportAction(key);
    }
    if (self.tintColor.TTAppearceKitSupportAction) {
        self.tintColor = self.tintColor.TTAppearceKitSupportAction(key);
    }
    if (self.onTintColor.TTAppearceKitSupportAction) {
        [self setOnTintColor:self.onTintColor.TTAppearceKitSupportAction(key)];
    }
    if (self.onImage.TTAppearceKitSupportAction) {
        [self setOnImage:self.onImage.TTAppearceKitSupportAction(key)];
    }
    if (self.offImage.TTAppearceKitSupportAction) {
        [self setOffImage:self.offImage.TTAppearceKitSupportAction(key)];
    }
}
@end

