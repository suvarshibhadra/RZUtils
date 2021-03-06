//
//  RZLoadingImageView
//
//  Created by Nicholas Donaldson on 9/24/12.

// Copyright 2014 Raizlabs and other contributors
// http://raizlabs.com/
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "RZImageCache.h"

@class RZLoadingImageView;

@protocol RZLoadingImageViewDelegate <NSObject>

@optional
- (void)loadingImageView:(RZLoadingImageView*)loadingImageView finishedLoadingURL:(NSURL*)url;
- (void)loadingImageView:(RZLoadingImageView*)loadingImageView failedToLoadURL:(NSURL*)url;

@end

@interface RZLoadingImageView : UIImageView <UIAppearance, RZImageCacheDelegate>

@property (nonatomic, weak) id<RZLoadingImageViewDelegate> delegate;

@property (nonatomic, assign) BOOL showPlaceholderOnError;
@property (nonatomic, strong) UIImage *errorPlaceholderImage UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIImageRenderingMode imageRenderingMode;
@property (nonatomic, assign) BOOL shouldAnimateImage;  // Defaults YES

- (void)setLoading:(BOOL)loading;

- (void)loadImageFromPath:(NSString*)path;
- (void)loadImageFromPath:(NSString*)path decompress:(BOOL)decompress;
- (void)loadImageFromPath:(NSString *)path resizeToSize:(CGSize)newSize preserveAspectRatio:(BOOL)preserveAspect decompress:(BOOL)decompress;
- (void)loadImageFromPath:(NSString *)path resizeToSize:(CGSize)newSize preserveAspectRatio:(BOOL)preserveAspect checkForUpdates:(BOOL)updates decompress:(BOOL)decompress;

- (void)loadImageFromURL:(NSURL*)url;
- (void)loadImageFromURL:(NSURL*)url decompress:(BOOL)decompress;
- (void)loadImageFromURL:(NSURL*)url decompress:(BOOL)decompress checkForUpdates:(BOOL)checkForUpdates;
- (void)setImage:(UIImage *)image animated:(BOOL)animated;

- (void)cancelRequest;

@end
