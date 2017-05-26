//
//  OCViewModel.m
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/4.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import "OCViewModel.h"

@implementation OCViewModel

@synthesize request  = _request;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    OCViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel oc_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)request {
    
    if (!_request) {
        
//        _request = [CMRequest request];
    }
    return _request;
}

- (void)yd_initialize {}

@end
