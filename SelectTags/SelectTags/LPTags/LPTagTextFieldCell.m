//
//  LPTagTextFieldCell.m
//  BangTuiKe
//
//  Created by jm on 15/11/10.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "LPTagTextFieldCell.h"
#import "UIColor+LPKit.h"
#import "Masonry.h"

@interface LPTagTextFieldCell ()<UITextFieldDelegate>

@end

@implementation LPTagTextFieldCell {
    UITextField *_textField;
//    IQKeyboardReturnKeyHandler *_returnKeyHandler;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {

    _textField = [[UITextField alloc] init];
    _textField.placeholder = @" 添加标签";
    _textField.delegate = self;
    _textField.tintColor = [UIColor colorWithHexString:@"009788"];
    _textField.font = [UIFont systemFontOfSize:14];
    [_textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_textField];
    
//    _returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] init];
//    _returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyNext;
//    _returnKeyHandler.delegate = self;
//    [_returnKeyHandler addTextFieldView:_textField];
    
    [self refreshConstraints];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(-3.5);
    }];
}

- (void)refreshConstraints {
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsDisplay];
    [self layoutIfNeeded];
}

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass(self);
}


#pragma mark - UITextFieldDelegate

- (void)textFieldChanged:(UITextField *)textField {
    NSString *toString = textField.text;
    NSString *language = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([language isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textField markedTextRange];
        // 获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toString.length > 12) {
//                [LPToast showToast:@"您最多可以输入12个字"];
                textField.text = [toString substringToIndex:12];
            }
        }
    } else { // 非中文输入法
        if (toString.length > 12) {
//            [LPToast showToast:@"您最多可以输入12个字"];
            textField.text = [toString substringToIndex:12];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text.length == 0) {
        return NO;
    }
    
    LPTagModel *model = [[LPTagModel alloc] init];
    model.name = text;
    textField.text = @" ";
    if (self.delegate && [self.delegate respondsToSelector:@selector(addTag:)]) {
        [self.delegate addTag:model];
        
    }
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@" "]) {
        textField.text = @"";
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        textField.text = @" ";
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.length == 1 && range.location == 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteTag)]) {
            [self.delegate deleteTag];
        }
        return NO;
    }
    return YES;
}

@end
