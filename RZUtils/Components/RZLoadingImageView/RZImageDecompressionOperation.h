//
//  RZImageDecompressionOperation.h
//
//  Created by Nick Donaldson on 2/27/13.

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

#import <Foundation/Foundation.h>

typedef void (^RZImageDecompressionCompletion)(UIImage* image);

@interface RZImageDecompressionOperation : NSOperation

@property (nonatomic, readonly, strong) NSURL* webUrl;
@property (nonatomic, readonly, strong) NSURL* fileUrl;
@property (nonatomic, readonly, strong) UIImage* image;

// Used to Limit the upper bounds of the image size.  
@property (nonatomic, assign) CGSize maxImageSize;

- (id)initWithFileURL:(NSURL*)fileUrl webUrl:(NSURL*)webUrl completion:(RZImageDecompressionCompletion)completion;
- (id)initWithFileURL:(NSURL *)fileUrl webUrl:(NSURL *)webUrl resizeToSize:(CGSize)anySize preserveAspectRatio:(BOOL)preserveAspect completion:(RZImageDecompressionCompletion)completion;

@end
