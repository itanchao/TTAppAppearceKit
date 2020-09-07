//
//  TTViewController.m
//  TTAppearceKit
//
//  Created by itanchao on 08/15/2020.
//  Copyright (c) 2020 itanchao. All rights reserved.
//

#import "TTViewController.h"
@import TTAppearceKit;
@interface TTViewController ()

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            [TTAppearceKit setUpAppearceKey:@"Dark"];
        }else{
            [TTAppearceKit setUpAppearceKey:@"Light"];
        }
    }
//    self.view.backgroundColor = ;
    [self.view addSubview:({
        UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [view setImage:[UIImage imageInAppearce:^UIImage * _Nonnull(NSString * _Nonnull appearce) {
            return [appearce isEqualToString:@"Light"]?[UIImage imageNamed:@"3d_touch_mobikeMall"]:[UIImage imageNamed:@"3d_touch_reportIllegalStop"];
        }] forState:UIControlStateNormal];
        view.backgroundColor = [UIColor colorInAppearce:^UIColor * _Nonnull(NSString * _Nonnull appearce) {
            if ([appearce isEqualToString:@"Light"]) {
                return [UIColor greenColor];
            }
            return UIColor.yellowColor;
        }];
        view;
    })];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            [TTAppearceKit setUpAppearceKey:@"Dark"];
        }else{
            [TTAppearceKit setUpAppearceKey:@"Light"];
        }
    } else {
        // Fallback on earlier versions
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
