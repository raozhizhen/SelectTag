//
//  LPTagCell.m
//  SocialSport
//
//  Created by jm on 15/10/13.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "LPTagCell.h"
#import "Masonry.h"
#import "UIColor+SelectTags.h"

@interface LPTagCell ()

@end

@implementation LPTagCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _textLabel = [[UILabel alloc] init];
    [_textLabel setTextAlignment:NSTextAlignmentCenter];
    _textLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_textLabel];
    
    [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.contentView).offset(0);
        make.width.equalTo(self);
    }];
}

- (void)setModel:(LPTagModel *)model {
    _model = model;
    _textLabel.text = model.name;
    if (self.type == LPTagCellTypeSelected1) {
        
        _textLabel.layer.cornerRadius = 4;
        _textLabel.layer.backgroundColor = [UIColor ST_009788_mainColor].CGColor;
        [_textLabel setTextColor:[UIColor whiteColor]];
    } else {
        if (!model.isChoose) {
            [_textLabel setTextColor:[UIColor ST_969696_subMainColor]];
            _textLabel.layer.cornerRadius = 4;
            _textLabel.layer.borderColor = [UIColor ST_969696_subMainColor].CGColor;
            _textLabel.layer.borderWidth = 0.5;
        } else {
            [_textLabel setTextColor:[UIColor ST_009788_mainColor]];
            _textLabel.layer.borderWidth = 0.5;
            _textLabel.layer.cornerRadius = 4;
            _textLabel.layer.borderColor = [UIColor ST_009788_mainColor].CGColor;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass(self);
}

@end
