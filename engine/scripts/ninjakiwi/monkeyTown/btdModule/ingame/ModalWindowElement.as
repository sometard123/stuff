package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.town.ModalBlockerClip;
   import flash.display.DisplayObjectContainer;
   
   public class ModalWindowElement
   {
       
      
      public var key:Object;
      
      public var container:DisplayObjectContainer;
      
      public var clip:ModalBlockerClip;
      
      public var backupClip:ModalBlockerClip;
      
      public function ModalWindowElement(param1:Object, param2:DisplayObjectContainer, param3:ModalBlockerClip)
      {
         super();
         this.key = param1;
         this.container = param2;
         this.clip = param3;
      }
   }
}
