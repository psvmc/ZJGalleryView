//
//  ZJGalleryImage.m
//  ZJGalleryView
//
//  Created by 张剑 on 16/1/21.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJGalleryImage.h"
@implementation ZJGalleryImage
-(id)initWithLocal:(bool)local url:(NSString *)u{
    isLocal = local;
    url = u;
    return self;
}

-(bool)isLocal{
    return isLocal;
}

-(NSString *)url{
    return url;
}
@end