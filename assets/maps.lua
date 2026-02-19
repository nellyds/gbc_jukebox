maps = {}
maps.room_1 = {
  map={
    {2,6,6,6,6,6,6,6,6,3},
    {7,1,1,1,1,1,1,1,1,8},
    {10,1,1,1,1,1,1,1,1,8},
    {7,1,1,1,1,1,1,1,1,8},
    {7,1,1,1,1,1,1,1,1,8},
    {7,1,1,1,1,1,1,1,1,8},
    {4,9,9,9,9,9,9,9,9,5}, 
  },
  objects= {
    {col="record_stack", type="slide", x=192,y=64, img="sprites/environment/record_stack.png"},
    {col="record_player", type="slide",x=256,y=64, img="sprites/environment/record_player.png"},
    {col="int_obj",type="slide", text_key="couch", x=500, y=180, img="sprites/environment/couch.png",w=64,h=128} ,      
    {col="int_obj", type="slide",text_key="table", x=256, y=200, img="sprites/environment/table.png",w=128,h=64}
  },
  doors={
    {col="door", type="cross", x=0,y=192, destination=constants.ROOM_2, pcx=7.5, pcy=2}
  }
}
maps.room_2 = {
    map={
    {2,6,6,6,6,6,6,6,6,3},
    {7,1,1,1,1,1,1,1,1,8},
    {7,1,1,1,1,1,1,1,1,11},
    {7,1,1,1,1,1,1,1,1,8},
    {4,9,9,9,9,9,9,9,9,5}, 
  },
  objects= {
    {col="int_obj", type="slide", text_key="bed", x=64, y=128, img="sprites/environment/bed.png",w=64,h=128}   
  },
  doors={
    {col="door", type="cross", x=8*64, y=3*64, destination=constants.ROOM_1, pcx=1.5, pcy=2}
  }
}
return maps
