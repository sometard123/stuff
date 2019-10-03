package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.towers.CostRoundUtil;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class UpgradeDef extends EventDispatcher
   {
      
      public static var thumb_baseof:Class = MovieClip;
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var id_:String = null;
      
      private var label_:String = null;
      
      private var description_:String = null;
      
      private var cost_:INumber;
      
      private var add_:AddDef = null;
      
      private var assign_:TowerDef = null;
      
      private var thumb_:Class = null;
      
      private var xpGate_:int = 0;
      
      private var rankGate_:int = 0;
      
      public function UpgradeDef()
      {
         this.cost_ = DancingShadows.getOne();
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("id","label","description","cost","add","assign","thumb","xpGate","rankGate");
         }
         return displayOrder;
      }
      
      public function set id(param1:String) : void
      {
         if(this.id_ != param1)
         {
            this.id_ = param1;
            dispatchEvent(new PropertyModEvent("id"));
         }
      }
      
      public function get id() : String
      {
         return this.id_;
      }
      
      public function Id(param1:String) : UpgradeDef
      {
         this.id = param1;
         return this;
      }
      
      public function set label(param1:String) : void
      {
         if(this.label_ != param1)
         {
            this.label_ = param1;
            dispatchEvent(new PropertyModEvent("label"));
         }
      }
      
      public function get label() : String
      {
         return this.label_;
      }
      
      public function Label(param1:String) : UpgradeDef
      {
         this.label = param1;
         return this;
      }
      
      public function set description(param1:String) : void
      {
         if(this.description_ != param1)
         {
            this.description_ = param1;
            dispatchEvent(new PropertyModEvent("description"));
         }
      }
      
      public function get description() : String
      {
         return this.description_;
      }
      
      public function Description(param1:String) : UpgradeDef
      {
         this.description = param1;
         return this;
      }
      
      public function set cost(param1:int) : void
      {
         if(this.cost_.value != CostRoundUtil.getRoundedCost(param1))
         {
            this.cost_.value = CostRoundUtil.getRoundedCost(param1);
            dispatchEvent(new PropertyModEvent("cost"));
         }
      }
      
      public function get cost() : int
      {
         return this.cost_.value;
      }
      
      public function Cost(param1:int) : UpgradeDef
      {
         this.cost = param1;
         return this;
      }
      
      public function set add(param1:AddDef) : void
      {
         if(this.add_ != param1)
         {
            this.add_ = param1;
            dispatchEvent(new PropertyModEvent("add"));
         }
      }
      
      public function get add() : AddDef
      {
         return this.add_;
      }
      
      public function Add(param1:AddDef) : UpgradeDef
      {
         this.add = param1;
         return this;
      }
      
      public function set assign(param1:TowerDef) : void
      {
         if(this.assign_ != param1)
         {
            this.assign_ = param1;
            dispatchEvent(new PropertyModEvent("assign"));
         }
      }
      
      public function get assign() : TowerDef
      {
         return this.assign_;
      }
      
      public function Assign(param1:TowerDef) : UpgradeDef
      {
         this.assign = param1;
         return this;
      }
      
      public function set thumb(param1:Class) : void
      {
         if(this.thumb_ != param1)
         {
            this.thumb_ = param1;
            dispatchEvent(new PropertyModEvent("thumb"));
         }
      }
      
      public function get thumb() : Class
      {
         return this.thumb_;
      }
      
      public function Thumb(param1:Class) : UpgradeDef
      {
         this.thumb = param1;
         return this;
      }
      
      public function set xpGate(param1:int) : void
      {
         if(this.xpGate_ != param1)
         {
            this.xpGate_ = param1;
            dispatchEvent(new PropertyModEvent("xpGate"));
         }
      }
      
      public function get xpGate() : int
      {
         return this.xpGate_;
      }
      
      public function XpGate(param1:int) : UpgradeDef
      {
         this.xpGate = param1;
         return this;
      }
      
      public function set rankGate(param1:int) : void
      {
         if(this.rankGate_ != param1)
         {
            this.rankGate_ = param1;
            dispatchEvent(new PropertyModEvent("rankGate"));
         }
      }
      
      public function get rankGate() : int
      {
         return this.rankGate_;
      }
      
      public function RankGate(param1:int) : UpgradeDef
      {
         this.rankGate = param1;
         return this;
      }
   }
}
