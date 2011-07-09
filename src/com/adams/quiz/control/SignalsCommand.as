/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  QuizMaster

@internal 

*/
package com.adams.quiz.control
{
	import com.adams.quiz.model.AbstractDAO;
	import com.adams.quiz.model.vo.*;
	import com.adams.quiz.signal.ControlSignal;
	import com.adams.quiz.util.Utils;
	import com.adams.quiz.view.mediators.MainViewMediator;
	import com.adams.swizdao.model.vo.CurrentInstance;
	import com.adams.swizdao.model.vo.SignalVO;
	import com.adams.swizdao.response.SignalSequence;
	import com.adams.swizdao.util.Action;
	import com.adams.swizdao.views.mediators.IViewMediator;
	
	import flash.geom.Rectangle;
	
	public class SignalsCommand
	{
		
		[Inject]
		public var controlSignal:ControlSignal;
		
		[Inject]
		public var mainViewMediator:MainViewMediator;
		
		[Inject]
		public var currentInstance:CurrentInstance; 
		
		[Inject]
		public var signalSequence:SignalSequence;
		
		[Inject("questionitemDAO")]
		public var questionitemDAO:AbstractDAO;
		
		[Inject("menuDAO")]
		public var menuDAO:AbstractDAO;
		
		// todo: add listener
		/**
		 * Whenever an HeaderStateSignal is dispatched.
		 * MediateSignal initates this headerstateAction to perform control Actions
		 * The invoke functions to perform control functions
		 */
		[ControlSignal(type='headerStateSignal')]
		public function headerstateAction(obj:IViewMediator,state:String):void {
			switch(state){
				case Utils.HEADER_MENU_INDEX:
					mainViewMediator.view.header.view.logo.visible=false;
					mainViewMediator.view.header.view.btns.visible=true;
					mainViewMediator.view.header.view.chapterBtn.visible=false;
					mainViewMediator.view.header.view.topicBtn.visible=false;
					break;
				case Utils.HEADER_LOGO_INDEX:
					mainViewMediator.view.header.view.logo.visible=true;
					mainViewMediator.view.header.view.btns.visible=false;
					break;
				case Utils.HEADER_CHAPTER_INDEX:
					mainViewMediator.view.header.view.logo.visible=false;
					mainViewMediator.view.header.view.btns.visible=true;
					mainViewMediator.view.header.view.chapterBtn.visible=false;
					mainViewMediator.view.header.view.topicBtn.visible=false;
					mainViewMediator.view.header.view.learnBtn.visible=false;
					break;
				case Utils.HEADER_TOPIC_INDEX:
					mainViewMediator.view.header.view.logo.visible=false;
					mainViewMediator.view.header.view.btns.visible=true;
					mainViewMediator.view.header.view.chapterBtn.visible=true;
					mainViewMediator.view.header.view.topicBtn.visible=true;
					mainViewMediator.view.header.view.learnBtn.visible=false;
					break;
				case Utils.HEADER_LEARN_INDEX:
					mainViewMediator.view.header.view.logo.visible=false;
					mainViewMediator.view.header.view.btns.visible=true;
					mainViewMediator.view.header.view.chapterBtn.visible=true;
					mainViewMediator.view.header.view.topicBtn.visible=false;
					mainViewMediator.view.header.view.learnBtn.visible=true;
					break;
				default:
					break;
			} 
			if(Chapter(currentInstance.mapConfig.currentChapter)){
				mainViewMediator.view.header.view.chapterBtn.label = Chapter(currentInstance.mapConfig.currentChapter).chapterLabel;
			}else{
				mainViewMediator.view.header.view.chapterBtn.label = 'Chapter';
			}
		}
		
		/**
		 * Whenever an LoadMenuSignal is dispatched.
		 * MediateSignal initates this loadmenuAction to perform control Actions
		 * The invoke functions to perform control functions
		 */
		[ControlSignal(type='loadMenuSignal')]
		public function loadmenuAction(obj:IViewMediator):void {
			var signal:SignalVO = new SignalVO(obj,menuDAO,Action.HTTP_REQUEST);
			signal.emailBody = currentInstance.config.serverLocation+Utils.LAUNCHXML+Utils.XML;
			signal.receivers = ['menu'];
			signalSequence.addSignal(signal);
		}
		
		/**
		 * Whenever an LoadXMLSignal is dispatched.
		 * MediateSignal initates this loadxmlAction to perform control Actions
		 * The invoke functions to perform control functions
		 */
		[ControlSignal(type='loadXMLSignal')]
		public function loadxmlAction(obj:IViewMediator):void {
			var signal:SignalVO = new SignalVO(obj,questionitemDAO,Action.HTTP_REQUEST);
			var currentChapter:Chapter = currentInstance.mapConfig.currentChapter as Chapter;
			var currentMenu:Menu = currentChapter.menu;
			signal.emailBody = currentInstance.config.serverLocation+ currentChapter.chapterXML+Utils.XML;
			signal.receivers = ['item','topics'];
			signalSequence.addSignal(signal);
		}
		
		/**
		 * Whenever an ChangeStateSignal is dispatched.
		 * MediateSignal initates this changestateAction to perform control Actions
		 * The invoke functions to perform control functions
		 */
		[ControlSignal(type='changeStateSignal')]
		public function changestateAction(state:String):void {
			if(mainViewMediator.view.web)mainViewMediator.view.web.webView.viewPort = new Rectangle( 0, 0, 0, 0);
			mainViewMediator.view.currentState = state;
		}
	}
}