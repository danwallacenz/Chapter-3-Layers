//
//  OverlayLayer.m
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 9/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "OverlayLayer.h"

@interface OverlayLayer ()

@property (strong, nonatomic) CAShapeLayer *grid;

@end

@implementation OverlayLayer

- (void)display
{
    if (!self.grid) {
        self.grid = [CAShapeLayer new];
    }
    self.bounds = [UIScreen mainScreen].bounds;
    self.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.2].CGColor;
    
    
    self.grid.contentsScale = [UIScreen mainScreen].scale;
    self.grid.lineWidth = 2.0;
    self.grid.fillColor = [[UIColor blackColor] colorWithAlphaComponent: 0.1].CGColor;
    self.grid.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent: 0.5].CGColor;
    
    CGMutablePathRef p = CGPathCreateMutable();
//    CGPathAddEllipseInRect(p, nil, CGRectInset(self.bounds,3,3)); // ?????
//    CGPathAddEllipseInRect(p, nil, self.bounds); // ?????
    
//    CGContextMoveToPoint(p, 0.0, 0.0);
//    void CGPathAddRect (
//                        CGMutablePathRef path,
//                        const CGAffineTransform *m,
//                        CGRect rect
//                        )
    CGFloat lineWidth = 1.0;
    CGPathAddRect(p, nil, CGRectMake(0.0, 0.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 100.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 200.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 300.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 300.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 400.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 500.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 600.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 700.0, self.bounds.size.width, lineWidth));
    
    self.grid.path = p;
    [self addSublayer: self.grid];
    
//    self.bounds = [UIScreen mainScreen].bounds;
//    self.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
}

@end
