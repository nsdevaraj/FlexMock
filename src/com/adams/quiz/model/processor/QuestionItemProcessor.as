/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  QuizMaster

@internal 

*/
package com.adams.quiz.model.processor
{
	import com.adams.quiz.model.AbstractDAO;
	import com.adams.quiz.model.vo.Chapter;
	import com.adams.quiz.model.vo.QuestionItem;
	import com.adams.swizdao.model.processor.AbstractProcessor;
	import com.adams.swizdao.model.vo.IValueObject;
	import com.adams.swizdao.util.GetVOUtil;

	public class QuestionItemProcessor extends AbstractProcessor
	{   
		[Inject("chapterDAO")]
		public var chapterDAO:AbstractDAO;
		
		override public function processVO(vo:IValueObject):void
		{
			if(!vo.processed){
				var questionitemvo:QuestionItem = vo as QuestionItem;
				var parentChapter:Chapter = GetVOUtil.getVOObject( questionitemvo.chapter, chapterDAO.collection.items, chapterDAO.destination, Chapter ) as Chapter;
				parentChapter.questionsList.addItem(questionitemvo);
				super.processVO(vo);
			}
		}
	}
}