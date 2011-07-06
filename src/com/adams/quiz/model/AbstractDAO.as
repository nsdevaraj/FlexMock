/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  QuizMaster

@internal 

*/
package com.adams.quiz.model
{
	import com.adams.quiz.util.NativeMessenger;
	import com.adams.swizdao.controller.ServiceController;
	import com.adams.swizdao.dao.CRUDObject;
	import com.adams.swizdao.dao.IAbstractDAO;
	import com.adams.swizdao.model.processor.IVOProcessor;
	import com.adams.swizdao.model.vo.ConfigVO;
	import com.adams.swizdao.model.vo.IValueObject;
	import com.adams.swizdao.model.vo.SignalVO;
	import com.adams.swizdao.response.SignalSequence;
	import com.adams.swizdao.signals.PushRefreshSignal;
	import com.adams.swizdao.util.Action;
	import com.adams.swizdao.util.Description;
	import com.adams.swizdao.util.GetVOUtil;
	
	import mx.collections.ArrayCollection;
	
	public class AbstractDAO extends CRUDObject implements IAbstractDAO
	{   
		[Inject]
		public var pushRefreshSignal:PushRefreshSignal;
		
		[Inject]
		public var messenger:NativeMessenger; 
		
		[Inject]
		public var signalSeq:SignalSequence;
		
		private var _daoName:String;
		/**
		 * Whenever an AbstractSignal is dispatched.
		 * This DAO is responsible for performing the Server Request initiation.
		 * if(obj.destination == this.destination) makes sure the DAO Object required 
		 * <p>
		 * Constructor, AbstractDAO, extended from CRUDObject.
		 * </p>
 		 */
		public function AbstractDAO( destn:String, clz:Class, process:IVOProcessor =null ,name:String='')
		{
			destination = destn;
			processor = process;
			voClazz = clz;
			daoName = name;
		} 		
		public function get daoName():String
		{
			return _daoName;
		}
		
		public function set daoName(value:String):void
		{
			_daoName = value;
		}
		
		protected var _controlService:ServiceController;  
		public function get controlService():ServiceController  {
			return _controlService;
		}
		[Inject]
		public function set controlService( ro:ServiceController ):void {
			_controlService = ro; 
			remoteService = _controlService.authRo;
		}
		
		/**
		 * Whenever an AbstractSignal is dispatched.
		 * MediateSignal initates this invokeAction to perform Generic Actions
		 * <p>
		 * The invoke functions to perform generic dao functions
		 * </p>
 		 */
		[MediateSignal(type="AbstractSignal")]
		public function invokeAction( obj:SignalVO ):void {
			if( obj.destination == this.destination ) {
				switch( obj.action ) {
					case Action.HTTP_REQUEST:
						makeHTTPCall( obj.emailBody );
						break;
					case Action.CREATE:
						create( obj.valueObject );
					break;
					case Action.UPDATE:
						update( obj.valueObject );
					break;
					case Action.READ:
						read( obj.id );
					break;
					case Action.FINDBY_NAME: 
						findByName( obj.name );
					break;
					case Action.FIND_ID:
						// call if not already called
						collection.findByIdArr.push( obj.id );
						findById( obj.id );
					break; 
					case Action.FINDBY_ID: 
						findId( obj.id );
					break; 
					case Action.DELETE:
						deleteById( obj.valueObject );
					break;
					case Action.GET_COUNT:
						count();
					break;
					case Action.GET_LIST:
						// call if not already called
						collection.findAll = true;
						getList();
					break;
					case Action.SQL_FINDALL: 
						getSQLList();
						break;
					case Action.BULK_UPDATE:
						bulkUpdate( obj.list );
					break;
					case Action.DELETE_ALL:
						deleteAll();
					break;
					case Action.PUSH_MSG:
						messenger.produceMessage( obj );
					break;
					case Action.RECEIVE_MSG:
						switch( obj.name ) {
							case Description.CREATE: 
							case Description.UPDATE: 
								obj.action = Action.FINDPUSH_ID;
								findId( obj.description as int );
							break;
							case Description.DELETE: 
								var deletedId:int =obj.description as int;
								ArrayCollection( collection.items ).refresh();
								var valueObject:IValueObject;
								if(collection.findItem(deletedId)){
									valueObject = GetVOUtil.getVOObject( deletedId,collection.items, this.destination, voClazz );
									collection.removeItem( valueObject );
								}
								obj.performed =true;
								pushRefreshSignal.dispatch( obj );
							break;
							default:
							break;
						}
					break;	
					default:
						messenger.currentInstance.serverLastAccessedAt = new Date();  
					break;	
				}
			}
		}  
	}
}