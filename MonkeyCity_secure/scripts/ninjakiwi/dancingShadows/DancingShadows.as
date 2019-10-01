package ninjakiwi.dancingShadows
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public final class DancingShadows
   {
      
      public static const MODIFIED:String = "ding ding";
      
      public static const alarm:EventDispatcher = new EventDispatcher();
      
      private static const pool:Array = [new ShadowNum(),new ShadowNum(),new ShadowNum()];
      
      {
         ShadowNum.alarm.addEventListener(ShadowNum.MODIFIED,function(param1:Event):void
         {
            alarm.dispatchEvent(new Event(MODIFIED));
         });
      }
      
      public function DancingShadows()
      {
         super();
      }
      
      public static function getOne(param1:Number = 0) : INumber
      {
         var _loc2_:ShadowNum = null;
         if(pool.length == 0)
         {
            return new ShadowNum(param1);
         }
         _loc2_ = pool.pop();
         _loc2_.value = param1;
         return _loc2_;
      }
      
      public static function returnOne(param1:INumber) : void
      {
         param1.value = 0;
         pool.push(param1);
      }
   }
}
