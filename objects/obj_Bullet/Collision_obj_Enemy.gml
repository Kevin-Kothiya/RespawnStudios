// when it hits the enemy, it should be destroyed
instance_destroy();

if (obj_Enemy.enemy_health > 0) {
	obj_Enemy.enemy_health -= bullet_damage;
}