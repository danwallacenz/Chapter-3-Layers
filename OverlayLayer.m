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
    self.grid.contentsScale = [UIScreen mainScreen].scale;
    self.grid.lineWidth = 2.0;
    self.grid.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
    self.grid.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8].CGColor;
    
    CGMutablePathRef p = CGPathCreateMutable();
    CGPathAddEllipseInRect(p, nil, CGRectInset(self.bounds,3,3)); // ?????
    
    self.grid.path = p;
    [self addSublayer: self.grid];
    
}

@end
