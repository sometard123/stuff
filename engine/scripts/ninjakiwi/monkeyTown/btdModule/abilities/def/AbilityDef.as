package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class AbilityDef extends EventDispatcher
   {
       
      
      public var input:Vector.<TowerDef> = null;
      
      private var id_:String = null;
      
      private var cooldown_:Number = 5;
      
      private var sound_:Class = null;
      
      private var effect_:Class = null;
      
      private var thumb_:Class = null;
      
      private var ability_:Class = null;
      
      private var label_:String = null;
      
      private var description_:String = null;
      
      private var effectBlend_:String = null;
      
      public function AbilityDef(param1:String = null)
      {
         super();
         this.id_ = param1;
      }
      
      public function get id() : String
      {
         return this.id_;
      }
      
      public function set id(param1:String) : void
      {
         this.id_ = param1;
      }
      
      public function get cooldown() : Number
      {
         return this.cooldown_;
      }
      
      public function set cooldown(param1:Number) : void
      {
         if(this.cooldown_ != param1)
         {
            this.cooldown_ = param1;
            dispatchEvent(new PropertyModEvent("cooldown"));
         }
      }
      
      public function get sound() : Class
      {
         return this.sound_;
      }
      
      public function set sound(param1:Class) : void
      {
         if(this.sound_ != param1)
         {
            this.sound_ = param1;
            dispatchEvent(new PropertyModEvent("sound"));
         }
      }
      
      public function get effect() : Class
      {
         return this.effect_;
      }
      
      public function set effect(param1:Class) : void
      {
         if(this.effect_ != param1)
         {
            this.effect_ = param1;
            dispatchEvent(new PropertyModEvent("effect"));
         }
      }
      
      public function get thumb() : Class
      {
         return this.thumb_;
      }
      
      public function set thumb(param1:Class) : void
      {
         if(this.thumb_ != param1)
         {
            this.thumb_ = param1;
            dispatchEvent(new PropertyModEvent("thumb"));
         }
      }
      
      public function get ability() : Class
      {
         return this.ability_;
      }
      
      public function set ability(param1:Class) : void
      {
         if(this.ability_ != param1)
         {
            this.ability_ = param1;
            dispatchEvent(new PropertyModEvent("ability"));
         }
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
      
      public function set effectBlend(param1:String) : void
      {
         this.effectBlend_ = param1;
      }
      
      public function get effectBlend() : String
      {
         return this.effectBlend_;
      }
   }
}
