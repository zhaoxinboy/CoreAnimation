//
//  ZXNumView.m
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/22.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import "ZXNumView.h"

@implementation ZXNumView

- (void)setlabelNum:(NSInteger)i {
    self.label.text = [NSString stringWithFormat:@"%ld", (long)i];
    switch (i) {
        case 1:
            self.label.textColor = blue_color;
            self.backgroundColor = white_color;
            break;
        case 2:
            self.label.textColor = brown_color;
            self.backgroundColor = white_color;
            break;
        case 3:
            self.label.textColor = darkGray_color;
            self.backgroundColor = white_color;
            break;
        case 4:
            self.label.textColor = yellow_color;
            self.backgroundColor = white_color;
            break;
        case 5:
            self.label.textColor = orange_color;
            self.backgroundColor = white_color;
            break;
        case 6:
            self.label.textColor = lightGray_color;
            self.backgroundColor = white_color;
            break;
            
            
        default:
            break;
    }
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:25];
        _label.frame = CGRectMake(90, 90, 20, 20);
        [self addSubview:_label];
    }
    return _label;
}




- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
