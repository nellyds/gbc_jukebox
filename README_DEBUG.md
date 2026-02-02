# LÖVE2D Debugging Setup

## How to Debug Your Game

### 1. Install VSCode Extensions
Install these VSCode extensions for Lua debugging:
- **Lua Extension** (sumneko.lua)
- **Lua Debug** (actboy168.lua-debug)

### 2. Run with Debugging
1. Open VSCode
2. Press `F5` or go to Run and Debug panel
3. Select "Debug LÖVE" configuration
4. The game will start with debugging enabled

### 3. Using Breakpoints

#### Console Breakpoints
Add these lines in your code to create breakpoints:
```lua
-- Simple console breakpoint
print("DEBUG: Variable value =", someVariable)

-- Interactive breakpoint (pauses execution)
if someCondition then
    print("BREAKPOINT: Press Enter to continue...")
    io.read()
end
```

#### VSCode Breakpoints
1. Click in the gutter next to line numbers to set breakpoints
2. Use the debug panel to control execution:
   - `F5`: Continue
   - `F10`: Step over
   - `F11`: Step into
   - `Shift+F11`: Step out

### 4. Debug Output
The game includes debug prints for:
- Player movement (`dx`, `dy` values)
- Collision detection
- Game state updates

### 5. Running Without Debug
Use "Run LÖVE (No Debug)" configuration for normal gameplay.

## Current Debug Features
- Player movement tracking
- Collision detection logging
- Console output for game state
- Breakpoint support via VSCode

## Tips
- Use `print()` statements for quick debugging
- Check the VSCode Debug Console for output
- Set conditional breakpoints for complex scenarios
- Use the Call Stack panel to trace function calls
