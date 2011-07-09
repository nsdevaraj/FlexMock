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
	[RemoteClass(alias='com.adams.quiz.dao.entities.Chapter')]
	public class Chapter extends AbstractVO
	{
		private var _chapterId:int;
		private var _chapterLabel:String;
		private var _chapterXML:String;
		private var _menu:Menu;
		private var _questionsList:ArrayCollection = new ArrayCollection();
		public function Chapter()
		{
			super();
		}

		public function get menu():Menu
		{
			return _menu;
		}

		public function set menu(value:Menu):void
		{
			_menu = value;
		}

		public function get questionsList():ArrayCollection
		{
			return _questionsList;
		}

		public function set questionsList(value:ArrayCollection):void
		{
			_questionsList = value;
		}

		public function get chapterXML():String
		{
			return _chapterXML;
		}

		public function set chapterXML(value:String):void
		{
			_chapterXML = value;
		}

		public function get chapterLabel():String
		{
			return _chapterLabel;
		}

		public function set chapterLabel(value:String):void
		{
			_chapterLabel = value;
		}

		public function get chapterId():int
		{
			return _chapterId;
		}

		public function set chapterId(value:int):void
		{
			_chapterId = value;
		}

	}
}