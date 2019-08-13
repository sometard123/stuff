package ninjakiwi.monkeyTown.town.flare.birds
{
   import com.codecatalyst.promise.Deferred;
   import com.codecatalyst.promise.Promise;
   import com.ninjakiwi.gateway.net.loader;
   import com.ninjakiwi.gateway.net.result;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.townMap.bloonPredictor.BloonPredictor;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.utils.Calculator;
   
   public class GhostBird extends Bird
   {
       
      
      public function GhostBird()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _animationClasses.push("assets.flare.GhostFlare");
         _numberOfAnimationAngles = 1;
         speed = 0.4;
         super.initView();
      }
      
      override protected function findAnimationIndex() : int
      {
         return 0;
      }
   }
}
