/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  QuizMaster

@internal 

*/
package com.adams.quiz.util
{
	import com.adams.quiz.model.AbstractDAO;
	import com.adams.swizdao.controller.ServiceController;
	import com.adams.swizdao.model.vo.CurrentInstance;
	import com.adams.swizdao.model.vo.IValueObject;
	import com.adams.swizdao.model.vo.PushMessage;
	import com.adams.swizdao.model.vo.SignalVO;
	import com.adams.swizdao.response.SignalSequence;
	import com.adams.swizdao.util.Action;
	import com.adams.swizdao.util.Description;
	import com.adams.swizdao.util.GetVOUtil;
	
	import flash.utils.Dictionary;
	
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.AsyncMessage;
	
	import org.swizframework.core.IBeanFactory;
	import org.swizframework.core.IBeanFactoryAware;
	import com.adams.swizdao.service.NativeConsumer;
	import com.adams.swizdao.service.NativeProducer;
	
	public class NativeMessenger implements IBeanFactoryAware
	{
		public var produce:NativeProducer;
		public var consume:NativeConsumer;
		public var dynamicDAO:AbstractDAO;
		
		[Inject]
		public var currentInstance:CurrentInstance;
		
		[Inject]
		public var signalSeq:SignalSequence;
		
		protected var _controlService:ServiceController;  
		public function get controlService():ServiceController {
			return _controlService;
		}
		
		[Inject]
		public function set controlService( ro:ServiceController ):void {
			_controlService = ro; 
			produce = _controlService.producer;
			consume = _controlService.consumer;
		}
		
		private var _beanFactory:IBeanFactory;
		public function set beanFactory( beanFactory:IBeanFactory ):void {
			_beanFactory = beanFactory;
		}
			
		public function NativeMessenger()
		{
		}
		
		[PostConstruct]
		public function subscribeMessage():void { 
			consume.consumeAttempt.add( consumeHandler );
		}
		
		private var sentMsgArr:Dictionary=new Dictionary();
		public function produceMessage( signal:SignalVO ):void {
			var message:AsyncMessage = new AsyncMessage();
			message.headers = [];
			message.headers[ "destination" ] = signal.destination; 
			message.headers[ "name" ] = signal.name;
			message.headers[ "recepient" ] = signal.receivers;
		 	message.headers[ "dynamicdao" ] = signal.daoName;
			message.body = signal.description;
			produce.produceAttempt.add( onAckReceived ); 
			produce.produceMessage( message ); 
		} 
		
		protected function onAckReceived( event:MessageEvent = null ):void {
			signalSeq.onSignalDone();
		}
		
		private var avoidSignal:Boolean;
		protected function consumeHandler( event:MessageEvent = null ):void {
			 
		}
	}
}