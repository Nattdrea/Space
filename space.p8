pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
ship = {
    x=64,
    y=64,

    vx=0,
    vy=0,

    accel=0.15,
    drag=0.98,
    max_speed=2
}


-->8
function _init()
    debris = {}
end
-->8
function update_ship()

    if btn(2) then
        ship.vy -= ship.accel
    end

    if btn(3) then
        ship.vy += ship.accel
    end

    if btn(0) then
        ship.vx -= ship.accel
    end

    if btn(1) then
        ship.vx += ship.accel
    end

    ship.vx *= ship.drag
    ship.vy *= ship.drag

    ship.x += ship.vx
    ship.y += ship.vy

    -- invisible world borders

    if ship.x < 4 then
        ship.x = 4
        ship.vx = 0
    end

    if ship.x > 123 then
        ship.x = 123
        ship.vx = 0
    end

    if ship.y < 4 then
        ship.y = 4
        ship.vy = 0
    end

    if ship.y > 123 then
        ship.y = 123
        ship.vy = 0
    end

end
-->8
function update_debris_system()

    if #debris < 10 and rnd(1) < 0.02 then
        spawn_debris()
    end

    for d in all(debris) do
        update_debris(d)
        remove_offscreen_debris(d)
    end
end
-->8
function spawn_debris()

    local d={}
    local side=flr(rnd(4))
    local speed=0.1+rnd(0.3)

    if side==0 then
        d.x=0
        d.y=rnd(128)
        d.dx=speed
        d.dy=0

    elseif side==1 then
        d.x=127
        d.y=rnd(128)
        d.dx=-speed
        d.dy=0

    elseif side==2 then
        d.x=rnd(128)
        d.y=0
        d.dx=0
        d.dy=speed

    else
        d.x=rnd(128)
        d.y=127
        d.dx=0
        d.dy=-speed
    end

    add(debris,d)
end

function update_debris(d)
    d.x += d.dx
    d.y += d.dy
end

function remove_offscreen_debris(d)

    if d.x < 0 or d.x > 127
    or d.y < 0 or d.y > 127 then
        del(debris,d)
    end

end
-->8
function draw_ship()

    line(ship.x, ship.y-4,
         ship.x-3, ship.y+3,
         11)

    line(ship.x-3, ship.y+3,
         ship.x+3, ship.y+3,
         11)

    line(ship.x+3, ship.y+3,
         ship.x, ship.y-4,
         11)

end

function draw_debris()

    for d in all(debris) do
        circfill(d.x,d.y,3,7)
    end

end
-->8
function _update()

    update_ship()
    update_debris_system()

end
-->8
function _draw()

    cls(0)

    -- stars
    pset(10,20,7)
    pset(40,90,6)
    pset(90,30,7)
    pset(110,80,13)

    draw_ship()
    draw_debris()

end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
