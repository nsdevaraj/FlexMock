/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  eStud

@internal 

*/
package com.adams.quiz.model.vo
{
	import com.adams.swizdao.model.vo.AbstractVO;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Menu extends AbstractVO
	{
		private var _menuId:int; 
		private var _menuLabel:String;
		public var menuXML:String;
		public var chapters:ArrayCollection = new ArrayCollection();
		public function Menu()
		{
			super();
		}
		
		public function get menuLabel():String
		{
			return _menuLabel;
		}
		
		public function set menuLabel(value:String):void
		{
			_menuLabel = value;
		}
		
		public function get menuId():int
		{
			return _menuId;
		}
		
		public function set menuId(value:int):void
		{
			_menuId = value;
		}
		
		override public function fill(item:Object):void{ 
			if(item is ArrayCollection){
				for each(var chap:Object in item){
					var chapter:Chapter = new Chapter();
					chapter.chapterId = chap.id;
					chapter.menu = this;
					chapter.chapterXML = chap.value;
					chapter.chapterLabel = chap.label;
					chapters.addItem(chapter);
				}
			}
		}
	}
}