//
//  SublayerPositioningViewController.m
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 7/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "SublayerPositioningViewController.h"

@interface SublayerPositioningViewController ()

@property (strong, nonatomic) CALayer *layer0;


@property (weak, nonatomic) IBOutlet UISlider *xPositionSlider;
@property (weak, nonatomic) IBOutlet UILabel *positionXLabel;

@property (weak, nonatomic) IBOutlet UISlider *yPositionSlider;
@property (weak, nonatomic) IBOutlet UILabel *positionYLabel;

@property (weak, nonatomic) IBOutlet UISlider *anchorPointXSlider;
@property (weak, nonatomic) IBOutlet UILabel *anchorPointXLabel;

@property (weak, nonatomic) IBOutlet UISlider *anchorPointYSlider;
@property (weak, nonatomic) IBOutlet UILabel *anchorPointYLabel;

@property (strong, nonatomic) UIView *currentCenterMark;
@property (strong, nonatomic) UIView *currentAnchorPointMark;

@end

@implementation SublayerPositioningViewController


- (IBAction)anchorPointXChanged:(UISlider *)sender
{
    self.layer0.anchorPoint = CGPointMake(sender.value, self.anchorPointYSlider.value);
    self.anchorPointXLabel.text = [NSString stringWithFormat:@"%f", sender.value];
    [self addAnchorPointMark: self.layer0];
    [self addPositionMark: self.layer0];
}

- (IBAction)anchorPointY:(UISlider *)sender
{
    self.layer0.anchorPoint = CGPointMake( self.anchorPointXSlider.value, sender.value);
    self.anchorPointYLabel.text = [NSString stringWithFormat:@"%f", sender.value];
    [self addAnchorPointMark: self.layer0];
    [self addPositionMark: self.layer0];
}

- (IBAction)xPositionChanged:(UISlider *)sender
{
    self.layer0.position = CGPointMake(sender.value, self.yPositionSlider.value);
    self.positionXLabel.text = [NSString stringWithFormat:@"%f", sender.value];
    [self addAnchorPointMark: self.layer0];
    [self addPositionMark:self.layer0];
}


- (IBAction)yPositionChanged:(UISlider *)sender
{
    self.layer0.position = CGPointMake(self.xPositionSlider.value, sender.value);
    self.positionYLabel.text = [NSString stringWithFormat:@"%f", sender.value];
    [self addAnchorPointMark: self.layer0];
    [self addPositionMark: self.layer0];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.layer0 = [CALayer new];
    self.layer0.frame = CGRectMake(0, 0, 100, 100);
    self.layer0.backgroundColor = [[UIColor blackColor] CGColor];
    [self.view.layer addSublayer:self.layer0];
    [self addPositionMark:self.layer0];
    [self addAnchorPointMark: self.layer0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addPositionMark: (CALayer*)layer
{
    [self.currentCenterMark removeFromSuperview];
    self.currentCenterMark = nil;
    
    CGPoint position = [self.view.layer convertPoint: layer.position fromLayer: layer.superlayer];
    NSLog(@"position = %f, %f", position.x, position.y);
    
    CGRect centerRect = CGRectMake(0, 0, 4, 4);
    
    UIView *centerPoint = [[UIView alloc] initWithFrame: centerRect];
    centerPoint.center = position;
    
    centerPoint.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:centerPoint];
    self.currentCenterMark = centerPoint;
}

- (void) addAnchorPointMark: (CALayer*)layer
{
    [self.currentAnchorPointMark removeFromSuperview];
    self.currentAnchorPointMark = nil;
    
    CGFloat anchorPointX = layer.anchorPoint.x * layer.bounds.size.width;
    CGFloat anchorPointY = layer.anchorPoint.y * layer.bounds.size.height;

    CGPoint anchorPoint = CGPointMake(anchorPointX, anchorPointY);
    CGPoint anchorPointConverted = [self.view.layer convertPoint: anchorPoint fromLayer: layer.superlayer];
    NSLog(@"anchorPoint = %f, %f", anchorPointConverted.x, anchorPointConverted.y);
    
    CGRect centerRect = CGRectMake(0, 0, 4, 4);
    
    UIView *anchorPointView = [[UIView alloc] initWithFrame: centerRect];
    anchorPointView.center = anchorPointConverted;
    
    anchorPointView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:anchorPointView];
    self.currentAnchorPointMark = anchorPointView;
}

@end
