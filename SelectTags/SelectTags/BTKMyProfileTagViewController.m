//
//  BTKMyProfileTagViewController.m
//  BangTuiKe
//
//  Created by jm on 15/11/10.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "BTKMyProfileTagViewController.h"

#import "UIViewController+BackButtonHandler.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "UIColor+LPKit.h"
#import "NSMutableArray+LPKit.h"
#import "Masonry.h"

#import "LPTagCollectionView.h"
#import "LPTagCell.h"
#import "LPTagTextFieldCell.h"
#import "LPTagModel.h"

@interface BTKMyProfileTagViewController () <UICollectionViewDataSource, UICollectionViewDelegateLeftAlignedLayout, LPAddTagDelegate, UIGestureRecognizerDelegate, LPSelectedTagDelegate>

@end

@implementation BTKMyProfileTagViewController {
    UICollectionView *_selectedCollectionView;
    UIView *_backgroundView;
    UIButton *_submitButton;
    UIMenuController *_menuController;
    LPTagCollectionView *_tagCollectionView;
    
    NSArray *_tagArray;
    NSMutableArray *_selectedArray;
    UILongPressGestureRecognizer *_longPress;
    LPTagModel *_deleteModel;
    
    NSInteger _selectedCollectionViewHeight;
    NSInteger _tagCollectionViewHeight;
    NSInteger _maxSelectedNumber;
    NSInteger _tagCollectionViewMaxHeight;
    NSInteger _selectedCollectionViewMaxHeight;
    NSInteger _selectedCollectionViewContentSizeHeight;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"选择标签";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"F3F3F3"]];
}

- (void)loadData {
    _selectedArray = [[NSMutableArray alloc] init];
    LPTagModel *model = [[LPTagModel alloc] init];
    model.name = @"heh";
    model.isChoose = NO;
    [_selectedArray addObject:model];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 40; i ++) {
        LPTagModel *model = [[LPTagModel alloc] init];
        model.name = [NSString stringWithFormat:@"Tag %li", i];
        model.isChoose = NO;
        [array addObject:model];
    }
    
    _tagArray = array.copy;
    
    _maxSelectedNumber = 8;
    _selectedCollectionViewHeight = 0;
    _selectedCollectionViewMaxHeight = 250;
}

- (void)loadView {
    [super loadView];
    
    [self loadData];
    
    self.view.layer.masksToBounds = YES;
    
    _backgroundView = [[UIView alloc] init];
    _backgroundView.layer.masksToBounds = YES;
    _backgroundView.layer.borderWidth = 1;
    _backgroundView.layer.borderColor = [UIColor colorWithHexString:@"CECECE"].CGColor;
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backgroundView];
    
    UICollectionViewLeftAlignedLayout *collectionViewLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
    _selectedCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
    _selectedCollectionView.dataSource = self;
    _selectedCollectionView.delegate = self;
    _selectedCollectionView.backgroundColor = [UIColor clearColor];
    [_selectedCollectionView registerClass:[LPTagCell class] forCellWithReuseIdentifier:[LPTagCell cellReuseIdentifier]];
    [_selectedCollectionView registerClass:[LPTagTextFieldCell class] forCellWithReuseIdentifier:[LPTagTextFieldCell cellReuseIdentifier]];
    [self.view addSubview:_selectedCollectionView];
    
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(myProfileTagLongPress:)];
    [_selectedCollectionView addGestureRecognizer:_longPress];
    
    _tagCollectionView = [[LPTagCollectionView alloc] init];
    _tagCollectionView.tagArray = _tagArray;
    _tagCollectionView.tagDelegate = self;
    [self.view addSubview:_tagCollectionView];
    
    _submitButton = [[UIButton alloc] init];
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = 4;
    if (_selectedArray.count == 0) {
        _submitButton.enabled = NO;
    }
    [_submitButton setTitle:@"保存" forState:UIControlStateNormal];
    [_submitButton setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"DCDCDC"]] forState:UIControlStateDisabled];
    [_submitButton setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"009788"]] forState:UIControlStateNormal];
    [_submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitButton];

    [self refreshConstraints];
}

- (void)updateViewConstraints {
    if (_selectedCollectionViewHeight == 0) {
        _selectedCollectionViewHeight = _selectedCollectionView.contentSize.height;
    }
    
    if (_tagCollectionViewHeight == 0 && _selectedCollectionViewHeight != 0) {
        _tagCollectionViewMaxHeight = self.view.frame.size.height - _selectedCollectionViewHeight - 12 - 80;
        _tagCollectionViewHeight = _tagCollectionViewMaxHeight < _tagCollectionView.contentSize.height ? _tagCollectionViewMaxHeight : _tagCollectionView.contentSize.height;
    }
    
    [_selectedCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(12);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(_selectedCollectionViewHeight);
    }];
    
    [_backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_selectedCollectionView);
        make.left.equalTo(_selectedCollectionView).offset(-5);
        make.right.equalTo(_selectedCollectionView).offset(5);
    }];
    
    [_tagCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(_tagCollectionViewHeight);
    }];
    
    [_submitButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagCollectionView.mas_bottom).offset(12);
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.height.mas_equalTo(44);
    }];
    [super updateViewConstraints];
}

- (void)refreshConstraints {
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
    [self.view setNeedsDisplay];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger number = _selectedArray.count + 1;
    return number;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _selectedArray.count) {
        LPTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LPTagCell cellReuseIdentifier] forIndexPath:indexPath];
        cell.type = LPTagCellTypeSelected1;
        cell.model = _selectedArray[indexPath.row];
        return cell;
    }
    
    LPTagTextFieldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LPTagTextFieldCell cellReuseIdentifier] forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}


#pragma mark - UICollectionViewDelegateLeftAlignedLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _selectedArray.count) {
        CGSize size = [((LPTagModel *)_selectedArray[indexPath.row]).name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        return CGSizeMake(size.width + 16, 30);
    }
    return CGSizeMake(100, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 12;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(6, 12, 6, 12);
}

#pragma mark - LPAddTagDelegate
- (void)addTag:(LPTagModel *)tagModel {
    for (int i = 0; i < _selectedArray.count; i ++) {
        LPTagModel *model = _selectedArray[i];
        if ([model.name isEqualToString:tagModel.name]) {
            NSIndexPath *fromIndexPath = [NSIndexPath indexPathForItem:i inSection:0];
            NSIndexPath *toIndexPath = [NSIndexPath indexPathForItem:_selectedArray.count - 1 inSection:0];
            [_selectedArray moveObjectFromIndex:i toIndex:_selectedArray.count - 1];
            [_selectedCollectionView performBatchUpdates:^{
                [_selectedCollectionView moveItemAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
            } completion:^(BOOL finished) {
                if (finished) {
                    [self updateSelectedCollectionView];
                }
            }];
            NSLog(@"重复");
            return;
        }
    }
    
    NSLog(@"addTag");
    
    for (int i = 0; i < _tagArray.count; i ++) {
        LPTagModel *model = _tagArray[i];
        if ([model.name isEqualToString:tagModel.name]) {
            model.isChoose = YES;
            NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            LPTagCell *cell = (LPTagCell *)[_tagCollectionView cellForItemAtIndexPath:indexPath];
            cell.model = model;
            tagModel = model;
            break;
        }
    }
    
    [_selectedArray addObject:tagModel];
        [_selectedCollectionView performBatchUpdates:^{
        [_selectedCollectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:_selectedArray.count - 1 inSection:0]]];
        } completion:^(BOOL finished) {
            if (finished) {
                [self updateSelectedCollectionView];
            }
        }];
}

- (void)deleteTag {
    NSLog(@"deleteTag");
    if (_selectedArray.count > 0) {
        LPTagModel *lastModel = [_selectedArray lastObject];
        [self deleteTag:lastModel];
    }
}

# pragma mark - LPSelectedTagDelegate
- (void)selectedTag:(LPTagModel *)tagModel {
    [self addTag:tagModel];
}

- (void)unSelectedTag:(LPTagModel *)tagModel {
    [self deleteTag:tagModel];
}

#pragma mark - action
- (void)myProfileTagLongPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按开始");
        CGPoint location = [sender locationInView:_selectedCollectionView];
        NSIndexPath * indexPath = [_selectedCollectionView indexPathForItemAtPoint:location];
        if (indexPath.row == _selectedArray.count) {
            return;
        }
        LPTagCell *cell = (LPTagCell *)[_selectedCollectionView cellForItemAtIndexPath:indexPath];
        _deleteModel = cell.model;
        [cell becomeFirstResponder];
        [self showMenuViewController:cell.textLabel];
    }
}

- (void)showMenuViewController:(UIView *)showInView
{
    _menuController = [UIMenuController sharedMenuController];
    UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteMenuAction:)];
    [_menuController setMenuItems:@[deleteItem]];
    [_menuController setTargetRect:showInView.frame inView:showInView.superview];
    [_menuController setMenuVisible:YES animated:YES];
}

- (void)deleteMenuAction:(id)sender {
    [self deleteTag:_deleteModel];
}

- (void)deleteTag:(LPTagModel *)tagModel {
    for (int i = 0; i < _tagArray.count; i ++) {
        LPTagModel *model = _tagArray[i];
        if ([model.name isEqualToString:tagModel.name]) {
            model.isChoose = NO;
            NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            LPTagCell *cell = (LPTagCell *)[_tagCollectionView cellForItemAtIndexPath:indexPath];
            cell.model = model;
            break;
        }
    }
    NSUInteger integer = [_selectedArray indexOfObject:tagModel];
    [_selectedArray removeObjectAtIndex:integer];
    [_selectedCollectionView performBatchUpdates:^{
        [_selectedCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:integer inSection:0]]];
    } completion:^(BOOL finished) {
        if (finished) {
            [self updateSelectedCollectionView];
        }
    }];
}

- (void)updateSelectedCollectionView {
    if (_selectedArray.count == 0) {
        _submitButton.enabled = NO;
    } else {
        _submitButton.enabled = YES;
    }
    if (_selectedCollectionViewContentSizeHeight != _selectedCollectionView.contentSize.height) {
        _selectedCollectionViewContentSizeHeight = _selectedCollectionView.contentSize.height;
        NSInteger selectedCollectionViewHeight = _selectedCollectionView.contentSize.height;
        if (selectedCollectionViewHeight <= _selectedCollectionViewMaxHeight) {
            _selectedCollectionViewHeight = _selectedCollectionView.contentSize.height;
            _tagCollectionViewMaxHeight = self.view.frame.size.height - _selectedCollectionViewHeight - 12 - 80;
            _tagCollectionViewHeight = _tagCollectionViewMaxHeight < _tagCollectionView.contentSize.height ? _tagCollectionViewMaxHeight : _tagCollectionView.contentSize.height;
            [self updateView];
        } else {
                [_selectedCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedArray.count inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];    
        }
    }
}

- (void)updateView {
    [UIView animateWithDuration:0.1 animations:^{
        [self updateViewConstraints];
        [self.view layoutIfNeeded];
    }];
}

- (void)submitClick {
    NSLog(@"%@", _selectedArray);
//    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)navigationShouldPopOnBackButton {
    if (_selectedArray.count == 0) {
        return YES;
    }
    [self.view endEditing:YES];
//    [LPAlertView alertWithTitle:@"提示" withMessage:@"是否放弃对标签的修改" cancelButtonTitle:@"继续编辑" otherButtonTitle:@"放弃" withCompletionBlock:^(DQAlertView *alertView, NSInteger buttonIndex) {
//        if (buttonIndex == 1) {
//            [self dismissViewControllerAnimated:YES completion:nil];
//        } else {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }];
    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
