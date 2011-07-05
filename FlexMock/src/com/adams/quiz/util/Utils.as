/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  QuizMaster

@internal 

*/
package com.adams.quiz.util
{  
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	public class Utils
	{  	  
		public static const QLENGTH:int = 10;
		public static var chapterId:int;
		public static var menuId:int;
		public static var fileSplitter:String =  '//';
		public static const CHOICE:String ='choice';
		public static const XMLPATH:String="assets"+fileSplitter+"xml"+fileSplitter;
		public static const LAUNCHXML:String="home";
		public static const XML:String=".xml";
		// todo: add view index
		public static const MAIN_INDEX:String='Main';
		public static const HEADER_MENU_INDEX:String='HeaderMenu';
		public static const HEADER_LOGO_INDEX:String='HeaderLogo'
		public static const HEADER_CHAPTER_INDEX:String='HeaderChapter'
		public static const HEADER_TOPIC_INDEX:String='HeaderTopic'
		public static const HEADER_LEARN_INDEX:String='HeaderLearn'
		// todo: add key
		public static const CHAPTERKEY  :String='chapterId';
		public static const MENUKEY  :String='menuId';
		public static const QUESTIONITEMKEY  :String='question';
		
		// todo: add dao
       public static const WEB_INDEX:String='Web';
       public static const HEADER_INDEX:String='Header';
		public static const CHAPTERDAO  :String='chapterDAO'; 
		public static const MENUDAO  :String='menuDAO'; 
		public static const RESULT_INDEX:String='Result';
		public static const QUIZ_INDEX:String='Quiz';
		public static const LEARN_INDEX:String='Learn';
		public static const SEARCH_INDEX:String='Search';
		public static const HOME_INDEX:String='Home';
		public static const CHAPTER_INDEX:String='Chapter';
		public static const MENU_INDEX:String='Menu';
		public static const QUESTIONITEMDAO  :String='questionitemDAO'; 
		
		public static function addArrcStrictItem( item:Object, arrc:ArrayCollection, sortString:String, modified:Boolean =false ):void{
			var returnValue:int = -1;
			var sort:Sort = new Sort(); 
			sort.fields = [ new SortField( sortString ) ];
			if(arrc.sort==null) arrc.sort = sort;
			arrc.refresh(); 
			var cursor:IViewCursor = arrc.createCursor();
			var found:Boolean = cursor.findAny( item );	
			if( found ) {
				returnValue = arrc.getItemIndex( cursor.current );
			} 	
			if( returnValue == -1 ) {
				arrc.addItem(item);
			}else{
				if(modified){
					arrc.removeItemAt(returnValue);
					arrc.addItemAt(item, returnValue);
				}
			}
		}
		public static function removeArrcItem(item:Object,arrc:ArrayCollection, sortString:String):void{
			var returnValue:int = -1;
			var sort:Sort = new Sort(); 
			sort.fields = [ new SortField( sortString ) ];
			if(arrc.sort==null) arrc.sort = sort;
			arrc.refresh(); 
			var cursor:IViewCursor = arrc.createCursor();
			var found:Boolean = cursor.findAny( item );	
			if( found ) {
				returnValue = arrc.getItemIndex( cursor.current );
			} 	
			if( returnValue != -1 ) {
				arrc.removeItemAt(returnValue);
			}
		} 
	}
}