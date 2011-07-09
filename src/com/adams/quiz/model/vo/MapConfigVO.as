/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  QuizMaster

@internal 

*/
package com.adams.quiz.model.vo
{ 
	import mx.collections.ArrayCollection;

	[Bindable]
	public class MapConfigVO 
	{
		 public var randomList:ArrayCollection;
		 public var currentChapter:Chapter;
		 public var currentMenu:Menu;
		 public var currentTopic:String;
	}
}