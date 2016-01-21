//
//  ZJGalleryView
//
//  Created by PSVMC on 16/1/10.
//
//
#import "ZJGalleryView.h"
#import "UIImageView+WebCache.h"

@implementation ZJGalleryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageWidth = frame.size.width;
        self.imageHeight = frame.size.height;
        CGRect scrollFrame =CGRectMake(0, 0, frame.size.width,frame.size.height);
        self.imagesScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.imagesScrollView.frame = scrollFrame;
        [self.imagesScrollView setBounces:NO];
        [self.imagesScrollView setShowsHorizontalScrollIndicator:NO];
        [self.imagesScrollView setPagingEnabled:YES];
        self.imagesScrollView.delegate = self;
        [self addSubview:self.imagesScrollView];
        self.imagesPageControl = [[UIPageControl alloc] initWithFrame:self.frame];
        CGRect pageRect = CGRectMake(0, self.imagesScrollView.frame.origin.y + self.imagesScrollView.frame.size.height - 36, self.frame.size.width - 10 , 36);
        self.imagesPageControl.frame = pageRect;
        [self addSubview:self.imagesPageControl];
        self.imagesPageControl.hidden = YES;
        self.labelPageControl = [[UILabel alloc] initWithFrame:pageRect];
        self.labelPageControl.textAlignment = NSTextAlignmentRight;
        self.labelPageControl.font = [UIFont systemFontOfSize:14];
        self.labelPageControl.textColor = [UIColor grayColor];
        [self addSubview:self.labelPageControl];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.imagesScrollView.frame = CGRectMake(0, 0, frame.size.width, self.frame.size.height - 36);
    self.imagesPageControl.frame = CGRectMake(0,  self.imagesScrollView.frame.origin.y + self.imagesScrollView.frame.size.height, frame.size.width, 36);
}


-(void)generate{
    if(self.isShowPageControl){
        self.imagesPageControl.hidden = NO;
    }else{
        self.imagesPageControl.hidden = YES;
    }
    if(self.isShowPageNum){
        self.labelPageControl.hidden = NO;
    }else{
        self.labelPageControl.hidden = YES;
    }
    self.imagesPageControl.numberOfPages = [self.dataSource numberOfImagesInGalleryView:self];
    long count = [self.dataSource numberOfImagesInGalleryView:self];
    self.imageCount = count;
    NSString *labelText = @"";
    labelText = [labelText stringByAppendingString:[NSString stringWithFormat:@"%i",1]];
    labelText = [labelText stringByAppendingString:@" / "];
    labelText = [labelText stringByAppendingString:[NSString stringWithFormat:@"%ld",self.imageCount]];
    self.labelPageControl.text = labelText;
    for(id tmpView in [self.imagesScrollView subviews]){
        [(UIView *)tmpView removeFromSuperview];
    }
    for (int i = 0; i < count; i++){
        
        ZJGalleryImage *galleryImage = [self.dataSource imageURLAtIndex:i inGalleryView:self];
        UIView *imageView = [self generateViewInGalleryWithImage:galleryImage andIndex:i];
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
        [imageView addGestureRecognizer:tap];
        [self.imagesScrollView addSubview:imageView];
        
    }
    self.imagesScrollView.contentSize = CGSizeMake(self.imageWidth * count, self.imageHeight);
}

-(UIView *)generateViewInGalleryWithImage:(ZJGalleryImage *)galleryImage andIndex:(int)index{
    UIView *itemView = [[UIView alloc] init];
    itemView.frame = CGRectMake(index*self.imageWidth, self.imagesScrollView.frame.origin.y, self.imageWidth, self.imageHeight);
    itemView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.95];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imageWidth, self.imageHeight)];
    imageView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.95];
    imageView.bounds = CGRectMake(0, 0, self.imageWidth, self.imageHeight);
    if(self.imageHoler == nil){
        if(galleryImage.isLocal){
            imageView.image = [UIImage imageNamed:galleryImage.url];
        }else{
            [imageView sd_setImageWithURL:[[NSURL alloc] initWithString:galleryImage.url]];
        }
    }else{
        if(galleryImage.isLocal){
            imageView.image = [UIImage imageNamed:galleryImage.url];
        }else{
            [imageView sd_setImageWithURL:[[NSURL alloc] initWithString:galleryImage.url] placeholderImage:self.imageHoler];
        }
        
    }
    itemView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [itemView addSubview:imageView];
    return itemView;
}

- (void)imageViewTapped:(UITapGestureRecognizer *)gr {
    UIView *parentView = gr.view;
    UIImageView *imgView = (UIImageView *)(parentView.subviews)[0];
    self.selectedImage = imgView;
    long index = parentView.tag;
    [self.delegate didSelectImageInGalleryView:self atIndex:index];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.imagesScrollView){
        CGFloat pageWidth = self.imagesScrollView.frame.size.width;
        int page = floor((self.imagesScrollView.contentOffset.x + pageWidth / 2) / pageWidth);
        self.imagesPageControl.currentPage = page;
        NSString *labelText = @"";
        labelText = [labelText stringByAppendingString:[NSString stringWithFormat:@"%i",page+1]];
        labelText = [labelText stringByAppendingString:@" / "];
        labelText = [labelText stringByAppendingString:[NSString stringWithFormat:@"%ld",self.imageCount]];
        self.labelPageControl.text = labelText;
    }
    
}

@end
