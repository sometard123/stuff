package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import com.greensock.TweenLite;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.system.Security;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.dust.Particle;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.pvp.attackDefinition;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class DustPoof extends DustBurst
   {
       
      
      public function DustPoof(param1:KnowledgeParticlesPool)
      {
         super(param1);
      }
      
      override public function go(param1:Rectangle, param2:String = "default") : void
      {
         var p:Particle = null;
         var rect:Rectangle = param1;
         var type:String = param2;
         idle = false;
         _pool.getParticles(50,_particles);
         var i:int = 0;
         var len:int = _particles.length;
         while(i < len)
         {
            p = _particles[i];
            p.x = rect.x + rect.width * Math.random();
            p.y = rect.y + rect.height * Math.random();
            p.friction = friction1 - Math.random() * friction1 * friction1Variance;
            p.velocity.x = (Math.random() - 0.5) * 2 * burstForce;
            p.velocity.y = (Math.random() - 0.5) * 2 * burstForce;
            i++;
         }
         _visibleParticleCount = _particles.length;
         var that:DustBurst = this;
         TweenLite.delayedCall(0.4,function():void
         {
            var j:int = 0;
            while(j < _particles.length)
            {
               p = _particles[j];
               TweenLite.delayedCall(Math.random() * 0.5,function(param1:Particle):void
               {
                  var p:Particle = param1;
                  p.selectAnimation("pop");
                  p.gotoAndPlay(1);
                  TweenLite.delayedCall(10,function():void
                  {
                     retireParticle(p);
                  },null,true);
               },[p]);
               j++;
            }
         });
      }
   }
}
