//
//  VTFunctionItem.h
//  HomeHome
//
//  Created by Victor on 16/3/28.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AudioItem = 0,
    MessageItem = 1,
    VideoItem = 2,
}funtionItem;

@interface VTFunctionItem : UIView

- (instancetype)initWithFrame:(CGRect)frame itemtype:(funtionItem)funtionItem;

@end
