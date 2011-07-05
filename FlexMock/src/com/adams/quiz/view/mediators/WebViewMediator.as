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
	import com.adams.quiz.view.WebSkinView;
	import com.adams.swizdao.model.vo.*;
	import com.adams.swizdao.views.mediators.AbstractViewMediator;
	
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	

	public class WebViewMediator extends AbstractViewMediator
	{ 		 
		
		[Inject]
		public var currentInstance:CurrentInstance; 
		
		[Inject]
		public var controlSignal:ControlSignal;
		
		public var webView:StageWebView = new StageWebView();
		private var _homeState:String;
		public function get homeState():String
		{
			return _homeState;
		}
		
		public function set homeState(value:String):void
		{
			_homeState = value;
			if(value==Utils.WEB_INDEX) addEventListener(Event.ADDED_TO_STAGE,addedtoStage);
		}
		
		protected function addedtoStage(ev:Event):void{
			init();
		}
		     
		/**
		 * Constructor.
		 */
		public function WebViewMediator( viewType:Class=null )
		{
			super( WebSkinView ); 
		}

		/**
		 * Since the AbstractViewMediator sets the view via Autowiring in Swiz,
		 * we need to create a local getter to access the underlying, expected view
		 * class type.
		 */
		public function get view():WebSkinView 	{
			return _view as WebSkinView;
		}
		
		[MediateView( "WebSkinView" )]
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
			viewState = Utils.WEB_INDEX;
			webView.stage = this.stage;
			webView.addEventListener(LocationChangeEvent.LOCATION_CHANGE,getUpdate);
			setWebURL();
		} 
		
		public function getUpdate(event:LocationChangeEvent):void
		{
			//trace("The location changed."+webView.location);
		} 
		
		protected function setWebURL():void {	
			webView.viewPort = new Rectangle( 0, 50, stage.stageWidth, stage.stageHeight-50);
			webView.loadURL("http://www.google.com/m/search?q="+currentInstance.mapConfig.currentTopic);
		}
   
		/**
		 * Remove any listeners we've created.
		 */
		override protected function cleanup( event:Event ):void {
			super.cleanup( event ); 		
		} 
	}
}