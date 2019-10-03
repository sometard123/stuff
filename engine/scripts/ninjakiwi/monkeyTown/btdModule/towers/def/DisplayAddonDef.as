package ninjakiwi.monkeyTown.btdModule.towers.def
{
   import assets.base.Tower;
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class DisplayAddonDef extends EventDispatcher
   {
      
      public static var clip_baseof:Class = Tower;
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var clip_:Class = null;
      
      private var z_:Number = 0;
      
      private var ref_:String = null;
      
      private var alts_:Vector.<AltDisplayAddonDef> = null;
      
      private var loop_:Boolean = true;
      
      private var rotate_:Boolean = true;
      
      public function DisplayAddonDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("clip","z","ref","alts","loop","rotate");
         }
         return displayOrder;
      }
      
      public function set clip(param1:Class) : void
      {
         if(this.clip_ != param1)
         {
            this.clip_ = param1;
            dispatchEvent(new PropertyModEvent("clip"));
         }
      }
      
      public function get clip() : Class
      {
         return this.clip_;
      }
      
      public function Clip(param1:Class) : DisplayAddonDef
      {
         this.clip = param1;
         return this;
      }
      
      public function set z(param1:Number) : void
      {
         if(this.z_ != param1)
         {
            this.z_ = param1;
            dispatchEvent(new PropertyModEvent("z"));
         }
      }
      
      public function get z() : Number
      {
         return this.z_;
      }
      
      public function Z(param1:Number) : DisplayAddonDef
      {
         this.z = param1;
         return this;
      }
      
      public function set ref(param1:String) : void
      {
         if(this.ref_ != param1)
         {
            this.ref_ = param1;
            dispatchEvent(new PropertyModEvent("ref"));
         }
      }
      
      public function get ref() : String
      {
         return this.ref_;
      }
      
      public function Ref(param1:String) : DisplayAddonDef
      {
         this.ref = param1;
         return this;
      }
      
      public function set alts(param1:Vector.<AltDisplayAddonDef>) : void
      {
         if(this.alts_ != param1)
         {
            this.alts_ = param1;
            dispatchEvent(new PropertyModEvent("alts"));
         }
      }
      
      public function get alts() : Vector.<AltDisplayAddonDef>
      {
         return this.alts_;
      }
      
      public function Alts(param1:Vector.<AltDisplayAddonDef>) : DisplayAddonDef
      {
         this.alts = param1;
         return this;
      }
      
      public function set loop(param1:Boolean) : void
      {
         if(this.loop_ != param1)
         {
            this.loop_ = param1;
            dispatchEvent(new PropertyModEvent("loop"));
         }
      }
      
      public function get loop() : Boolean
      {
         return this.loop_;
      }
      
      public function Loop(param1:Boolean) : DisplayAddonDef
      {
         this.loop = param1;
         return this;
      }
      
      public function set rotate(param1:Boolean) : void
      {
         if(this.rotate_ != param1)
         {
            this.rotate_ = param1;
            dispatchEvent(new PropertyModEvent("rotate"));
         }
      }
      
      public function get rotate() : Boolean
      {
         return this.rotate_;
      }
      
      public function Rotate(param1:Boolean) : DisplayAddonDef
      {
         this.rotate = param1;
         return this;
      }
   }
}
