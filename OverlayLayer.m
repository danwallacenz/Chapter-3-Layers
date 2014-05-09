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
@property (strong, nonatomic) CATextLayer *text;

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
    
    self.grid = [self createGrid];
    [self addSublayer: self.grid];
    
    
    [self createCoordinateLabels];
}

- (void) createCoordinateLabels
{
    for (int x=0; x < self.bounds.size.width; x += 100) {
        for (int y=0 ; y < self.bounds.size.height; y +=100) {
            [self addSublayer:[self createTextAtPoint: CGPointMake(x, y)]];
        }
    }
}

-(CATextLayer *)createTextAtPoint: (CGPoint)point
{
    CATextLayer *text = [CATextLayer new];
    text.contentsScale = [UIScreen mainScreen].scale;
//    text.string = @"(100,100)";
    
    text.string = [NSString stringWithFormat:@"(%1.0f, %1.0f)",point.x, point.y ];
    text.bounds = CGRectMake(0, 0, 100, 30);
    text.position = point;
    text.alignmentMode = kCAAlignmentCenter;
    text.foregroundColor = [[UIColor whiteColor] colorWithAlphaComponent: 0.8].CGColor;
    text.fontSize = 10.0;
    return text;
}

- (CAShapeLayer *)createGrid
{
    CAShapeLayer *grid = [CAShapeLayer new];

    grid.contentsScale = [UIScreen mainScreen].scale;
    grid.lineWidth = 2.0;
    grid.fillColor = [[UIColor blackColor] colorWithAlphaComponent: 0.1].CGColor;
    grid.strokeColor = [[UIColor grayColor] colorWithAlphaComponent: 0.5].CGColor;
    
    CGMutablePathRef p = CGPathCreateMutable();
    CGFloat lineWidth = 1.0;
    
    // draw horizontal lines.
    
    for (int y=0; y < self.bounds.size.height; y += 100) {
        CGPathAddRect(p, nil, CGRectIntegral(CGRectMake(0.0, y, self.bounds.size.width, lineWidth)));
    }
//    CGPathAddRect(p, nil, CGRectMake(0.0, 0.0, self.bounds.size.width, lineWidth));
//    CGPathAddRect(p, nil, CGRectMake(0.0, 100.0, self.bounds.size.width, lineWidth));
//    CGPathAddRect(p, nil, CGRectMake(0.0, 200.0, self.bounds.size.width, lineWidth));
//    CGPathAddRect(p, nil, CGRectMake(0.0, 300.0, self.bounds.size.width, lineWidth));
//    CGPathAddRect(p, nil, CGRectMake(0.0, 300.0, self.bounds.size.width, lineWidth));
//    CGPathAddRect(p, nil, CGRectMake(0.0, 400.0, self.bounds.size.width, lineWidth));
//    CGPathAddRect(p, nil, CGRectMake(0.0, 500.0, self.bounds.size.width, lineWidth));
//    CGPathAddRect(p, nil, CGRectMake(0.0, 600.0, self.bounds.size.width, lineWidth));
//    CGPathAddRect(p, nil, CGRectMake(0.0, 700.0, self.bounds.size.width, lineWidth));
//    CGPathAddRect(p, nil, CGRectMake(0.0, 800.0, self.bounds.size.width, lineWidth));
//    CGPathAddRect(p, nil, CGRectMake(0.0, 900.0, self.bounds.size.width, lineWidth));
    
    // draw vertical lines
    for (int x=0; x < self.bounds.size.width; x += 100) {
        CGPathAddRect(p, nil, CGRectIntegral( CGRectMake(x, 0.0, lineWidth, self.bounds.size.height)));
    }
    
//    CGPathAddRect(p, nil, CGRectMake(0.0, 0.0, lineWidth, self.bounds.size.height));
//    CGPathAddRect(p, nil, CGRectMake(100.0, 0.0, lineWidth, self.bounds.size.height));
//    CGPathAddRect(p, nil, CGRectMake(200.0, 0.0, lineWidth, self.bounds.size.height));
//    CGPathAddRect(p, nil, CGRectMake(300.0, 0.0, lineWidth, self.bounds.size.height));
//    CGPathAddRect(p, nil, CGRectMake(400.0, 0.0, lineWidth, self.bounds.size.height));
//    CGPathAddRect(p, nil, CGRectMake(500.0, 0.0, lineWidth, self.bounds.size.height));
//    CGPathAddRect(p, nil, CGRectMake(600.0, 0.0, lineWidth, self.bounds.size.height));
//    CGPathAddRect(p, nil, CGRectMake(700.0, 0.0, lineWidth,self.bounds.size.height));
//    CGPathAddRect(p, nil, CGRectMake(800.0, 0.0, lineWidth,self.bounds.size.height));
    
    grid.path = p;
    CGPathRelease(p);
    
    return grid;
}

@end
