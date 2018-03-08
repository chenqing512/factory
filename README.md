# factory
项目模板
1、主页面push的时候调用：hidesBottomBarWhenPushed
  NextViewController *vc=[[NextViewController alloc]init];
  vc.hidesBottomBarWhenPushed=YES;
  [self.navigationController pushViewController:vc animated:YES];
