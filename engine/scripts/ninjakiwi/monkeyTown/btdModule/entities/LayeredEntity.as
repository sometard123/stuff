package ninjakiwi.monkeyTown.btdModule.entities
{
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   
   public class LayeredEntity extends Entity
   {
       
      
      private var layers:Vector.<Entity>;
      
      public function LayeredEntity()
      {
         this.layers = new Vector.<Entity>();
         super();
      }
      
      public function initialise(param1:Vector.<Class>, param2:Number, param3:Number, param4:Level) : void
      {
         var _loc6_:Class = null;
         var _loc7_:MapElement = null;
         var _loc5_:int = 0;
         for each(_loc6_ in param1)
         {
            _loc7_ = new MapElement();
            _loc7_.initialise(_loc6_,param2 + _loc5_);
            param4.addEntity(_loc7_);
            this.layers.push(_loc7_);
            _loc5_++;
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:Entity = null;
         for each(_loc1_ in this.layers)
         {
            _loc1_.destroy();
         }
         super.destroy();
      }
      
      override public function set rotation(param1:Number) : void
      {
         var _loc2_:Entity = null;
         for each(_loc2_ in this.layers)
         {
            _loc2_.rotation = param1;
         }
         super.rotation = param1;
      }
      
      override public function process(param1:Number) : void
      {
         var _loc2_:Entity = null;
         for each(_loc2_ in this.layers)
         {
            _loc2_.x = x;
         }
         for each(_loc2_ in this.layers)
         {
            _loc2_.y = y;
         }
         super.process(param1);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         var _loc2_:Entity = null;
         for each(_loc2_ in this.layers)
         {
            _loc2_.x = x;
         }
         for each(_loc2_ in this.layers)
         {
            _loc2_.y = y;
         }
         super.draw(param1);
      }
   }
}
