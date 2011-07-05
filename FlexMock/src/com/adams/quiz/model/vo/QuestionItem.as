/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  QuizMaster

@internal 

*/
package com.adams.quiz.model.vo
{
	import com.adams.quiz.util.Utils;
	import com.adams.swizdao.model.vo.AbstractVO;

	[Bindable]
	public class QuestionItem extends AbstractVO
	{
		private var _questionitemId:int; 
		private var _question:String;
		private var _choice:String;
		private var _chapter:int;
		private var _menu:int;
		public function QuestionItem()
		{
			super();
		}

		public function get menu():int
		{
			return _menu;
		}

		public function set menu(value:int):void
		{
			_menu = value;
		}

		public function get chapter():int
		{
			return _chapter;
		}

		public function set chapter(value:int):void
		{
			_chapter = value;
		}

		public function get question():String
		{
			return _question;
		}

		public function set question(value:String):void
		{
			_question = value;
		}

		public function get choice():String
		{
			return _choice;
		}

		public function set choice(value:String):void
		{
			_choice = value;
		}

		public function get questionitemId():int
		{
			return _questionitemId;
		}

		public function set questionitemId(value:int):void
		{
			_questionitemId = value;
		}
		override public function fill(item:Object):void{
			question = item.Question;
			choice=item.Choice;
			menu = Utils.menuId;
			chapter = Utils.chapterId;
		}
	}
}