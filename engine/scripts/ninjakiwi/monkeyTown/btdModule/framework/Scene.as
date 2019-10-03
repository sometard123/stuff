package ninjakiwi.monkeyTown.btdModule.framework
{
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   
   public class Scene extends Drawable implements Processable
   {
       
      
      private var drawables:Vector.<Drawable>;
      
      private var processables:Vector.<Processable>;
      
      private var culled:Vector.<Processable>;
      
      public var sortDrawList:Boolean = false;
      
      public function Scene()
      {
         this.drawables = new Vector.<Drawable>();
         this.processables = new Vector.<Processable>();
         this.culled = new Vector.<Processable>();
         super();
      }
      
      override public function draw(param1:BitmapData) : void
      {
         var _loc2_:Drawable = null;
         for each(_loc2_ in this.drawables)
         {
            _loc2_.draw(param1);
         }
      }
      
      public function process(param1:Number) : void
      {
         var _loc2_:Processable = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         for each(_loc2_ in this.processables)
         {
            if(this.culled.indexOf(_loc2_) == -1)
            {
               _loc2_.process(param1);
            }
         }
         for each(_loc2_ in this.culled)
         {
            _loc3_ = this.processables.indexOf(_loc2_);
            if(_loc3_ != -1)
            {
               if(this.processables[_loc3_] is GameSpeedTimer)
               {
                  GameSpeedTimer(this.processables[_loc3_]).destroy();
               }
               this.processables.splice(_loc3_,1);
            }
            _loc4_ = this.drawables.indexOf(_loc2_);
            if(_loc4_ != -1)
            {
               this.drawables.splice(_loc4_,1);
            }
         }
         this.culled.length = 0;
         if(this.sortDrawList)
         {
            this.drawables.sort(this.byZ);
            this.sortDrawList = false;
         }
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.processables.length)
         {
            if(this.processables[_loc1_] is GameSpeedTimer)
            {
               GameSpeedTimer(this.processables[_loc1_]).destroy();
            }
            _loc1_++;
         }
         this.processables.splice(0,this.processables.length);
         this.drawables.splice(0,this.drawables.length);
      }
      
      public function addProcessable(param1:Processable) : void
      {
         this.processables.push(param1);
      }
      
      public function addEntity(param1:Entity) : void
      {
         param1.scene = this;
         this.processables.push(param1);
         var _loc2_:int = 0;
         while(_loc2_ < this.drawables.length)
         {
            if(this.drawables[_loc2_].z > param1.z)
            {
               this.drawables.splice(_loc2_,0,param1);
               return;
            }
            _loc2_++;
         }
         this.drawables.push(param1);
      }
      
      public function addDrawable(param1:Drawable) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.drawables.length)
         {
            if(this.drawables[_loc2_].z > param1.z)
            {
               this.drawables.splice(_loc2_,0,param1);
               return;
            }
            _loc2_++;
         }
         this.drawables.push(param1);
      }
      
      private function byZ(param1:Drawable, param2:Drawable) : int
      {
         if(param1.z > param2.z)
         {
            return 1;
         }
         if(param1.z < param2.z)
         {
            return -1;
         }
         return 0;
      }
      
      public function cull(param1:Processable) : void
      {
         this.culled.push(param1);
      }
   }
}
