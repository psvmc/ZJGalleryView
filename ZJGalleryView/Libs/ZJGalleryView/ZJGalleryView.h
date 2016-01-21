//
//  ZJGalleryView
//
//  Created by PSVMC on 16/1/10.
//
//
#import <UIKit/UIKit.h>
#import "ZJGalleryImage.h"
@protocol ZJGalleryViewDelegate;

@protocol ZJGalleryViewDataSource;

@interface ZJGalleryView : UIView <UIScrollViewDelegate>

@property (nonatomic,strong) id<ZJGalleryViewDelegate> delegate;
@property (nonatomic,strong) id<ZJGalleryViewDataSource> dataSource;

///设置占位图片
@property (strong, nonatomic) UIImage *imageHoler;

/**
 滑动页
 */
@property (strong, nonatomic) UIScrollView *imagesScrollView;

/**
 显示页数
 */
@property (strong, nonatomic) UIPageControl *imagesPageControl;

@property (strong, nonatomic) UILabel *labelPageControl;

/**
 选择的图片
 */
@property (strong, nonatomic) UIImageView *selectedImage;

@property (nonatomic) long imageCount;
@property (nonatomic) float imageWidth;
@property (nonatomic) float imageHeight;

@property (nonatomic) bool isShowPageNum;
@property (nonatomic) bool isShowPageControl;
/**
 生成
 */
-(void)generate;
@end



@protocol ZJGalleryViewDelegate <NSObject>
@required
-(void)didSelectImageInGalleryView:(ZJGalleryView *)galleryView atIndex:(long)index;
@end



@protocol ZJGalleryViewDataSource <NSObject>
@required
-(NSInteger)numberOfImagesInGalleryView:(ZJGalleryView *)galleryView;
-(ZJGalleryImage *)imageURLAtIndex:(int)index inGalleryView:(ZJGalleryView *)galleryView;
@end
