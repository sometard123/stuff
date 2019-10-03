package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart
{
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.entities.AceAircraft;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class DeployMonkeyAce extends BehaviorRoundStart
   {
      
      public static var aces:Dictionary = new Dictionary();
       
      
      private var display_:Class = null;
      
      public function DeployMonkeyAce()
      {
         super();
      }
      
      public function set display(param1:Class) : void
      {
         if(this.display_ != param1)
         {
            this.display_ = param1;
            dispatchEvent(new PropertyModEvent("display"));
         }
      }
      
      public function get display() : Class
      {
         return this.display_;
      }
      
      public function Display(param1:Class) : DeployMonkeyAce
      {
         this.display = param1;
         return this;
      }
      
      override public function execute(param1:Tower) : void
      {
         var _loc2_:AceAircraft = null;
         if(aces[param1] == null)
         {
            aces[param1] = new AceAircraft();
            aces[param1].Initialise(param1,this.display,param1.def);
            param1.level.addEntity(aces[param1]);
         }
         else if(aces[param1].def != param1.def)
         {
            _loc2_ = aces[param1];
            aces[param1].destroy();
            aces[param1] = new AceAircraft();
            aces[param1].Initialise(param1,this.display,param1.def);
            param1.level.addEntity(aces[param1]);
            aces[param1].copy(_loc2_);
         }
         aces[param1].takeoff();
      }
   }
}
