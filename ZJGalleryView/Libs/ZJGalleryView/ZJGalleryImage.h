//
//  ZJGalleryImage.h
//  ZJGalleryView
//
//  Created by 张剑 on 16/1/21.
//  Copyright © 2016年 张剑. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface ZJGalleryImage : NSObject 
{
    bool isLocal;
    NSString *url;
}
-(id)initWithLocal:(bool)isLocal url:(NSString *)url;
-(bool)isLocal;
-(NSString *)url;

@end
