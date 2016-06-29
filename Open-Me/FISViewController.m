//
//  FISViewController.m
//  Open-Me
//
//  Created by Joe Burgess on 3/4/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

#define HORIZONTAL self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact

@interface FISViewController ()

@property (nonatomic, strong) IBOutlet UIView *textFieldView;
@property (nonatomic, strong) IBOutlet UITextField *textField;

@property (nonatomic, strong) IBOutlet UIStackView *numberPadStackView;
@property (nonatomic, strong) IBOutletCollection(UIStackView) NSArray *nestedNumberPadStackViews;

@property (nonatomic, strong) NSLayoutConstraint *numberPadTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *textFieldTopConstraint;

- (IBAction)selectedNumber:(id)sender;

@end

@implementation FISViewController

#pragma mark - Actions

- (IBAction)selectedNumber:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *newTextFieldValue = [self.textField.text stringByAppendingString:button.titleLabel.text];
    
    self.textField.text = newTextFieldValue;
}

#pragma mark - Layout

- (void)layoutView {
    [self.view removeConstraints:self.view.constraints];
    [self.textFieldView removeConstraints:self.textFieldView.constraints];
    
    self.numberPadTopConstraint = [self.numberPadStackView.topAnchor constraintEqualToAnchor:self.view.centerYAnchor];
    self.numberPadTopConstraint.active = YES;
    
    [self.numberPadStackView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:50.f].active = YES;
    [self.numberPadStackView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20.f].active = YES;
    [self.numberPadStackView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-50.f].active = YES;
    
    self.textFieldTopConstraint = [self.textFieldView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0.f];
    self.textFieldTopConstraint.active = YES;
    
    [self.textFieldView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.textFieldView.bottomAnchor constraintEqualToAnchor:self.numberPadStackView.topAnchor].active = YES;
    [self.textFieldView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    
    [self.textField.topAnchor constraintEqualToAnchor:self.textFieldView.centerYAnchor constant:0.f].active = YES;
    [self.textField.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20.f].active = YES;
    [self.textField.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20.f].active = YES;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    if (HORIZONTAL) {
        self.numberPadTopConstraint.constant = -15.f;
        self.textFieldTopConstraint.constant = -30.f;
    } else {
        self.numberPadTopConstraint.constant = 0.f;
        self.textFieldTopConstraint.constant = 0.f;
    }
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutView];
}

@end
