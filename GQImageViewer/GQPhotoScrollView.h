//
//  PhotoScrollView.h
//  Sunshine_mall
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 GQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GQDownloaderCompletedBlock) (NSInteger index , UIImage *image , NSURL *imageUrl);

@interface GQPhotoScrollView : UIScrollView<UIScrollViewDelegate>{
    UIImageView *_imageView;
}

@property (nonatomic, retain) id data;

@property(nonatomic,assign) NSInteger row;

@property (nonatomic, copy) UIImage *placeholderImage;

@property (nonatomic, copy) GQDownloaderCompletedBlock block;

@end
