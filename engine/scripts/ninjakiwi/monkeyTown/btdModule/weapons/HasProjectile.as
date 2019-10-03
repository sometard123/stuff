package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   
   public interface HasProjectile
   {
       
      
      function set projectile(param1:ProjectileDef) : void;
      
      function get projectile() : ProjectileDef;
   }
}
