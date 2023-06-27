pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
function _init()
p={x=60,y=90,speed=4}	
bullets={}
enemies={}
explosions={} 
spawn_enemies()
create_explosions(63,63)
score=0
monster={x1=60,y1=10,x2=68,y2=10,
   x3=60,y3=18,x4=68,y4=18}
draw_monster(monster)
--monsters={}
end

function _update60()
if (btn(➡️)) p.x+=1
if (btn(⬅️)) p.x-=1
if (btn(⬆️))	p.y-=1
if (btn(⬇️)) p.y+=1
if (btnp(❎)) shoot()
update_bullets() 


p.x =mid(0,120,p.x)
p.y =mid(0,120,p.y)

if #enemies==0 and score <50 then 
	spawn_enemies()
end  
update_enemies()
update_explosions()
if score >=50 then
monster=update_monster(monster)
end
end

function _draw()
cls(12)

--map(0,0,0,0,16,16)
--vaisseau
spr(1,p.x,p.y)	
--ennemies
for e in all(enemies) do
	spr(3,e.x,e.y)
end
	--explosion
draw_explosions()
--bullets
for b in all(bullets) do
	spr(2,b.x,b.y)
end
	--score
	print(score_text(),0,15,7)
	print("score:",2,2,7)
	print(score,2,8)
	
	--big crab
	if score >=50 then
   draw_monster(monster)
   delete_enemies(enemies)
 end
end






-->8
--bullets
function shoot()
 new_bullet={
 x=p.x,
 y=p.y,
 speed=4
 }
 add(bullets,new_bullet)	
 sfx(0) 
end
 
function update_bullets() 
	for b in all(bullets) do
		b.y-=b.speed 
	end
end
-->8
--enemies
 
function spawn_enemies()
enemies={}
 for i=1,20 do
 new_enemy={
 	x=rnd(128),
 	y=rnd(55),
 	life=1,
 	speed=0.1
 }
 	 add(enemies,new_enemy)
end
 end

function update_enemies()
	for e in all(enemies) do
		e.y+=0.3
		if e.y >128 then 
			del(enemies,e)
		end
	--collision
	for b in all (bullets) do
		if collision(e,b) then
 			create_explosions(b.x,b.y)
			del(bullets,b)
			e.life -=1
			if e.life==0 then
				del(enemies,e)
				score+=1
			if score ==50 then
				sfx(2)
			end	
			end
		end
	end
end
end
	
function delete_enemies(enemies)
 for e in all(enemies) do
   del(enemies,e)
 end
end
-->8
--collision

function collision(a,b)
	if a.x > b.x+8
	or a.y > b.y+8
	or a.x+8 <b.x
	or a.y+8 <b.y then
		return false
		else
			return true
		end
	end

-->8

--explosion


function create_explosions(_x,_y)
	sfx(1) 
	add(explosions,{x=_x,
	                y=_y,
	                timer=0})
end

function update_explosions()
	for e in all(explosions) do
		e.timer+=1
		if e.timer==13 then
			del(explosions,e)
		end
	end
end

function draw_explosions()
	--circ(x,y,rayon,coouleur)
	
	for e in all(explosions) do
		circ(e.x,e.y,e.timer/3,
		     8+e.timer%3)
	end
end
-->8
--score

function score_text()
	if score >= 50 then
		  return "super score!!!"
	else
	   return "tu peux mieux faire:("	
		
	end
end


-->8

-- boss de fin
function draw_monster(m)
 spr(16,m.x1,m.y1)
 spr(17,m.x2,m.y2)
 spr(32,m.x3,m.y3)
 spr(33,m.x4,m.y4)
end

function update_monster(m)
 return {x1=m.x1,y1=m.y1+1,
    x2=m.x2,y2=m.y2+1,
    x3=m.x3,y3=m.y3+1,
    x4=m.x4,y4=m.y4+1}
end
__gfx__
00000000000000000000000008000800bbbbbbbbbbbffbbbbbbbbbbb00000000b3bb3bbbbbbbbbbbbbbffbbbbbbffbbb08000800cccccccccccccccc00000000
00000000b0000b000900009080000080bbb8bbbbbbbffbbbabbbbbbb000ff000bb33bbbbbbb88bbbbbbffbbbbbbffbbb80000080cccccccccccc777700000000
00700700b0000b000000000080808080bb989bbbbb9999bbbbbbbbbb00999900b8888bbbbb9999bbbb9999bbbb8888bb80808080cccccccccccccccc00000000
000770002b00b2600000000088000880b99999bbb879998bbbbbbabb08799980888888bbff9999ffb89999ffbb8888bb88000880ccccccccc7777ccc00000000
000770002b00b26000000000807070809909099bb899998bbbbbbbbb08999980888888bbff9999ffb89999ffbbb88bbb80707080cccccccc7ccccccc00000000
00700700bbbbbb200a0000a0887878809999999bbb9999bbbbbbbbbb00999900b8888bbbbb9799bbbb9799bbbbb88bbb88787880cccccccccc7777cc00000000
00000000bbbbbbb00a0000a008888800b99999bbbbbffbbbbbabbbbb000ff000bb88bbbbbbb88bbbbbb88bbbbbb88bbb08888800cccccccccccccccc00000000
000000000b00b0200900009080808080bb999bbbbbbffbbbbbbbbbbb00000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb80808080cccccccccccccccc00000000
08800000000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08008800008800800000000000000000000ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88008800008800880000000000000000009999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88880000000088880000000000000000087999800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88880000000088880000000000000000089999800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88000770077000880000000000000000009999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88000770077000880000000000000000000ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888778877888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08888778877888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08888778877888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88000880088000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88000880088000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88000880088000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d0e0d0d0d0e0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d0d0d0d0d0d0d0d0d0d0d0d0e0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d0d0d0d0d0d0d0e0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d0d0e0d0d0e0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000039000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0e0d0d0d0d0d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0e0d0d0d0d0d0d0d0d0d0d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000000002105021050215501f05016050120500e040090300602000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000036670356703467032670306502e6402c640296302763024650226501f6501d6501a650186501565013650106500d6500b650086500565004650016500065000650006500065000650006500065000000
00140000177501b0501805016050170501905019050190501705016750170501705016050120500f0500075000730000100000000000000000000000000000000000000000000000000000000000000000000000
