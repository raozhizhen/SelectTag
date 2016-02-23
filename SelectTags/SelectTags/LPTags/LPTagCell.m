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
#import "UIImage+RoundedCorner.h"
#import "LPRoundedCornerView.h"

@interface LPTagCell ()

@property (nonatomic, strong) UIImageView *imageView;

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
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    
    _textLabel = [[UILabel alloc] init];
    [_textLabel setTextAlignment:NSTextAlignmentCenter];
    _textLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_textLabel];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.contentView).offset(0);
        make.width.equalTo(self.contentView);
    }];
    
    [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setModel:(LPTagModel *)model {
    _model = model;
    _textLabel.text = model.name;
    if (self.type == LPTagCellTypeSelected1) {
        __weak __typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            UIImage *image = [UIImage yal_imageWithRoundedCornersAndSize:weakSelf.frame.size andCornerRadius:4 andColor:[UIColor ST_009788_mainColor]];
            UIImage *image = [UIImage imageWithRoundedCornersAndSize:weakSelf.frame.size CornerRadius:10 borderColor:[UIColor redColor] borderWidth:0.5 backgroundColor:[UIColor ST_009788_mainColor] backgroundImage:[UIImage imageNamed:@"avatar"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.imageView.image = image;
            });
        });
        [_textLabel setTextColor:[UIColor whiteColor]];
    } else {
        if (!model.isChoose) {
            [_textLabel setTextColor:[UIColor ST_969696_subMainColor]];
//            self.contentView.backgroundColor = [UIColor clearColor];
//            self.contentView.layer.borderColor = [UIColor ST_969696_subMainColor].CGColor;
//            self.contentView.layer.borderWidth = 1;
            UIView *view = [[LPRoundedCornerView alloc] initWithSize:self.frame.size CornerRadius:10 borderColor:[UIColor redColor] borderWidth:1 backgroundColor:nil backgroundImage:nil];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
        } else {
            [_textLabel setTextColor:[UIColor ST_009788_mainColor]];
//            self.contentView.backgroundColor = [UIColor clearColor];
//            self.contentView.layer.borderColor = [UIColor ST_009788_mainColor].CGColor;
//            self.contentView.layer.borderWidth = 1;
        }
    }
    [self updateConstraints];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass(self);
}

@end
