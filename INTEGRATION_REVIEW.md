# The Invasion of VOS — Aldred + Pierre + Evan integration (review build)

**Base:** Aldred commit `f3ea76f` (from `RespawnStudios(3).zip`)

**Other source branches:** Pierre commit `0bb996b` (`RespawnStudiosPierre.zip`); Evan commit `ffbc053` (`RespawnStudiosEvan.zip`).

This is a **proposed integrated project**, not a confirmed working GameMaker build. The files have been merged and statically checked, but GameMaker was not available to compile or play-test them. Keep this on a test branch until the checklist below passes.

## Included changes

- **Preserved Aldred:** `par_Enemy` damage/death inheritance, melee, player crouch/sprint/jump animations, dialogue, Radar, objectives, gear pickup, platform/wall hierarchy, player health/invincibility, and existing Test_Room placements.
- **Pierre:** new enemy AI (shooting, chasing, ledge/jump navigation), enemy bullets, 360-degree mouse aiming, wall jumping, tutorial prompts, tutorial room/teleporter, turret objects/sprites and underground backdrop objects.
- **Evan:** `prison_lvl3` room, registered in the project and room order.
- **Integration fixes:** moved Pierre's AI variables into `par_Enemy` Create; removed `obj_Enemy_1`'s duplicate Create/Step so it inherits; corrected line-of-sight assumptions (enemies/player are not platforms); kept bullet collision targeting `par_Enemy`; retained `player_damage` and Alarm 0; used each shooter's own instance layer so bullets also work in `prison_lvl3`; fixed tutorial room exit location and cross-room spawn; prevented enemy bullets/turret AI from continuing during pause; restored missing original sprites and project resources.
- **Pre-existing cleanup:** removed `obj_Health`'s registered but missing Create event.

## What was deliberately not overwritten

- `obj_Player` was **not** made a child of `obj_Platform` or persistent (both would conflict with Aldred's current collision and room setup).
- Aldred's `player_movement()`, melee, player gear collection, and ObjectiveManager logic remain in place. Pierre's older movement and gear scripts were **not** substituted wholesale.
- Aldred's Vector sprite PNGs were retained. Pierre's new turret and teleporter sprites were added.
- Existing Test_Room content was preserved; Pierre's two turret instances and background layer were added on top of it.
- Existing `par_Enemy` health and `die()` are preserved for later death animation/loot-drop work.

## Known limitations / follow-up work

- **Runtime has not been tested.** GameMaker may reveal issues not detectable from file inspection.
- Pierre's `obj_Turret_Gun_2` currently destroys player bullets on collision but does not have the `par_Enemy` damage/death interface; turret health and melee interaction remain future work.
- `prison_lvl3` is included but is not linked into the story progression yet; you can run it directly in GameMaker.
- Enemy weapon/ammo drops, inventory, and death animations are **not** implemented in this merge.
- The tutorial is a basic implementation; test its prompt progression and the teleporter before making it the default Start path. Main Menu's START currently goes to `Tutorial_Level`.
- Enemy AI's `sight_range`, `keep_distance`, `fire_rate`, and movement speeds will need balancing, particularly in Evan's prison room with many enemy instances.

## GameMaker test checklist (before merging into main)

1. Open **`The Invasion of VOS.yyp`** in GameMaker. Confirm there are no missing resources or compiler errors.
2. Run Main Menu → START → `Tutorial_Level`. Test W/A/D, shooting (including aiming up/down), grenade charge, and wall jump. Reach the teleporter on the right; verify it loads Test_Room.
3. In Test_Room, verify Radar dialogue, gears/objective progression, crouch/sprint/jump animations, pause/resume, and wall/floor collisions.
4. Shoot and melee `obj_Enemy`, `obj_Enemy_1`, and `obj_EnemyHeavy` from both sides. Verify independent health/death and no `enemy_jump_cooldown` error.
5. Check enemy shooting and the turret. Confirm enemy projectiles damage the player and freeze during pause.
6. Run `prison_lvl3` directly. Check collision, enemy spawning/shooting, performance, and player projectiles in its differently named instance layer.
7. If everything works, commit on your integration branch and merge to `main` through a reviewed pull request. Do not overwrite main with ZIP contents without checking newer teammate changes.

## Importing the integrated Git history

A Git bundle is supplied separately. In the original local Git repository, from **Repository → Open in Terminal** in GitHub Desktop, run:

```bash
git fetch "C:/path/to/VOS_Integration.bundle" Aldred-Pierre-Evan-Integration:refs/heads/Aldred-Pierre-Evan-Integration
```

Replace the path with the actual downloaded bundle path. The command creates a **new local branch**; it does not change `main` or your working branch. Switch to the new branch in GitHub Desktop and test. If your Aldred branch has advanced beyond the ZIP snapshot, compare the commits before merging.

Alternatively, open the integrated project ZIP in a separate folder to review it without touching your Git repository.
