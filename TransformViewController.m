//
//  TransformViewController.m
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 12/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "TransformViewController.h"
#import "CompassView.h"
#import "CompassLayer.h"
#import "OverlayLayer.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
// NSLog(@"Output radians as degrees: %f", RADIANS_TO_DEGREES(0.785398));

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
// NSLog(@"Output degrees as radians: %f", DEGREES_TO_RADIANS(45))

@interface TransformViewController ()

@property (weak, nonatomic) CompassView *compassView;
@property (strong,nonatomic) OverlayLayer *overlayLayer;

@property (weak, nonatomic) IBOutlet UILabel *transformM34Label;
@property (weak, nonatomic) IBOutlet UISlider *transformM34DemominatorSlider;

@property (weak, nonatomic) IBOutlet UILabel *rotationLayerZPositionLabel;
@property (weak, nonatomic) IBOutlet UISlider *rotationLayerZPositionSlider;

@property (weak, nonatomic) IBOutlet UISlider *rotationLayerAnchorPointXSlider;
@property (weak, nonatomic) IBOutlet UISlider *rotationLayerAnchorPointYSlider;
@property (weak, nonatomic) IBOutlet UILabel *rotationLayerAnchorPointXValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotationLayerAnchorPointYValueLabel;



@property (weak, nonatomic) IBOutlet UISlider *rotationLayerPositionXSlider;
@property (weak, nonatomic) IBOutlet UILabel *rotationLayerPositionXValueLabel;

@property (weak, nonatomic) IBOutlet UISlider *rotationLayerPositionYSlider;
@property (weak, nonatomic) IBOutlet UILabel *rotationLayerPositionYValueLabel;


// rotation controls
@property (weak, nonatomic) IBOutlet UISlider *rotationAngleSlider;
@property (weak, nonatomic) IBOutlet UILabel *rotationAngleLabel;

@property (weak, nonatomic) IBOutlet UISlider *rotationVectorXSlider;
@property (weak, nonatomic) IBOutlet UISlider *rotationVectorYSlider;
@property (weak, nonatomic) IBOutlet UISlider *rotationVectorZSlider;

@property (weak, nonatomic) IBOutlet UILabel *rotationVectorXLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotationVectorYLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotationVectorZLabel;

@end

@implementation TransformViewController

#pragma mark actions

- (IBAction)reset:(id)sender
{
    [self.compassView removeFromSuperview];
    self.compassView = nil;
    [self addACompassView];
}

- (IBAction)toggleGrid:(id)sender
{
    self.overlayLayer.hidden = !self.overlayLayer.hidden;
}

- (IBAction)rotateCompassByAngle:(UISlider *)sender
{
    CGFloat angleInRadians = DEGREES_TO_RADIANS(self.rotationAngleSlider.value);
    CGFloat vectorX = self.rotationVectorXSlider.value;
    CGFloat vectorY = self.rotationVectorYSlider.value;
    CGFloat vectorZ = self.rotationVectorZSlider.value;
    
//    ((CompassLayer *)self.compassView.layer).rotationLayer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(sender.value), 0, 1, 0);

     ((CompassLayer *)self.compassView.layer).rotationLayer.transform = CATransform3DMakeRotation(angleInRadians, vectorX, vectorY, vectorZ);
    
    self.rotationAngleLabel.text = [NSString stringWithFormat:@"%1.0f", sender.value];
}

- (IBAction)rotationVectorXSliderChanged:(UISlider *)sender
{
    CGFloat angleInRadians = DEGREES_TO_RADIANS(self.rotationAngleSlider.value);
    CGFloat vectorX = self.rotationVectorXSlider.value;
    CGFloat vectorY = self.rotationVectorYSlider.value;
    CGFloat vectorZ = self.rotationVectorZSlider.value;
    
    self.rotationVectorXLabel.text = [NSString stringWithFormat:@"x=%1.1f",sender.value];
}

- (IBAction)rotationVectorYSliderChanged:(UISlider *)sender
{
     self.rotationVectorYLabel.text = [NSString stringWithFormat:@"y=%1.1f",sender.value];
}

- (IBAction)rotationVectorZSliderChanged:(UISlider *)sender
{
    self.rotationVectorZLabel.text = [NSString stringWithFormat:@"z=%1.1f",sender.value];
}

- (IBAction)rotationLayerPositionXChanged:(UISlider *)sender
{
    ((CompassLayer *)self.compassView.layer).rotationLayer.position = CGPointMake(sender.value, self.rotationLayerPositionYSlider.value);
    self.rotationLayerPositionXValueLabel.text = [NSString stringWithFormat: @"%1.1f", sender.value];
}

- (IBAction)rotationLayerPositionYChanged:(UISlider *)sender
{
    ((CompassLayer *)self.compassView.layer).position = CGPointMake(self.rotationLayerPositionXSlider.value, sender.value);
    self.rotationLayerPositionYValueLabel.text = [NSString stringWithFormat: @"%1.1f", sender.value];
}

/*
 
 // 3D rotation
 self.rotationLayer = g;
 self.rotationLayer.anchorPoint = CGPointMake(1.0, 0.5);
 self.rotationLayer.position = CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds));
 
 self.rotationLayer.transform = CATransform3DMakeRotation(M_PI/4.0, 0, 1, 0);
 
 CATransform3D transform = CATransform3DIdentity;
 transform.m34 = -1.0/1000.0;
 self.sublayerTransform = transform;
 
 
 */

- (IBAction)rotationLayerAnchorPointXChanged:(UISlider *)sender
{
    CGPoint anchorPoint = CGPointMake(sender.value, self.rotationLayerAnchorPointYSlider.value);
    CALayer *rotationLayer = ((CompassLayer *)self.compassView.layer).rotationLayer;
    rotationLayer.anchorPoint = anchorPoint;
    self.rotationLayerAnchorPointXValueLabel.text = [NSString stringWithFormat: @"%1.2f", sender.value];
    
    anchorPoint = CGPointMake(self.compassView.frame.origin.x + (anchorPoint.x * self.compassView.frame.size.width),
                              self.compassView.frame.origin.y + (anchorPoint.y * self.compassView.frame.size.height));
    
    [self.overlayLayer drawPoint: anchorPoint
                       withColor: [UIColor greenColor]
                           label: [NSString stringWithFormat:@"anchor point (%1.1f,%1.1f)", anchorPoint.x, anchorPoint.y]
                            name: @"anchor.point"];
    
    [self.overlayLayer drawPoint: rotationLayer.position
                       withColor: [UIColor redColor]
                           label: [NSString stringWithFormat:@"position (%1.1f,%1.1f)", anchorPoint.x, anchorPoint.y]
                            name: @"position"];
}

- (IBAction)rotationLayerAnchorPointYChanged:(UISlider *)sender
{
    CGPoint anchorPoint = CGPointMake(self.rotationLayerAnchorPointXSlider.value, sender.value);
    CALayer *rotationLayer = ((CompassLayer *)self.compassView.layer).rotationLayer;
    rotationLayer.anchorPoint = anchorPoint;
    
    self.rotationLayerAnchorPointYValueLabel.text = [NSString stringWithFormat: @"%1.2f", sender.value];
    
    anchorPoint = CGPointMake(self.compassView.frame.origin.x + (anchorPoint.x * self.compassView.frame.size.width),
                              self.compassView.frame.origin.y + (anchorPoint.y * self.compassView.frame.size.height));
    
    [self.overlayLayer drawPoint: anchorPoint
                       withColor: [UIColor greenColor]
                           label: [NSString stringWithFormat:@"anchor point (%1.1f,%1.1f)", anchorPoint.x, anchorPoint.y]
                            name: @"anchor.point"];
    
    [self.overlayLayer drawPoint: rotationLayer.position
                       withColor: [UIColor redColor]
                           label: [NSString stringWithFormat:@"position (%1.1f,%1.1f)", anchorPoint.x, anchorPoint.y]
                            name: @"position"];
    
}


- (IBAction)rotationLayerZPositionChanged:(UISlider *)sender
{
    ((CompassLayer *)self.compassView.layer).rotationLayer.zPosition = sender.value;
    self.rotationLayerZPositionLabel.text = [NSString stringWithFormat: @"%1.0f", sender.value];

}

- (IBAction)transformM34DenominatorChanged:(UISlider *)sender
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/[NSNumber numberWithDouble: sender.value].floatValue;
    self.compassView.layer.sublayerTransform = transform;
    
    self.transformM34Label.text = [NSString stringWithFormat: @"transform.m34 = -1.0/%1.1f", sender.value];
}

#pragma mark - UIViewController methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    @property (weak, nonatomic) IBOutlet UILabel *rotationVectorXLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *rotationVectorYLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *rotationVectorZLabel;
    
//    @property (weak, nonatomic) IBOutlet UISlider *rotationVectorXSlider;
//    @property (weak, nonatomic) IBOutlet UISlider *rotationVectorYSlider;
//    @property (weak, nonatomic) IBOutlet UISlider *rotationVectorZSlider;
    
    self.rotationVectorXLabel.text = [NSString stringWithFormat:@"x=%1.1f", self.rotationVectorXSlider.value];
    self.rotationVectorYLabel.text = [NSString stringWithFormat:@"y=%1.1f", self.rotationVectorYSlider.value];
    self.rotationVectorZLabel.text = [NSString stringWithFormat:@"z=%1.1f", self.rotationVectorZSlider.value];
//    @property (weak, nonatomic) IBOutlet UISlider *rotationAngleSlider;
//    @property (weak, nonatomic) IBOutlet UILabel *rotationAngleLabel;
    
    self.rotationAngleLabel.text = [NSString stringWithFormat:@"%1.0f", self.rotationAngleSlider.value];
    
}

#warning TODO set the controls to the actual values of the view, etc.
-(void)addACompassView
{
    // Add a CompassView to to my view.  It has a CompassLayer as its layer.
    CompassView *compassView = [[CompassView alloc] initWithFrame:CGRectMake(100, 100, 400, 400)];
    [self.view addSubview: compassView];
    self.compassView = compassView; // for zPosition changes later.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // Add a CompassView to to my view.  It has a CompassLayer as its layer.
    [self addACompassView];
    
    self.overlayLayer = [OverlayLayer new];
    self.overlayLayer.hidden = YES;
    [self.view.layer addSublayer:  self.overlayLayer];
    
    [self.overlayLayer setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -


@end
