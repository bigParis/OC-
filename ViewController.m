//
//  ViewController.m
//  OC多继承
//
//  Created by yy on 16/8/4.
//  Copyright © 2016年 BP. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    Person *person = [[Person alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([person respondsToSelector:@selector(sleep)]) {
        [person performSelector:@selector(sleep)];
    }
    if ([person respondsToSelector:@selector(fuck)]) {
        [person performSelector:@selector(fuck)];
    }
#pragma clang diagnostic pop
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
