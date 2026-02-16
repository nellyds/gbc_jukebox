songs = {}
songs.list = {}
songFiles = {
  {name="The World has turned and left me here",path="audio/TheWorldHasTurnedAndLeftMeHere.wav",key="worldTurned"},
  {name="Gun Star Heroes-Stage 1",path="audio/Gunstar_Heroes_Stage_one.wav",key="gunstar"},
  {name="Bloodlines -Reincarnated Souls",path="audio/Bloodlines_Reincarnated_Souls.wav",key="boodlines"},
  {name="American Football -Never Meant",path="audio/American_Football_Never_Meant.wav",key="americanFootball"},
  {name="Terranigma -Underworld",path="audio/Terranigma_Underworld.wav",key="terranigma"},
  {name="Sonic Adventure 2 -Escape from the Ciy", path="audio/Sonic_Adventure_2_Escape_from_the_City.wav",key="sonicAdventure2"},
  {name="Back",path="",key="back"}
}


function songs:load_songs()
    for _, song in ipairs(songFiles) do 
        local source = nil
        if song.path ~= "" then
          source = love.audio.newSource(song.path, 'stream')
        end
        table.insert(self.list,{name = song.name, source = source,key=song.key})
    end
    print("All songs loaded.")
end
return songs