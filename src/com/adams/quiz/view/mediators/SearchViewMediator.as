/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  eStud

@internal 

*/
package com.adams.quiz.view.mediators
{ 
	import com.adams.quiz.model.AbstractDAO;
	import com.adams.quiz.model.vo.*;
	import com.adams.quiz.signal.ControlSignal;
	import com.adams.quiz.util.RandomSequence;
	import com.adams.quiz.util.Utils;
	import com.adams.quiz.view.SearchSkinView;
	import com.adams.swizdao.model.vo.*;
	import com.adams.swizdao.util.Action;
	import com.adams.swizdao.views.mediators.AbstractViewMediator;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	import spark.events.IndexChangeEvent;
	
	
	public class SearchViewMediator extends AbstractViewMediator
	{ 		 
		
		[Inject]
		public var currentInstance:CurrentInstance; 
		
		[Inject]
		public var controlSignal:ControlSignal;
		
		[Inject("chapterDAO")]
		public var chapterDAO:AbstractDAO;
		
		[Inject("menuDAO")]
		public var menuDAO:AbstractDAO;
		
		[Inject("questionitemDAO")]
		public var questionitemDAO:AbstractDAO;
		
		private var _homeState:String;
		public function get homeState():String
		{
			return _homeState;
		}
		
		public function set homeState(value:String):void
		{
			_homeState = value;
			if(value==Utils.SEARCH_INDEX) addEventListener(Event.ADDED_TO_STAGE,addedtoStage);
		}
		
		protected function addedtoStage(ev:Event):void{
			init();
		}
		
		/**
		 * Constructor.
		 */
		public function SearchViewMediator( viewType:Class=null )
		{
			super( SearchSkinView ); 
		}
		
		/**
		 * Since the AbstractViewMediator sets the view via Autowiring in Swiz,
		 * we need to create a local getter to access the underlying, expected view
		 * class type.
		 */
		public function get view():SearchSkinView 	{
			return _view as SearchSkinView;
		}
		
		[MediateView( "SearchSkinView" )]
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
			viewState = Utils.SEARCH_INDEX;
			controlSignal.headerStateSignal.dispatch(this,Utils.HEADER_LEARN_INDEX);
			selectChapterHandler();
		} 
		
		protected function selectQuestion( ev:IndexChangeEvent):void {
			var currentQuestion:QuestionItem = view.qitemsList.selectedItem as QuestionItem;
			ArrayCollection(currentInstance.mapConfig.randomList).removeItemAt(0);
			ArrayCollection(currentInstance.mapConfig.randomList).addItemAt(currentQuestion,0);
			controlSignal.changeStateSignal.dispatch(Utils.LEARN_INDEX);
		}
		
		
		protected function selectChapterHandler(event:IndexChangeEvent = null):void {
			var currentChapter:Chapter = currentInstance.mapConfig.currentChapter 
			var getQues:QuestionItem = new QuestionItem();
			getQues.chapter = currentChapter.chapterId;
			var currentQuestion:QuestionItem = questionitemDAO.collection.findExistingPropItem(getQues,Utils.CHAPTER_INDEX.toLowerCase()) as QuestionItem;
			if(!currentQuestion){
				Utils.chapterId = currentChapter.chapterId;
				Utils.menuId = currentChapter.menu.menuId;
				controlSignal.loadXMLSignal.dispatch(this);
			}else{
				getRandomListOfQuestions(currentChapter.questionsList);
			}
		}  
		
		override protected function serviceResultHandler( obj:Object,signal:SignalVO ):void {  
			if(signal.action == Action.HTTP_REQUEST && signal.destination == Utils.QUESTIONITEMKEY){
				signal.currentProcessedCollection = new ArrayCollection();
				for each(var qitem:QuestionItem in questionitemDAO.collection.items){
					if(qitem.chapter == Utils.chapterId) signal.currentProcessedCollection.addItem(qitem);
				}
				getRandomListOfQuestions(signal.currentProcessedCollection);
			}
		}
		
		protected function getRandomListOfQuestions(collection:IList):void{
			view.qitemsList.dataProvider = collection;
			currentInstance.mapConfig.randomList = new ArrayCollection();
			var rs:RandomSequence=new RandomSequence(0,collection.length-1);
			var _array:Array=rs.getSequence();
			var maxLength:int;
			Utils.QLENGTH > collection.length ?maxLength=collection.length :maxLength=Utils.QLENGTH;
			for(var i:int=0; i<maxLength; i++){
				ArrayCollection(currentInstance.mapConfig.randomList).addItem(collection.getItemAt(_array[i]));
			} 
		}
		/**
		 * Create listeners for all of the view's children that dispatch events
		 * that we want to handle in this mediator.
		 */
		override protected function setViewListeners():void {
			view.qitemsList.addEventListener(IndexChangeEvent.CHANGE,selectQuestion);
			super.setViewListeners(); 
		}
		
		/**
		 * Remove any listeners we've created.
		 */
		override protected function cleanup( event:Event ):void {
			super.cleanup( event ); 		
		} 
	}
}