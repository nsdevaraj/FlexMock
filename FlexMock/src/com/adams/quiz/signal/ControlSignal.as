/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  QuizMaster

@internal 

*/
package com.adams.quiz.signal
{
	import com.adams.quiz.model.vo.*;
	import com.adams.swizdao.views.mediators.IViewMediator;
	
	import org.osflash.signals.Signal;
	public class ControlSignal
	{
		// add Signal 
        public var headerStateSignal:Signal= new Signal(IViewMediator,String);
		public var loadMenuSignal:Signal= new Signal(IViewMediator);
		public var loadXMLSignal:Signal= new Signal(IViewMediator);
		public var changeStateSignal:Signal= new Signal(String);
	}
}