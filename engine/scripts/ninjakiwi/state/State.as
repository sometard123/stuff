package ninjakiwi.state
{
   import assets.towers.Bubbles1;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BuffMethodModuleSharedFunctions;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.SpikeSpread;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class State extends EventDispatcher
   {
      
      public static const ENTER:String = "enter state";
      
      public static const EXIT:String = "exit state";
      
      private static const VERBOSE:Boolean = Settings.VERBOSE_TRACE;
      
      private static const DEFAULT_BASE_NAME:String = "base state";
       
      
      protected var currentChild:State;
      
      protected var initialChild:State;
      
      protected var children:Array;
      
      protected var transitionsTo:Object;
      
      protected var baseState:State;
      
      public var name:String;
      
      public function State(param1:String = null)
      {
         this.children = [];
         this.transitionsTo = {};
         super();
         if(param1 != null)
         {
            this.name = param1;
         }
         else
         {
            this.name = DEFAULT_BASE_NAME;
         }
      }
      
      public final function setup(param1:State = null, param2:Array = null) : void
      {
         this.initialChild = param1;
         this.currentChild = param1;
         this.children = param2;
      }
      
      public final function setTransition(param1:String, param2:State) : void
      {
         this.transitionsTo[param1] = param2;
      }
      
      public final function isCurrently(param1:State) : Boolean
      {
         return param1.contains(this.getCurrent());
      }
      
      public final function contains(param1:State) : Boolean
      {
         if(this == param1)
         {
            return true;
         }
         if(this.getChildContaining(param1) != null)
         {
            return true;
         }
         return false;
      }
      
      public final function getCurrent() : State
      {
         if(this.currentChild != null)
         {
            return this.currentChild.getCurrent();
         }
         return this;
      }
      
      public final function receive(param1:String) : void
      {
         this.targetIfTriggered(param1);
      }
      
      public final function receiveEvent(param1:Event) : void
      {
         this.receive(param1.type);
      }
      
      public final function enter(param1:State = null) : void
      {
         this.enterActions();
         dispatchEvent(new Event(ENTER));
         if(param1 == null || param1 == this)
         {
            this.currentChild = this.initialChild;
            if(this.currentChild != null)
            {
               this.currentChild.enter();
            }
         }
         else
         {
            this.currentChild = this.getChildContaining(param1);
            this.currentChild.enter(param1);
         }
      }
      
      public final function exit() : void
      {
         if(this.currentChild != null)
         {
            this.currentChild.exit();
            this.currentChild = null;
         }
         this.exitActions();
         dispatchEvent(new Event(EXIT));
      }
      
      protected function enterActions() : void
      {
         var _loc1_:* = null;
         if(VERBOSE)
         {
            _loc1_ = this.getBaseName();
            if(_loc1_.length > 0)
            {
               _loc1_ = _loc1_ + " ";
            }
         }
      }
      
      protected function exitActions() : void
      {
      }
      
      protected function getBaseName() : String
      {
         if(this.baseState != null && this.baseState.name != DEFAULT_BASE_NAME)
         {
            return this.baseState.name;
         }
         return "";
      }
      
      protected function setBaseState(param1:State) : void
      {
         param1.baseState = this;
      }
      
      private function targetIfTriggered(param1:String) : State
      {
         var _loc2_:State = null;
         var _loc3_:State = null;
         if(this.currentChild != null)
         {
            _loc2_ = this.currentChild.targetIfTriggered(param1);
         }
         if(_loc2_ == null)
         {
            _loc2_ = this.transitionsTo[param1];
         }
         dispatchEvent(new Event(param1));
         if(_loc2_ == null)
         {
            return null;
         }
         _loc3_ = this.getChildContaining(_loc2_);
         if(_loc3_ != null)
         {
            if(this.currentChild != null)
            {
               this.currentChild.exit();
            }
            this.currentChild = _loc3_;
            _loc3_.enter(_loc2_);
            return null;
         }
         if(this.currentChild != null)
         {
            this.currentChild.exit();
            this.currentChild = null;
         }
         return _loc2_;
      }
      
      private function getChildContaining(param1:State) : State
      {
         var _loc2_:State = null;
         for each(_loc2_ in this.children)
         {
            if(_loc2_ == param1)
            {
               return _loc2_;
            }
            if(_loc2_.getChildContaining(param1) != null)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
