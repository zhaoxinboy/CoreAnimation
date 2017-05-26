//
//  DES.h
//  WeiWenJingXuan
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 GhostSong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"
#include <CommonCrypto/CommonCryptor.h>

@interface DES : NSObject

//解密
+ (NSString*)desDecrypt:(NSString*)cipherText key:(NSString*)key;

//加密
+ (NSString *)desEncrypt:(NSString *)clearText key:(NSString *)key;
@end
