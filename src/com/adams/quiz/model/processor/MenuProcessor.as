/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  eStud

@internal 

*/
package com.adams.quiz.model.processor
{
	import com.adams.quiz.model.AbstractDAO;
	import com.adams.quiz.model.vo.Chapter;
	import com.adams.quiz.model.vo.Menu;
	import com.adams.swizdao.model.processor.AbstractProcessor;
	import com.adams.swizdao.model.vo.IValueObject;

	public class MenuProcessor extends AbstractProcessor
	{   
		
		[Inject("chapterDAO")]
		public var chapterDAO:AbstractDAO;
		
		override public function processVO(vo:IValueObject):void
		{
			if(!vo.processed){
				var menuvo:Menu = vo as Menu;
				for each (var chapter:Chapter in menuvo.chapters){
					chapterDAO.collection.addItem(chapter);
				}
				super.processVO(vo);
			}
		}
	}
}