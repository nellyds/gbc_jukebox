--room objects
_room_objects ={}

function _room_objects:add_object(x,y,message,world) 
   local r= {}
   r.x=x
   r.y=y
   r.w=16
   r.h=16
   r.text=message
   r.col='cross'
   r.type='int_obj'
   world:add(r,x,y,r.w,r.h)
   table.insert(_room_objects,r)
end



return _room_objects