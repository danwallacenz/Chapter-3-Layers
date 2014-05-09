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

-(void)drawPoint:(CGPoint)point
{
    CAShapeLayer *pointLayer = [CAShapeLayer new];
    pointLayer.contentsScale = [UIScreen mainScreen].scale;
    pointLayer.fillColor = [UIColor redColor].CGColor;
    pointLayer.lineWidth = 2.0;
    pointLayer.strokeColor = [UIColor redColor].CGColor;
    pointLayer.bounds = self.bounds;
    pointLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, CGRectMake(point.x, point.y, 60, 60));
    CGPathRelease(path);
    
    [self addSublayer:pointLayer];
    [self setNeedsDisplay];
}


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
    
    // height and width are flipped in landscape
    float height = 0;
    float width = 0;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(orientation == UIInterfaceOrientationPortrait){
        height = self.bounds.size.height;
        width = self.bounds.size.width;
    }else{
        height = self.bounds.size.width;
        width = self.bounds.size.height;
    }
    
    // draw horizontal lines.
    for (int y=0; y < self.bounds.size.height; y += 100) {
        CGPathAddRect(p, nil, CGRectIntegral(CGRectMake(0.0, y, width, lineWidth)));
    }
    
    // draw vertical lines
    for (int x=0; x < self.bounds.size.width; x += 100) {
        CGPathAddRect(p, nil, CGRectIntegral( CGRectMake(x, 0.0, lineWidth, height)));
    }

    grid.path = p;
    CGPathRelease(p);
    
    return grid;
}

@end
