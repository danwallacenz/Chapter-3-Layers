//
//  ViewController.m
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 6/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *drawingView;

@property (strong, nonatomic) CALayer *lay11;

@property (strong, nonatomic) CALayer *blueLayer;
@property (strong, nonatomic) CALayer *orangeLayer;
@property (strong, nonatomic) CALayer *yellowLayer;

@end

@implementation ViewController


#pragma mark actions
- (IBAction)maskToBoundsChanged:(UISwitch *)sender
{
    self.lay11.masksToBounds = !self.lay11.masksToBounds;
}

- (IBAction)hiddenChanged:(UISwitch *)sender {
    self.lay11.hidden = !self.lay11.hidden;
}

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self drawThreeLayers];
    [self drawTwoLayersAndAView];
    [self drawThreeLayersToManipulateTheLayerHeirarchy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark drawing

-(void) drawThreeLayersToManipulateTheLayerHeirarchy
{
    UIView *layerHierarchyContainer = [[UIView alloc]initWithFrame:CGRectMake(100,420,300,300)];
    layerHierarchyContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:layerHierarchyContainer];
    
    self.blueLayer = [CALayer new];
    self.blueLayer.frame = CGRectMake(10, 10, 100, 100);
    self.blueLayer.backgroundColor = [[UIColor blueColor] CGColor];
    [layerHierarchyContainer.layer addSublayer: self.blueLayer];
    
    self.orangeLayer = [CALayer new];
    self.orangeLayer.frame = CGRectMake(50, 50, 100, 100);
    self.orangeLayer.backgroundColor = [[UIColor orangeColor] CGColor];
    [layerHierarchyContainer.layer addSublayer: self.orangeLayer];
    
    self.yellowLayer = [CALayer new];
    self.yellowLayer.frame = CGRectMake(100, 100,100, 100);
    self.yellowLayer.backgroundColor = [[UIColor yellowColor] CGColor];
    [layerHierarchyContainer.layer addSublayer: self.yellowLayer];
}

-(void) drawThreeLayers
{
    CALayer *lay1 = [CALayer new];
    lay1.frame = CGRectMake(113, 11, 132, 194);
    lay1.backgroundColor = [[UIColor colorWithRed: 1 green: .4 blue: 1 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:lay1];
    
    CALayer *lay2 = [CALayer new];
    lay2.frame = CGRectMake(41, 56, 132, 194);
    lay2.backgroundColor = [[UIColor colorWithRed: .5 green: 1 blue: 0 alpha: 1] CGColor];
    [lay1 addSublayer:lay2];
    
    CALayer *lay3 = [CALayer new];
    lay3.frame = CGRectMake(43, 97, 160, 230);
    lay3.backgroundColor = [[UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:lay3];
}

-(void) drawTwoLayersAndAView
{
    self.lay11 = [CALayer new];
    self.lay11.frame = CGRectMake(413, 11, 132, 194);
    self.lay11.backgroundColor = [[UIColor colorWithRed: 1 green: .4 blue: 1 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:self.lay11];
    
    CALayer *lay21 = [CALayer new];
    lay21.frame = CGRectMake(41, 56, 132, 194);
    lay21.backgroundColor = [[UIColor colorWithRed: .5 green: 1 blue: 0 alpha: 1] CGColor];
    [self.lay11 addSublayer: lay21];
    
    UIImageView* iv =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smileyiPhone"]];
    CGRect r = iv.frame;
    r.origin = CGPointMake(460,76);
    iv.frame = r;
    [self.drawingView addSubview:iv];
    
    CALayer *lay31 = [CALayer new];
    lay31.frame = CGRectMake(343, 97, 160, 230);
    lay31.backgroundColor = [[UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:lay31];
}


@end
