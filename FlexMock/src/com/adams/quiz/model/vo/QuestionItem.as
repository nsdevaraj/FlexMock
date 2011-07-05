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
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class QuestionItem extends AbstractVO
	{
		private var _questionitemId:int;
		
		private var _link:String;
		private var _feedback:String;
		private var _type:String;
		
		private var _choices:ArrayCollection  = new ArrayCollection();;
		private var _question:String;
		private var _choiceArr:Array;
		private var _chapter:int;
		private var _menu:int;
		public function QuestionItem()
		{
			super();
		}
		
		public function get choices():ArrayCollection
		{
			return _choices;
		}

		public function set choices(value:ArrayCollection):void
		{
			_choices = value;
		}

		public function get link():String
		{
			return _link;
		}
		
		public function set link(value:String):void
		{
			_link = value;
		}
		
		public function get feedback():String
		{
			return _feedback;
		}
		
		public function set feedback(value:String):void
		{
			_feedback = value;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
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
		
		public function get choiceArr():Array
		{
			return _choiceArr;
		}
		
		public function set choiceArr(value:Array):void
		{
			_choiceArr = value;
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
			question = item.question.value;
			link = item.question.link;
			feedback = item.question.feedback;
			type = item.question.type;
			choiceArr =[];
			for each(var obj:Object in item.answer as ArrayCollection){
				if(obj.hasOwnProperty('correct')){
					choiceArr.push(obj.value+ '     ');
					choices.addItem(obj.value+ '     ');
				}else{
					choices.addItem(obj+ '     ');
				}
			}
			menu = Utils.menuId;
			chapter = Utils.chapterId;
		}
	}
}