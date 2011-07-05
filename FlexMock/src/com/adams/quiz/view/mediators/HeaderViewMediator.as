/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  eStud

@internal 

*/
package com.adams.quiz.view.mediators
{ 
	import com.adams.quiz.model.vo.*;
	import com.adams.quiz.signal.ControlSignal;
	import com.adams.quiz.util.Utils;
	import com.adams.quiz.view.HeaderSkinView;
	import com.adams.swizdao.model.vo.*;
	import com.adams.swizdao.views.mediators.AbstractViewMediator;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class HeaderViewMediator extends AbstractViewMediator
	{ 		 
		
		[Inject]
		public var currentInstance:CurrentInstance; 
		
		[Inject]
		public var mainViewMediator:MainViewMediator;
		
		[Inject]
		public var controlSignal:ControlSignal;
		
		private var _homeState:String;
		public function get homeState():String
		{
			return _homeState;
		}
		
		public function set homeState(value:String):void
		{
			_homeState = value;
			if(value==Utils.HEADER_INDEX) addEventListener(Event.ADDED_TO_STAGE,addedtoStage);
		}
		
		protected function addedtoStage(ev:Event):void{
			init();
		}
		
		/**
		 * Constructor.
		 */
		public function HeaderViewMediator( viewType:Class=null )
		{
			super( HeaderSkinView ); 
		}
		
		/**
		 * Since the AbstractViewMediator sets the view via Autowiring in Swiz,
		 * we need to create a local getter to access the underlying, expected view
		 * class type.
		 */
		public function get view():HeaderSkinView 	{
			return _view as HeaderSkinView;
		}
		
		[MediateView( "HeaderSkinView" )]
		override public function setView( value:Object ):void { 
			super.setView(value);	
		}  
		/**
		 * The <code>init()</code> method is fired off automatically by the 
		 * AbstractViewMediator when the creation complete event fires for the
		 * corresponding ViewMediator's view. This allows us to listen for events
		 * and set data bindings on the view with the confidence that our view
		 * and all of it's child views have been created and live on the stage.
		 */
		override protected function init():void {
			super.init();  
			viewState = Utils.HEADER_INDEX; 
			view.chapterBtn.addEventListener(MouseEvent.CLICK,chapterHandler,false,0,true);
			view.topicBtn.addEventListener(MouseEvent.CLICK,topicHandler,false,0,true);
			view.learnBtn.addEventListener(MouseEvent.CLICK,learnHandler,false,0,true);
		}  
		
		protected function chapterHandler(ev:MouseEvent):void {
			controlSignal.changeStateSignal.dispatch(Utils.HOME_INDEX);
		} 
		
		protected function topicHandler(ev:MouseEvent):void {
			controlSignal.changeStateSignal.dispatch(Utils.SEARCH_INDEX);
		}				
		
		protected function learnHandler(ev:MouseEvent):void {
			controlSignal.changeStateSignal.dispatch(Utils.LEARN_INDEX);
		} 
		
		/**
		 * Remove any listeners we've created.
		 */
		override protected function cleanup( event:Event ):void {
			super.cleanup( event ); 		
		} 
	}
}