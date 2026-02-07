songs = {}
songs.list = {}
songFiles = {
  {name="Under cover of Darkness-The Strokes",path="audio/underCoverOfDarkness.wav",key="under"},
  {name="Emerald Sword-Rhapsody of Fire",path="audio/EmeraldSword.wav",key="emerald"},
  {name="The World has turned and left me here",path="audio/TheWorldHasTurnedAndLeftMeHere.wav",key="worldTurned"},
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