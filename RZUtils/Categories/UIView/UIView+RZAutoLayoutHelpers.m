//
//  UIView+RZAutoLayoutHelpers.m
//
//  Created by Nick Donaldson on 10/22/13.

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

#import "UIView+RZAutoLayoutHelpers.h"

@implementation UIView (RZAutoLayoutHelpers)

- (BOOL)rz_constraintIsWithSuperview:(NSLayoutConstraint *)constraint
{
    return ((constraint.firstItem == self && constraint.secondItem == self.superview) ||
            (constraint.firstItem == self.superview && constraint.secondItem == self));
}

- (BOOL)rz_constraintIsWithSiblingView:(NSLayoutConstraint *)constraint
{
    return [constraint.firstItem isKindOfClass:[UIView class]]
            && [constraint.secondItem isKindOfClass:[UIView class]]
            && [((UIView *)constraint.firstItem).superview isEqual:((UIView *)constraint.secondItem).superview];
}

- (NSLayoutConstraint *)rz_pinnedWidthConstraint
{
    __block NSLayoutConstraint *constraint = nil;
    [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *c, NSUInteger idx, BOOL *stop) {
        if (c.firstItem == self &&
            c.firstAttribute == NSLayoutAttributeWidth &&
            c.secondAttribute == NSLayoutAttributeNotAnAttribute &&
            c.relation == NSLayoutRelationEqual)
        {
            constraint = c;
            *stop = YES;
        }
    }];
    return constraint;
}

- (NSLayoutConstraint *)rz_pinnedHeightConstraint
{
    __block NSLayoutConstraint *constraint = nil;
    [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *c, NSUInteger idx, BOOL *stop) {
        if (c.firstItem == self &&
            c.firstAttribute == NSLayoutAttributeHeight &&
            c.secondAttribute == NSLayoutAttributeNotAnAttribute &&
            c.relation == NSLayoutRelationEqual)
        {
            constraint = c;
            *stop = YES;
        }
    }];
    return constraint;
}

- (NSLayoutConstraint*)rz_pinnedTopConstraint
{
    if (self.superview == nil) return nil;
    
    __block NSLayoutConstraint *constraint = nil;
    [[[self superview] constraints] enumerateObjectsUsingBlock:^(NSLayoutConstraint *c, NSUInteger idx, BOOL *stop) {
        if ([self rz_constraintIsWithSuperview:c] &&
            c.firstAttribute == NSLayoutAttributeTop &&
            c.secondAttribute == NSLayoutAttributeTop &&
            c.relation == NSLayoutRelationEqual)
        {
            constraint = c;
            *stop = YES;
        }
    }];
    return constraint;
}

- (NSLayoutConstraint*)rz_pinnedLeftConstraint
{
    if (self.superview == nil) return nil;
    
    __block NSLayoutConstraint *constraint = nil;
    [[[self superview] constraints] enumerateObjectsUsingBlock:^(NSLayoutConstraint *c, NSUInteger idx, BOOL *stop) {
        if ([self rz_constraintIsWithSuperview:c] &&
            (c.firstAttribute == NSLayoutAttributeLeft || c.firstAttribute == NSLayoutAttributeLeading) &&
            (c.secondAttribute == NSLayoutAttributeLeft || c.secondAttribute == NSLayoutAttributeLeading) &&
            c.relation == NSLayoutRelationEqual)
        {
            constraint = c;
            *stop = YES;
        }
    }];
    return constraint;
}

- (NSLayoutConstraint*)rz_pinnedRightConstraint
{
    if (self.superview == nil) return nil;
    
    __block NSLayoutConstraint *constraint = nil;
    [[[self superview] constraints] enumerateObjectsUsingBlock:^(NSLayoutConstraint *c, NSUInteger idx, BOOL *stop) {
        if ([self rz_constraintIsWithSuperview:c] &&
            (c.firstAttribute == NSLayoutAttributeRight  || c.firstAttribute == NSLayoutAttributeTrailing) &&
            (c.secondAttribute == NSLayoutAttributeRight || c.secondAttribute == NSLayoutAttributeTrailing) &&
            c.relation == NSLayoutRelationEqual)
        {
            constraint = c;
            *stop = YES;
        }
    }];
    return constraint;
}

- (NSLayoutConstraint*)rz_pinnedBottomConstraint
{
    if (self.superview == nil) return nil;
    
    __block NSLayoutConstraint *constraint = nil;
    [[[self superview] constraints] enumerateObjectsUsingBlock:^(NSLayoutConstraint *c, NSUInteger idx, BOOL *stop) {
        if ([self rz_constraintIsWithSuperview:c] &&
            c.firstAttribute == NSLayoutAttributeBottom &&
            c.secondAttribute == NSLayoutAttributeBottom &&
            c.relation == NSLayoutRelationEqual)
        {
            constraint = c;
            *stop = YES;
        }
    }];
    return constraint;
}

- (NSLayoutConstraint*)rz_pinnedCenterXConstraint
{
    if (self.superview == nil) return nil;
    
    __block NSLayoutConstraint *constraint = nil;
    [[[self superview] constraints] enumerateObjectsUsingBlock:^(NSLayoutConstraint *c, NSUInteger idx, BOOL *stop) {
        if ((c.firstItem == self && c.firstAttribute == NSLayoutAttributeCenterX) ||
            (c.secondItem == self && c.secondAttribute == NSLayoutAttributeCenterX))
        {
            constraint = c;
            *stop = YES;
        }
    }];
    return constraint;
}

- (NSLayoutConstraint*)rz_pinnedCenterYConstraint
{
    if (self.superview == nil) return nil;
    
    __block NSLayoutConstraint *constraint = nil;
    [[[self superview] constraints] enumerateObjectsUsingBlock:^(NSLayoutConstraint *c, NSUInteger idx, BOOL *stop) {
        if ((c.firstItem == self && c.firstAttribute == NSLayoutAttributeCenterY) ||
            (c.secondItem == self && c.secondAttribute == NSLayoutAttributeCenterY))
        {
            constraint = c;
            *stop = YES;
        }
    }];
    return constraint;
}

- (NSLayoutConstraint *)rz_pinnedLeadingConstraint
{
    if (self.superview == nil) return nil;
    
    __block NSLayoutConstraint *constraint = nil;
    [[[self superview] constraints] enumerateObjectsUsingBlock:^(NSLayoutConstraint *c, NSUInteger idx, BOOL *stop) {
        BOOL constraintIsWithSiblingView = [self rz_constraintIsWithSiblingView:c];
        BOOL constraintIsDesiredType = (c.firstItem == self && c.firstAttribute == NSLayoutAttributeLeading) || (c.secondItem == self && c.secondAttribute == NSLayoutAttributeLeading);
        if (constraintIsWithSiblingView && constraintIsDesiredType)
        {
            constraint = c;
            *stop = YES;
        }
    }];
    return constraint;
}

- (NSLayoutConstraint *)rz_pinnedTrailingConstraint
{
    if (self.superview == nil) return nil;
    
    __block NSLayoutConstraint *constraint = nil;
    [[[self superview] constraints] enumerateObjectsUsingBlock:^(NSLayoutConstraint *c, NSUInteger idx, BOOL *stop) {
        BOOL constraintIsWithSiblingView = [self rz_constraintIsWithSiblingView:c];
        BOOL constraintIsDesiredType = (c.firstItem == self && c.firstAttribute == NSLayoutAttributeTrailing) || (c.secondItem == self && c.secondAttribute == NSLayoutAttributeTrailing);
        if (constraintIsWithSiblingView && constraintIsDesiredType)
        {
            constraint = c;
            *stop = YES;
        }
    }];
    return constraint;
}

- (void)rz_pinWidthTo:(CGFloat)width
{
    NSLayoutConstraint *w = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.f
                                                          constant:width];
    [self addConstraint:w];
}

- (void)rz_pinHeightTo:(CGFloat)height
{
    NSLayoutConstraint *h = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.f
                                                          constant:height];
    [self addConstraint:h];
}

- (void)rz_pinSizeTo:(CGSize)size
{
    [self rz_pinWidthTo:size.width];
    [self rz_pinHeightTo:size.height];
}

- (void)rz_fillContainerHorizontallyWithPadding:(CGFloat)padding
{
    NSAssert(self.superview != nil, @"Must have superview");

    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:padding]];

    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.0
                                                                constant:padding]];
}

- (void)rz_fillContainerHorizontallyWithMinimumPadding:(CGFloat)padding
{
    NSAssert(self.superview != nil, @"Must have superview");
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:padding]];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationLessThanOrEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.0
                                                                constant:padding]];
}

- (void)rz_fillContainerVerticallyWithPadding:(CGFloat)padding
{
    NSAssert(self.superview != nil, @"Must have superview");

    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1.0
                                                                constant:padding]];

    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:padding]];
}

- (void)rz_fillContainerVerticallyWithMinimumPadding:(CGFloat)padding
{
    NSAssert(self.superview != nil, @"Must have superview");
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1.0
                                                                constant:padding]];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationLessThanOrEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:padding]];
}

- (void)rz_pinTopSpaceToSuperviewWithPadding:(CGFloat)padding
{
    NSAssert(self.superview != nil, @"Must have superview");

    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.superview
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.f
                                                          constant:padding];
    [self.superview addConstraint:c];
}


- (void)rz_pinLeftSpaceToSuperviewWithPadding:(CGFloat)padding
{
    NSAssert(self.superview != nil, @"Must have superview");

    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.superview
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.f
                                                          constant:padding];
    [self.superview addConstraint:c];
}

- (void)rz_pinBottomSpaceToSuperviewWithPadding:(CGFloat)padding
{
    NSAssert(self.superview != nil, @"Must have superview");

    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.superview
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.f
                                                          constant:-padding];
    [self.superview addConstraint:c];
}

- (void)rz_pinRightSpaceToSuperviewWithPadding:(CGFloat)padding
{
    NSAssert(self.superview != nil, @"Must have superview");

    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.superview
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.f
                                                          constant:-padding];
    [self.superview addConstraint:c];
}


- (void)rz_centerHorizontallyInContainer
{
    [self rz_centerHorizontallyInContainerWithOffset:0];
}

- (void)rz_centerHorizontallyInContainerWithOffset:(CGFloat)offset
{
    NSAssert(self.superview != nil, @"Must have superview");
    
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.superview
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.f
                                                          constant:offset];
    [self.superview addConstraint:c];
}

- (void)rz_centerVerticallyInContainer
{
    [self rz_centerVerticallyInContainerWithOffset:0];
}

- (void)rz_centerVerticallyInContainerWithOffset:(CGFloat)offset
{
    NSAssert(self.superview != nil, @"Must have superview");
    
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.superview
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.f
                                                          constant:offset];
    [self.superview addConstraint:c];
}

- (void)rz_fillContainerWithInsets:(UIEdgeInsets)insets
{
    NSAssert(self.superview != nil, @"Must have superview");

    NSArray *h = [NSLayoutConstraint constraintsWithVisualFormat:@"|-left-[self]-right-|"
                                                         options:0
                                                         metrics:@{@"left" : @(insets.left), @"right" : @(insets.right)}
                                                           views:@{@"self" : self}];
    
    NSArray *v = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[self]-bottom-|"
                                                         options:0
                                                         metrics:@{@"top" : @(insets.top), @"bottom" : @(insets.bottom)}
                                                           views:@{@"self" : self}];
    
    [self.superview addConstraints:[h arrayByAddingObjectsFromArray:v]];
}

- (void)rz_spaceSubviews:(NSArray *)subviews vertically:(BOOL)vertically minimumItemSpacing:(CGFloat)itemSpacing
{
    NSAssert(subviews.count > 1, @"Must provide at least two items");
    
    NSMutableArray *constraints = [NSMutableArray array];

    NSLayoutAttribute a1 = vertically ? NSLayoutAttributeTop : NSLayoutAttributeLeft;
    NSLayoutAttribute a2 = vertically ? NSLayoutAttributeBottom : NSLayoutAttributeRight;
    
    [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop)
    {

        UIView *nextView = (idx == subviews.count - 1) ? nil : subviews[idx + 1];

        if (nextView)
        {
            NSLayoutConstraint *s = [NSLayoutConstraint constraintWithItem:nextView
                                                                 attribute:a1
                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                    toItem:view
                                                                 attribute:a2
                                                                multiplier:1.f
                                                                  constant:itemSpacing];

            [constraints addObject:s];
        }

    }];
    
    [self addConstraints:constraints];
}

- (void)rz_distributeSubviews:(NSArray *)subviews vertically:(BOOL)vertically
{
    NSAssert(subviews.count > 1, @"Must provide at least two items");
    
    NSMutableArray *constraints = [NSMutableArray array];
    
    NSLayoutAttribute centerAlongAxisAttribute = vertically ? NSLayoutAttributeCenterX : NSLayoutAttributeCenterY;
    NSLayoutAttribute distributeAlongAxisAttribute = vertically ? NSLayoutAttributeCenterY : NSLayoutAttributeCenterX;
    
    // Calculate the incremental offset of each view as proportion of the container's center point: 1/((n + 1) / 2)
    CGFloat distributionMultiplierIncrement = 1.0f / ((subviews.count + 1) / 2.0f);
    
    [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop)
    {
         // Calculate the actual multiplier for this view index.
         CGFloat distributionMultiplier = distributionMultiplierIncrement * (idx + 1);
         
         // Create a constraint representing distribution along the given axis using this multiplier.
         NSLayoutConstraint *distributeConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                                 attribute:distributeAlongAxisAttribute
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self
                                                                                 attribute:distributeAlongAxisAttribute
                                                                                multiplier:distributionMultiplier
                                                                                  constant:0];
         
         // Create a constraint to center the view along the other axis.
         NSLayoutConstraint *centerConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                             attribute:centerAlongAxisAttribute
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:centerAlongAxisAttribute
                                                                            multiplier:1
                                                                              constant:0];
         // Add both constraints for the view.
         [constraints addObject:distributeConstraint];
         [constraints addObject:centerConstraint];
     }];
    
    [self addConstraints:constraints];
}

- (void)rz_alignSubviews:(NSArray *)subviews byAttribute:(NSLayoutAttribute)attribute
{
    NSAssert(subviews.count > 1, @"Must provide at least two items");

    NSMutableArray *constraints = [NSMutableArray array];
    
    [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop)
    {

        UIView *nextView = (idx == subviews.count - 1) ? nil : subviews[idx + 1];
        if (nextView)
        {
            NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:nextView
                                                                 attribute:attribute
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:view
                                                                 attribute:attribute
                                                                multiplier:1.f
                                                                  constant:0.f];
            [constraints addObject:c];
        }

    }];
    
    [self addConstraints:constraints];
}

@end
