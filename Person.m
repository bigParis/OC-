//
//  Person.m
//  MyTestDemos
//
//  Created by yy on 16/8/4.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "Person.h"
#import "Chinese.h"
#import "Japanese.h"
#import <objc/runtime.h>

@interface Person ()

@property (nonatomic, strong) Chinese *chinesePeople;
@property (nonatomic, strong) Japanese *japanesePeople;

@end

@implementation Person

- (instancetype)init {
    if (self = [super init]) {
        [self setupMethods];
        [self setupProperties];
    }
    return self;
}

- (void)setupMethods {
    unsigned int numPropertys = 0;
    objc_property_t *vars = class_copyPropertyList([self class], &numPropertys);
    for (int i = 0; i < numPropertys; ++i) {
        objc_property_t thisProperty = vars[i];
        NSString *attrs = [NSString stringWithUTF8String:property_getAttributes(thisProperty)];
        NSUInteger dotLoc = [attrs rangeOfString:@","].location;
        NSString *code = nil;
        NSUInteger loc = 1;
        if (dotLoc == NSNotFound) {
            code = [attrs substringFromIndex:loc];
        } else {
            code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
        }
        
        if (code.length > 3 && [code hasPrefix:@"@\""]) {
            code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        }
        Class cls = NSClassFromString(code);
        unsigned int numMethods = 0;
        Method *methods = class_copyMethodList(cls, &numMethods);
        for (int j = 0; j < numMethods; ++j) {
            Method thisMethod = methods[j];
            SEL sel = method_getName(thisMethod);
            if (sel && ![self respondsToSelector:sel]) {
                class_addMethod([self class], sel, method_getImplementation(thisMethod), method_getTypeEncoding(thisMethod));
            }
        }
        free(methods);
    }
    free(vars);
}

- (void)setupProperties {
}

- (void)sleep {
    NSLog(@"Person sleep");
}
@end
