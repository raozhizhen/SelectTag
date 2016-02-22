//
//  LPTagCell.m
//  SocialSport
//
//  Created by jm on 15/10/13.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "LPTagCell.h"
#import "Masonry.h"
#import "UIColor+LPKit.h"
#import "UIImage+JMRoundedCorner.h"

@implementation LPTagCell {
    UIImageView *_roundedCornerView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
//    _roundedCornerView =
    
    _textLabel = [[UILabel alloc]init];
    [_textLabel setTextAlignment:NSTextAlignmentCenter];
    _textLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_textLabel];
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 4;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.contentView).offset(0);
        make.centerX.equalTo(self.contentView);
    }];
}

- (void)setModel:(LPTagModel *)model {
    _model = model;
    _textLabel.text = model.name;
    
    if (self.type == LPTagCellTypeSelected1) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"009788"];
        [_textLabel setTextColor:[UIColor whiteColor]];
    } else {
        if (!model.isChoose) {
            [_textLabel setTextColor:[UIColor colorWithHexString:@"969696"]];
            self.contentView.backgroundColor = [UIColor clearColor];
            self.contentView.layer.borderColor = [UIColor colorWithHexString:@"969696"].CGColor;
            self.contentView.layer.borderWidth = 1;
        } else {
            [_textLabel setTextColor:[UIColor colorWithHexString:@"009788"]];
            self.contentView.backgroundColor = [UIColor clearColor];
            self.contentView.layer.borderColor = [UIColor colorWithHexString:@"009788"].CGColor;
            self.contentView.layer.borderWidth = 1;
        }
    }

    [self refreshConstraints];
}

- (void)refreshConstraints {
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsDisplay];
    [self layoutIfNeeded];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

+ (NSString *)cellReuseIdentifier {
    return @"LPTagCell";
}

@end
