package ninjakiwi.mynk.net
{
   import flash.display.DisplayObjectContainer;
   
   public class RemoteAPIParams
   {
       
      
      public var url:String;
      
      public var urlParams:Object;
      
      public var container:DisplayObjectContainer;
      
      public function RemoteAPIParams(param1:String, param2:Object, param3:DisplayObjectContainer)
      {
         super();
         this.url = param1;
         this.urlParams = param2;
         this.container = param3;
      }
   }
}
