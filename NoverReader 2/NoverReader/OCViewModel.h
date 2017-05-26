//
//  OCViewModel.h
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/4.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LSHeaderRefresh_HasMoreData = 1,
    LSHeaderRefresh_HasNoMoreData,
    LSFooterRefresh_HasMoreData,
    LSFooterRefresh_HasNoMoreData,
    LSRefreshError,
    LSRefreshUI,
} LSRefreshDataStatus;

@protocol OCViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;

@property (strong, nonatomic)id request;

/**
 *  初始化
 */
- (void)oc_initialize;

@end


@interface OCViewModel : NSObject <OCViewModelProtocol>



@end
