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
//    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.2].CGColor;
    
    self.grid = [self createGrid];
    [self addSublayer: self.grid];
    
    self.text = [self createText];
    [self addSublayer: self.text];
}

-(CATextLayer *)createText
{
    CATextLayer *text = [CATextLayer new];
    text.contentsScale = [UIScreen mainScreen].scale;
    text.string = @"(100,100)";
    text.bounds = CGRectMake(0, 0, 100, 30);
    text.position = CGPointMake(100.0, 100.0);
    text.alignmentMode = kCAAlignmentCenter;
    text.foregroundColor = [[UIColor grayColor] colorWithAlphaComponent: 0.5].CGColor;
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
    
    // draw vertical lines.
    CGPathAddRect(p, nil, CGRectMake(0.0, 0.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 100.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 200.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 300.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 300.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 400.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 500.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 600.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 700.0, self.bounds.size.width, lineWidth));
    CGPathAddRect(p, nil, CGRectMake(0.0, 800.0, self.bounds.size.width, lineWidth));
    
    // draw horizontal lines
    CGPathAddRect(p, nil, CGRectMake(0.0, 0.0, lineWidth, self.bounds.size.height));
    CGPathAddRect(p, nil, CGRectMake(100.0, 0.0, lineWidth, self.bounds.size.height));
    CGPathAddRect(p, nil, CGRectMake(200.0, 0.0, lineWidth, self.bounds.size.height));
    CGPathAddRect(p, nil, CGRectMake(300.0, 0.0, lineWidth, self.bounds.size.height));
    CGPathAddRect(p, nil, CGRectMake(400.0, 0.0, lineWidth, self.bounds.size.height));
    CGPathAddRect(p, nil, CGRectMake(500.0, 0.0, lineWidth, self.bounds.size.height));
    CGPathAddRect(p, nil, CGRectMake(600.0, 0.0, lineWidth, self.bounds.size.height));
    CGPathAddRect(p, nil, CGRectMake(700.0, 0.0, lineWidth,self.bounds.size.height));
    
    grid.path = p;
    CGPathRelease(p);
    
    return grid;
}

@end
