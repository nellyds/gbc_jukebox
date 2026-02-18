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
    {type="record_stack", col="slide", x=192,y=64, pcx=7, pcy=3, img="sprites/environment/record_stack.png"},
    {type="record_player", col="slide",x=256,y=64, pcx=7, pcy=3, img="sprites/environment/record_player.png"},
    {type="couch",col="slide", x=500, y=180, img="sprites/environment/couch.png",w=64,h=128} ,      
  {type="table", col="slide",x=256, y=200, img="sprites/environment/table.png",w=128,h=64}
  },
  doors={
    {type="door", col="cross", x=0,y=192, destination=constants.ROOM_2, pcx=7.5, pcy=2}
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
    {type="bed", col="slide", x=4*64, y=2*64, img="sprites/environment/bed.png",w=64,h=128}   
  },
  doors={
    {type="door", col="cross", x=8*64, y=3*64, destination=constants.ROOM_1, pcx=1.5, pcy=2}
  }
}
return maps
