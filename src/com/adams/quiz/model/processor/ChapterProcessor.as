/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  eStud

@internal 

*/
package com.adams.quiz.model.processor
{
	import com.adams.quiz.model.vo.Chapter;
	import com.adams.swizdao.model.processor.AbstractProcessor;
	import com.adams.swizdao.model.vo.IValueObject;

	public class ChapterProcessor extends AbstractProcessor
	{    
		override public function processVO(vo:IValueObject):void
		{
			if(!vo.processed){
				var chaptervo:Chapter = vo as Chapter;
				super.processVO(vo);
			}
		}
	}
}