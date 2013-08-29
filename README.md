UITableViewWithSwipeAndPinch
============================

You can implement custom swipe(left/right) and pinch event.
Just add NBUiTableViewController file in your project and add in your view controller .
Implement protocol method.
EXample project is attached with it.
Example:
  
  	self.modifiedTable = [[NBTableViewController alloc]initWithStyle:UITableViewStylePlain];
    	[self.modifiedTable setDeligate:self];
   	 self.modifiedTable.view.frame = self.view.frame;
   	 [self.view addSubview:self.modifiedTable.view];
