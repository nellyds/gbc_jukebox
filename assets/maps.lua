maps = {}
maps.room_1 = {
  map={
    {2,6,6,6,6,6,6,6,6,3},
    {7,1,1,1,1,1,1,1,1,8},
    {10,1,1,1,1,1,1,1,1,8},
    {7,1,1,1,1,1,1,1,1,8},
    {7,1,1,1,1,1,1,1,1,8},
    {10,1,1,1,1,1,1,1,1,11},
    {4,9,9,9,9,9,9,9,9,5}, 
  },
  objects= {
    {type="record_stack", col="slide", x=,y=2},
    {type="record_player", col="slide",x=3,y=2},
    {type="door",col="cross", destination=constants.ROOM_2,x=1,y=3}    
  }
}
return maps
