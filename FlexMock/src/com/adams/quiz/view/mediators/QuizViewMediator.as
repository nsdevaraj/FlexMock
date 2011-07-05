/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  eStud

@internal 

*/
package com.adams.quiz.view.mediators
{ 
	import assets.skins.IChoiceSkin;
	
	import com.adams.quiz.model.AbstractDAO;
	import com.adams.quiz.model.vo.*;
	import com.adams.quiz.signal.ControlSignal;
	import com.adams.quiz.util.RandomSequence;
	import com.adams.quiz.util.Utils;
	import com.adams.quiz.view.QuizSkinView;
	import com.adams.quiz.view.components.QChoice;
	import com.adams.swizdao.model.vo.*;
	import com.adams.swizdao.views.mediators.AbstractViewMediator;
	
	import flash.events.Event;
	import flash.events.TransformGestureEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	
	public class QuizViewMediator extends AbstractViewMediator
	{ 		 
		
		[Inject]
		public var currentInstance:CurrentInstance; 
		
		[Inject]
		public var controlSignal:ControlSignal;
		
		private var randomList:ArrayCollection = new ArrayCollection();
		private var currentQuestion:QuestionItem;
		private var currentPosition:int;
		private var oldPosition:int;
		private var oldSkin:IChoiceSkin;
		private var maxPosition:int;
		private var _homeState:String;
		
		[Inject("chapterDAO")]
		public var chapterDAO:AbstractDAO;
		public function get homeState():String
		{
			return _homeState;
		}
		
		public function set homeState(value:String):void
		{
			_homeState = value;
			if(value==Utils.QUIZ_INDEX) addEventListener(Event.ADDED_TO_STAGE,addedtoStage);
		}
		
		protected function addedtoStage(ev:Event):void{
			init();
		}
		
		/**
		 * Constructor.
		 */
		public function QuizViewMediator( viewType:Class=null )
		{
			super( QuizSkinView ); 
		}
		
		/**
		 * Since the AbstractViewMediator sets the view via Autowiring in Swiz,
		 * we need to create a local getter to access the underlying, expected view
		 * class type.
		 */
		public function get view():QuizSkinView 	{
			return _view as QuizSkinView;
		}
		
		[MediateView( "QuizSkinView" )]
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
			viewState = Utils.QUIZ_INDEX;
			var rs:RandomSequence=new RandomSequence(0,currentInstance.mapConfig.randomList.length-1);
			var _array:Array=rs.getSequence();
			randomList = new ArrayCollection();
			for(var i:int=0;i<_array.length;i++){
				randomList.addItem(currentInstance.mapConfig.randomList.getItemAt(_array[i]));				
			}
			currentPosition = 0;
			maxPosition = randomList.length;
			view.navigate.maximum= maxPosition+1;
			view.maxQs.text = "of "+maxPosition;
			view.navigate.incrementButton.visible =false;
			view.navigate.decrementButton.visible =false;
			gotoQuestion(currentPosition);
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			for each (var item:String in Multitouch.supportedGestures)
			{
				if (item == TransformGestureEvent.GESTURE_SWIPE){
					view.addEventListener(TransformGestureEvent.GESTURE_SWIPE,handleSwipe);
				}
			}
		}
		
		private function handleSwipe(event:TransformGestureEvent):void
		{
			// Swipe was to the right
			if (event.offsetX == 1 ) {
				currentPosition++;
				gotoQuestion(currentPosition);
			}
			else if (event.offsetX == -1 ) {
				currentPosition--;
				gotoQuestion(currentPosition);
			}
		}
		
		protected function gotoQuestion(pos:int):QuestionItem {
			if(pos>=0 && pos<maxPosition){
				currentPosition = pos;
				currentQuestion = randomList.getItemAt(currentPosition) as QuestionItem;
				hideAllChoices();
				setAllChoices();
				oldPosition = currentPosition;
			}else{
				currentPosition = oldPosition;
			}
			view.navigate.value = (currentPosition+1);
			view.question.text = currentQuestion.question;
			return currentQuestion;
		}  
		
		protected function hideAllChoices():void { 
			for(var i:int=0;i<4;i++){
				var qRadio:QChoice = view[Utils.CHOICE+int(i+1)];
				qRadio.selected = false;
				qRadio.visible =false;
				qRadio.correctAnswer =false;
			}
		}	
		
		protected function setAllChoices():void { 
			for(var i:int=0;i<currentQuestion.choices.length;i++){
				var qRadio:QChoice = view[Utils.CHOICE+int(i+1)];
				var choice:String = String(currentQuestion.choices.getItemAt(i));
				(currentQuestion.choiceArr.indexOf(choice)== -1) ? qRadio.correctAnswer=false : qRadio.correctAnswer=true;
				qRadio.label = choice;
				qRadio.visible =true;
				qRadio.selected = false;
			}
		}  
		
		/**
		 * Create listeners for all of the view's children that dispatch events
		 * that we want to handle in this mediator.
		 */
		override protected function setViewListeners():void {
			view.back.clicked.add(viewClickHandlers);
			view.docs.clicked.add(viewClickHandlers);
			view.next.clicked.add(viewClickHandlers);
			view.learn.clicked.add(viewClickHandlers);
			view.choice1.clicked.add(onSelection);
			view.choice2.clicked.add(onSelection);
			view.choice3.clicked.add(onSelection);
			view.choice4.clicked.add(onSelection);
			view.navigate.addEventListener(Event.CHANGE,viewClickHandlers,false,0,true);
			super.setViewListeners(); 
		}
		
		protected function resetFeedback():void{
			view.feedback.text =''
			if(oldSkin) oldSkin.correctFeedback.visible = false;
		}
		
		protected function onSelection( ev:Event ): void { 
			var currentRadio:QChoice = ev.currentTarget as QChoice
			var currentSkin:IChoiceSkin = Object(currentRadio).skin as IChoiceSkin;
			resetFeedback();
			if(currentRadio.correctAnswer){
				currentSkin.correctFeedback.visible =true;
			} else{
				view.feedback.text = currentQuestion.feedback;
			}
			oldSkin = currentSkin;
		}
		
		protected function viewClickHandlers( ev:Event ): void { 
			resetFeedback();
			switch(ev.currentTarget){
				case view.docs:
					controlSignal.changeStateSignal.dispatch(Utils.WEB_INDEX);
					break;   
				case view.back:
					currentPosition--;
					gotoQuestion(currentPosition);
					break;
				case view.next:
					currentPosition++;
					gotoQuestion(currentPosition);
					break;
				case view.learn:
					controlSignal.changeStateSignal.dispatch(Utils.LEARN_INDEX);
					break;
				case view.navigate:
				case view.navigate.textDisplay:
					currentPosition = (view.navigate.value)-1;
					gotoQuestion(currentPosition);
					break;
			}
		} 
		/**
		 * Remove any listeners we've created.
		 */
		override protected function cleanup( event:Event ):void {
			super.cleanup( event ); 		
		} 
	}
}