//
//  bottomCell.m
//  football
//
//  Created by 雨停 on 2017/7/31.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "bottomCell.h"
#import "titleCell.h"
@interface bottomCell()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *categoryData;
@property (nonatomic, strong) NSMutableArray *foodData;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic ,assign)NSIndexPath *leftindex;
@property (nonatomic ,assign)NSIndexPath *rightindex;
@end
@implementation bottomCell
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
          }
    return self;
}
-(void)setCateArr:(NSMutableArray *)arr  setDetaileArr:(NSMutableArray *)arrdetaile{
    self.leftindex  =[NSIndexPath indexPathForRow:0 inSection:0];
    self.rightindex  =[NSIndexPath indexPathForRow:0 inSection:0];
    self.categoryData =arr;
    self.foodData = arrdetaile;
    [self setsubview];
}
-(void)setsubview{
   

    _selectIndex = 0;
    _isScrollDown = YES;
    
   // self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.extendedLayoutIncludesOpaqueBars = NO;
   // self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    [self  addSubview:self.leftTableView];
    [self  addSubview:self.rightTableView];
    
    //[self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
     //                               animated:YES
    //                        scrollPosition:UITableViewScrollPositionNone];
    // [self.rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
    //                                 animated:YES
    //                          scrollPosition:UITableViewScrollPositionNone];
}

- (NSMutableArray *)categoryData
{
    if (!_categoryData)
    {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}

- (NSMutableArray *)foodData
{
    if (!_foodData)
    {
        _foodData = [NSMutableArray array];
    }
    return _foodData;
}

- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0.33*KScreenWidth  , 300)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 55;
        //_leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerClass:[titleCell class] forCellReuseIdentifier:@"left"];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.33*KScreenWidth, 0, 0.66*KScreenWidth,300)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 80;
       // _rightTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerClass:[titleCell class] forCellReuseIdentifier:@"right"];
    }
    return _rightTableView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_leftTableView == tableView)
    {
        return 1;
    }
    else if(_rightTableView == tableView)
    {
        return self.categoryData.count;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_leftTableView == tableView)
    {
        return self.categoryData.count;
    }
    else if(_rightTableView == tableView)
    {
        return [self.foodData[section] count];
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      if (_leftTableView == tableView)
    {
        titleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"left" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        NSDictionary   *dic  =self.categoryData[indexPath.row];
        cell.title.text =[dic objectForKey:@"title"];
        cell.title.textColor =KGrayColor;
        if(self.leftindex==indexPath){
            cell.title.textColor =mainColor;
        }
        return cell;
    }
    else
    {
        titleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"right" forIndexPath:indexPath];
        NSArray * arr = self.foodData[indexPath.section];
        NSDictionary * dic =arr[indexPath.row];
        cell.title.text = [dic objectForKey:@"title"];
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.title.textColor =KGrayColor;
        if(self.rightindex==indexPath){
            cell.title.textColor =mainColor;
        }

        return cell;
    }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_leftTableView == tableView)
    {
        return 40;
    }
    else if(_rightTableView == tableView)
    {
        return 40;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (_leftTableView == tableView)
    {
        return 0.0001;
    }
    else if(_rightTableView == tableView)
    {
        return 0.001;
    }
    return 0;
    
}

// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && !_isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && _isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section + 1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        _selectIndex = indexPath.row;
        self.leftindex = indexPath;
        [self.leftTableView reloadData];
        [self scrollToTopOfSection:_selectIndex animated:YES];
       // [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                        //      atScrollPosition:UITableViewScrollPositionTop
                          //            animated:YES];
      //  titleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
       // cell.title.textColor =mainColor;
    }
 else   if (_rightTableView == tableView)
    {
       // _selectIndex = indexPath.row;
         self.rightindex = indexPath;
        if(self.left ){
            self.left(self.leftindex);
        }
        if(self.right ){
            self.right(self.rightindex);
        }
        [self.rightTableView reloadData];
       // [self scrollToTopOfSection:_selectIndex animated:YES];
        // [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
        //      atScrollPosition:UITableViewScrollPositionTop
        //            animated:YES];
        //  titleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        // cell.title.textColor =mainColor;
    }
    
   
}

- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated
{
    CGRect headerRect = [self.rightTableView rectForSection:section];
    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _rightTableView.contentInset.top);
    [self.rightTableView setContentOffset:topOfHeader animated:animated];
}

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
     self.leftindex = [NSIndexPath indexPathForRow:index inSection:0];
    [self.leftTableView reloadData];

    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UISrcollViewDelegate
// 标记一下RightTableView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    
    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
