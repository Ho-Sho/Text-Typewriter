utf8 = require 'utf8' rapidjson = require 'rapidjson'
--Variable--------------------------------------------------------------------------------------------------------------
cPos, Pos, LetterPos = 1, {}, 1 --Current Positions
scrollLetter = {}
ScrollTimer, ScrollLineTimers = Timer.New(), {}
TypeTimers = {}
emptyInput = {}
emptyInitialized = false
empInit = false
totaltime = {}
colors = {"lime", "red"}
msgtbl = {}
coltbl = {}
sortState = 0  -- 0: Init, 1: Non Sort, -1: Sort
sortflg = false
function TypeTableCheck(control) return type(control) == "table" and control or {control} end
Controls.InputText = TypeTableCheck(Controls.InputText)
Controls.DisplayScrollTextLine = TypeTableCheck(Controls.DisplayScrollTextLine)
Controls.LetterOK = TypeTableCheck(Controls.LetterOK)
Controls.LineOK = TypeTableCheck(Controls.LineOK)
Controls.LetterEndMsg = TypeTableCheck(Controls.LetterEndMsg)
Controls.LineEndMsg = TypeTableCheck(Controls.LineEndMsg)
-- Functions----------------------------------------------------------------------------------
--Display Text
function DisplayText(text, controlbox)
  if text then
    local startPos = utf8.offset(text, 1) --Str Sub StartPos
    local endPos = utf8.offset(text, LetterPos + 1) --Str Sub EndPos
    local modePos = utf8.offset(text, LetterPos)
    controlbox.String = (startPos and endPos) and string.sub(text, startPos, endPos - 1) or ""
    Controls.DisplayLupan.String = (modePos and endPos) and string.sub(text, modePos, endPos - 1) or ""
    --print(controlbox.String)
    local newLetterPos = controlbox.String:find('\n', lastLetterPos + 1)--Seach Carriage Return
    if newLetterPos then
      lastLetterPos = newLetterPos
      if inLetterOKcnt < #Controls.InputText then
        inLetterOKcnt = inLetterOKcnt + 1
        ToggleEmptyVisibility(Controls.LetterOK, inLetterOKcnt)
        ToggleEmptyVisibility(Controls.LetterEndMsg, inLetterOKcnt)
        if #Controls.InputText ~= 1 then
          if inLetterOKcnt == #Controls.InputText then
            Controls.DisplayLupan.IsInvisible = true
            Controls.DisplayScrollTextLetter.IsInvisible = false
          end
        else
          if inLetterOKcnt == 1 then
            Controls.DisplayLupan.IsInvisible = true
            Controls.DisplayScrollTextLetter.IsInvisible = false
          end
        end
      end
    end
  else
    ScrollingLetterInt()
  end
end
--Scrolling Letter
function ScrollingLetter(delay, controlbox, scrollText)
  local text, len = scrollText, utf8.len(scrollText)
  DisplayText(text, controlbox)

  ScrollTimer.EventHandler = function()
    if LetterPos <= len then
      DisplayText(text, controlbox)
      LetterPos = LetterPos + 1
    else
      LetterPos = 1
      print("done letter")
      if Controls.LetterLoop.Boolean then
        ScrollingLetterInt()
        Controls.StartLetter.Boolean = true
        Controls.StartLetter.EventHandler()
      else
        ScrollTimer:Stop()
        Controls.StartLetter.Boolean = false
        Controls.DisplayLupan.IsInvisible = true
        Controls.DisplayScrollTextLetter.IsInvisible = false
      end
    end
  end
  if delay ~= nil then
    ScrollTimer:Start(delay)
  end
end

--Initialize ScrollingLetter
function ScrollingLetterInt()
  LetterPos, inLetterOKcnt, lastLetterPos = 1, 0, 0
  Controls.DisplayScrollTextLetter.String = ''
  Controls.DisplayLupan.String = ''
  Controls.DisplayLupan.IsInvisible = not Controls.LupanMode.Boolean
  Controls.DisplayScrollTextLetter.IsInvisible = Controls.LupanMode.Boolean
  SetInvisibility(Controls.LetterOK)
  SetInvisibility(Controls.LetterEndMsg)
end
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
--Display LineText
function DisplayLineText(text, controlbox, index)
  if text then
    local startPos = utf8.offset(text, 1)
    local endPos = utf8.offset(text, Pos[index] + 1)
    controlbox.String = (startPos and endPos) and string.sub(text, startPos, endPos - 1) or ""
    --print(controlbox.String)
  else
    ScrollingLineInt()
  end
end
--Scrolling LineText
function ScrollingLine(delay, controlbox, index, scrollText, order)
  local text, len = scrollText, utf8.len(scrollText)
  DisplayLineText(text, controlbox, index)
  local ScrollLineTimer = ScrollLineTimers[index] or Timer.New()
  ScrollLineTimers[index] = ScrollLineTimer

  ScrollLineTimer.EventHandler = function()
    if Pos[index] and Pos[index] <= len then-- Check if valid start and end positions for text slicing
      local startPos = utf8.offset(text, 1)
      local endPos = utf8.offset(text, Pos[index] + 1)
      local cText = string.sub(text, startPos, endPos - 1)
      DisplayLineText(cText, controlbox, index)
      Pos[index] = Pos[index] + 1
      ToggleEmptyVisibility(Controls.LineOK, index, true, coltbl, nil) --Set reset invisibility true boolean false
      ToggleEmptyVisibility(Controls.LineEndMsg, index, true, nil, msgtble) --Set reset invisibility true boolean false
    else-- When start and end positions are not valid, toggle LED indicators
      if order and index < #Controls.DisplayScrollTextLine then--Start the next timer in the order if required
        ScrollingLine(delay, Controls.DisplayScrollTextLine[index + 1], index + 1, Controls.InputText[index + 1].String, order)
      end
      ToggleEmptyVisibility(Controls.LineOK, index, nil, coltbl, nil)
      ToggleEmptyVisibility(Controls.LineEndMsg, index, nil, nil, msgtbl)
      ScrollLineTimer:Stop()

      if index == #Controls.InputText then
        Controls.StartLine.Boolean = false
        print("done line")
        if Controls.LineLoop.Boolean then
          Controls.StartLine.Boolean = true
          Timer.CallAfter(function()
          Controls.StartLine.EventHandler()
          end, delay)
        end
      end
    end

  end
  if delay ~= nil then
    ScrollLineTimer:Start(delay)
  end
end

--Initialize ScrollingLine
function ScrollingLineInt()
  for index, controlbox in ipairs(Controls.DisplayScrollTextLine) do
    Pos[index] = 1
    controlbox.String = ""
    Controls.LineOK[index].IsInvisible = true
    Controls.LineOK[index].Boolean = false
    Controls.LineEndMsg[index].IsInvisible = true
    Controls.LineEndMsg[index].Boolean = false
  end
  ScrollLineTimers = {}
end
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
--Display Type Text
function DisplayTypeText(index, text)
  if text then
    local startPos = utf8.offset(text, 1)
    local endPos = utf8.offset(text, Pos[index] + 1)
    Controls.DisplayScrollTextLine[1].String = (startPos and endPos) and string.sub(text, startPos, endPos - 1) or ""
    --print(Controls.DisplayScrollTextLine[1].String)
  else
    TypewritterInt()
  end
end
-- Typewrite function with cIndex parameter
function Typewrite(delay, inptext)
  local text, len = inptext, string.len(inptext)
  local TypeTimer = TypeTimers[cIndex] or Timer.New()
  TypeTimers[cIndex] = TypeTimer

  TypeTimer.EventHandler = function()
    if Pos[cIndex] <= len then
      local startPos = utf8.offset(text, 1)
      local endPos = utf8.offset(text, Pos[cIndex] + 1)

      if startPos and endPos then-- Check if valid start and end positions for text slicing
        local cText = string.sub(text, startPos, endPos - 1)
        DisplayTypeText(cIndex, cText)
        Pos[cIndex] = Pos[cIndex] + 1
      else-- When start and end positions are not valid, toggle LED indicators
        ToggleEmptyVisibility(Controls.LineOK, cIndex, nil, coltbl, nil)--Normal Toggle LED
        ToggleEmptyVisibility(Controls.LineEndMsg, cIndex, nil, nil, msgtbl)
        Pos[cIndex] = len + 1
      end
    else--End of Character
      if Controls.InputText[cIndex + 1] and Controls.DisplayScrollTextLine[cIndex + 1] then
        local scrollIndex = 2
        for i = cIndex, 1, -1 do
          Controls.DisplayScrollTextLine[scrollIndex].String = Controls.InputText[i].String
          ToggleEmptyVisibility(Controls.LineOK, scrollIndex, nil, coltbl, nil)--Toggle Next LED
          ToggleEmptyVisibility(Controls.LineEndMsg, scrollIndex, nil, nil, msgtbl)
          scrollIndex = scrollIndex + 1
        end
      elseif cIndex == #Controls.InputText then--Final Index
        Controls.DisplayScrollTextLine[1].String = Controls.InputText[cIndex].String
        Controls.LineOK[1].Color = coltbl[cIndex]
        Controls.LineEndMsg[1].String = msgtbl[cIndex]
      end
      ToggleEmptyVisibility(Controls.LineOK, 1, nil, coltbl, nil)--When finished, Toggle LED
      ToggleEmptyVisibility(Controls.LineEndMsg, 1, nil, nil, msgtbl)
      -- Stop the timer and reset the character position
      TypeTimer:Stop()
      Pos[cIndex] = 1
      -- Move to the next index for processing
      cIndex = cIndex + 1
      if Controls.InputText[cIndex] then-- If there is more text to process, continue the typewriting effect with the next text
        Timer.CallAfter(function()
        Typewrite(delay, Controls.InputText[cIndex].String)
          ToggleEmptyVisibility(Controls.LineOK, 1, true, nil, coltbl, nil)
          ToggleEmptyVisibility(Controls.LineEndMsg, 1, true, nil, nil, msgtbl)
        end, delay)
      else-- If all text has been processed, reset variables and potentially trigger the next effect
        cIndex = 1
        empInit = false
        Controls.StartEffect.Boolean = false
        print("done effect")
        if Controls.EffectLoop.Boolean then
          Controls.StartEffect.Boolean = true
          Controls.StartEffect.EventHandler()
        end
      end
    end
  end

  if delay ~= nil then
    TypeTimer:Start(delay)
  end
end

-- Initialize Typewritter
function TypewritterInt()
  for index, controlbox in ipairs(Controls.DisplayScrollTextLine) do
    Pos[index] = 1
    controlbox.String = ""
    Controls.LineOK[index].IsInvisible = true
    Controls.LineOK[index].Boolean = false
    Controls.LineEndMsg[index].IsInvisible = true
    Controls.LineEndMsg[index].Boolean = false
  end
  TypeTimers = {}
  cIndex = 1 --cIndex init
  empInit = true --typewritterflag
end
-------------------------------------------------------------------------------------------------
-- Helper funciton
function SetInvisibility(name)
  for i, ctl in ipairs(name) do
  ctl.IsInvisible = true
  ctl.Boolean = not ctl.IsInvisible
  end
end
-- Helper function to OK button isInvisible and Boolean
function ToggleEmptyVisibility(control, index, rev, colorTable, msgTable)
  if index >= 1 then
    control[index].IsInvisible = emptyInput[index]
    control[index].Boolean = not emptyInput[index]
    if colorTable then
      control[index].Color = colorTable[index] -- Set color based on sorted colorTable
    end
    if msgTable then
      control[index].String = msgTable[index] -- Set string based on sorted msgTable
    end
    if rev then
      control[index].IsInvisible = true
      control[index].Boolean = false
    end
  end
end
-- Helper function to recalculate maxLenIndex and related variables
function CalculateMaxLenIndex()
  maxLen, maxLenIndex, oldLen = 0, 0, 0
  for i, text in ipairs(Controls.InputText) do
    local newLen = utf8.len(text.String)
    oldLen = oldLen + newLen
    lettercnt = oldLen

    if newLen > maxLen then
      maxLenIndex = i
      maxLen = newLen
    end
  end
  linecnt = maxLen + 1
  --print("maxLenIndex: " .. maxLenIndex, "maxLen: " .. maxLen, "linecnt: " .. linecnt)
  --print("lettercnt: " .. lettercnt, "#scrollLetter: "..#scrollLetter, "scrolltable: "..rapidjson.encode(scrollLetter))
end
--Update Functions
function UpdateScrolling()
  CalculateMaxLenIndex()
  Controls.StartLetter.EventHandler()
  Controls.StartLine.EventHandler()
  Controls.StartEffect.EventHandler()
end
--Update Empty, Col, Msg Table Functions
function UpdateEmptyInput()
  emptyInput = {}  -- Clear the table
  for i, text in ipairs(Controls.InputText) do
    table.insert(emptyInput, text.String == '' and true or false)
  end
  if emptyInitialized then
    table.remove(scrollLetter)
  end
  table.insert(scrollLetter, "")
  emptyInitialized = true

  local sortingTable = {}
  local sortmsgTable = {}
  local sortcolTable = {}

  if #Controls.InputText then
    if sortState == -1 then
      for i = #Controls.InputText, 1, -1 do
        table.insert(sortingTable, emptyInput[i])
        table.insert(sortmsgTable, msgtbl[i])
        table.insert(sortcolTable, coltbl[i])
      end
      sortflg = true
    elseif sortflg == true then
      for i = #Controls.InputText, 1, -1 do
        table.insert(sortingTable, emptyInput[i])
        table.insert(sortmsgTable, msgtbl[i])
        table.insert(sortcolTable, coltbl[i])
      end
      sortflg = false
    else
      for i = 1, #Controls.InputText do
        table.insert(sortingTable, emptyInput[i])
        table.insert(sortmsgTable, msgtbl[i])
        table.insert(sortcolTable, coltbl[i])
      end
    end
  end

  emptyInput = {}  -- Clear the table
  for i, entry in ipairs(sortingTable) do
    table.insert(emptyInput, entry)
  end
  msgtbl = {}
  for i, entry in ipairs(sortmsgTable) do
    table.insert(msgtbl, entry)
  end
  coltbl = {}
  for i, entry in ipairs(sortcolTable) do
    table.insert(coltbl, entry)
  end
  --print("StartEffect.Boolean: "..tostring(Controls.StartEffect.Boolean), "sortflg: "..tostring(sortflg))
  --print("State: "..sortState, #emptyInput, rapidjson.encode(emptyInput))
  --print("State: "..sortState, "msgtbl: "..rapidjson.encode(msgtbl))
  --print("State: "..sortState, "coltbl: "..rapidjson.encode(coltbl))
end
-------------------------------------------------------------------------------------------------------
--MathFloor 0.00
function floor2decimal(num)
  return math.floor(num * 1000) / 1000
end
-- Helper function to update total time and letter/line delays
function UpdateTimesDelays()
  local maxLetterTime, maxLineTime, maxEffectTime, minTime = 0.3, 1.5, 1.5, 0.01
  -- LetterTime
  Controls.LetterTime.Value = math.min(maxLetterTime, math.max(minTime, Controls.LetterTime.Value))
  letterDelay = Controls.LetterTime.Value
  totaltime[1] = (lettercnt + #scrollLetter) * letterDelay
  Controls.TotalTime[1].Value = floor2decimal(totaltime[1])
  -- LineTime
  Controls.LineTime.Value = not Controls.Order.Boolean and math.min(maxLineTime, math.max(minTime, Controls.LineTime.Value)) or math.min(maxLetterTime, math.max(minTime, Controls.LineTime.Value))
  lineDelay = Controls.LineTime.Value
  totaltime[2] = not Controls.Order.Boolean and linecnt * lineDelay or (lettercnt + #scrollLetter) * lineDelay
  Controls.TotalTime[2].Value = floor2decimal(totaltime[2])
  -- EffectTime
  Controls.EffectTime.Value = math.min(maxEffectTime, math.max(minTime, Controls.EffectTime.Value))
  effectDelay = Controls.EffectTime.Value
  totaltime[3] = (lettercnt + #scrollLetter * 2) * effectDelay
  Controls.TotalTime[3].Value = floor2decimal(totaltime[3])

  UpdateScrolling()
end
-- EventHandlers----------------------------------------------------------------------------------
Controls.LetterTime.EventHandler = UpdateTimesDelays
Controls.LineTime.EventHandler = UpdateTimesDelays
Controls.EffectTime.EventHandler = UpdateTimesDelays
--TotalTime EventHanlder
Controls.TotalTime[1].EventHandler = function()
  local minTime = 0.5
  local value = math.max(minTime, Controls.TotalTime[1].Value)
  letterDelay = value / (lettercnt + #scrollLetter)
  Controls.LetterTime.Value = letterDelay
  UpdateTimesDelays()
end
Controls.TotalTime[2].EventHandler = function()
  local minTime = 0.5
  local value = not Controls.Order.Boolean and math.max(minTime, Controls.TotalTime[2].Value) or math.max(minTime, Controls.TotalTime[2].Value)
  lineDelay = not Controls.Order.Boolean and value / linecnt or value / (lettercnt + #scrollLetter)
  Controls.LineTime.Value = lineDelay
  UpdateTimesDelays()
end
Controls.TotalTime[3].EventHandler = function()
  local minTime = 0.5
  local value = math.max(minTime, Controls.TotalTime[3].Value)
  Controls.TotalTime[3].Value = value
  effectDelay = value / lettercnt
  Controls.EffectTime.Value = effectDelay
end
--StartLetter EventHanlder
Controls.StartLetter.EventHandler = function()
  if Controls.StartLetter.Boolean then print("start letter")
    if sortState ~= 1 then
      sortState = 1
      UpdateEmptyInput()
    end
    ScrollingLetterInt()
    ScrollingLetter(letterDelay, Controls.DisplayScrollTextLetter, table.concat(scrollLetter, '\n'))
  else
    ScrollTimer:Stop()
    ScrollingLetterInt()
  end
end
--StartLine EventHanlder
Controls.StartLine.EventHandler = function()
  if not Controls.StartEffect.Boolean then
    if Controls.StartLine.Boolean then print("start line")
      if sortState ~= 1 then
        sortState = 1
        UpdateEmptyInput()
      end
      ScrollingLineInt()

      if Controls.Order.Boolean then
        for index, controlbox in ipairs(Controls.DisplayScrollTextLine) do
          ScrollingLine(lineDelay, Controls.DisplayScrollTextLine[1], 1, Controls.InputText[1].String, Controls.Order.Boolean)
        end

      elseif not Controls.Order.Boolean then
        for index, controlbox in ipairs(Controls.DisplayScrollTextLine) do
          ScrollingLine(lineDelay, controlbox, index, Controls.InputText[index].String, false)
        end
      end

    else
      for _, timer in pairs(ScrollLineTimers) do
        timer:Stop()
      end
      ScrollingLineInt()
    end
  else
    Controls.StartLine.Boolean = false
  end
end
--StarEffect EventHanlder
Controls.StartEffect.EventHandler = function()
  if not Controls.StartLine.Boolean then
    if Controls.StartEffect.Boolean then print("start effect")
      if sortState ~= -1 then
        sortState = -1
        sortflg = true
        UpdateEmptyInput()
      end
      TypewritterInt()

      cIndex = 1
      Typewrite(effectDelay, Controls.InputText[cIndex].String)

    else
      for _, timer in pairs(TypeTimers) do
        timer:Stop()
      end
      TypewritterInt()
    end
  else
    Controls.StartEffect.Boolean = false
  end
end
--InputText EventHandler
for i, text in ipairs(Controls.InputText) do
  scrollLetter[i] = text.String
  text.EventHandler = function()
    local newString = text.String
    if scrollLetter[i] ~= newString then
      scrollLetter[i] = newString
      CalculateMaxLenIndex()
      Controls.LetterTime.EventHandler()
      Controls.LineTime.EventHandler()
      Controls.EffectTime.EventHandler()
      --[[ funciton ~()にして trueなら下記、falseなら何もしないモードをつけても良いかも。
      Controls.StartLetter.Boolean = true
      Controls.StartLine.Boolean = true
      Controls.StartLetter.EventHandler()
      Controls.StartLine.EventHandler()
      --]]
    end
    UpdateEmptyInput()--EmptyInput Search
  end
  --print("scrolltable: " .. rapidjson.encode(scrollLetter))
end
--To Order Sequence Line
Controls.Order.EventHandler = function()
  Controls.TotalTime[2].EventHandler()
end
--Clear EventHandler
for i, ctl in ipairs(Controls.Clear) do
  ctl.EventHandler = function()
    if i == 1 then Controls.StartLetter.Boolean = false --Controls.Clear[1]
    ScrollTimer:Stop() ScrollingLetterInt()
    elseif i == 2 then Controls.StartLine.Boolean = false --Controls.Clear[2]
      for _, timer in pairs(ScrollLineTimers) do
        timer:Stop() end ScrollingLineInt()
    else Controls.StartEffect.Boolean = false --Controls.Clear[3]
      for _, timer in pairs(TypeTimers) do
      timer:Stop() end TypewritterInt()
    end
  end
end
--Lupan Mode
Controls.LupanMode.EventHandler = function()
  Controls.DisplayLupan.IsInvisible = not Controls.LupanMode.Boolean
  Controls.DisplayScrollTextLetter.IsInvisible = Controls.LupanMode.Boolean
  UpdateEmptyInput()
end
--ColorChange EventHanlder
function SetMsgToOK(control)
  for i, str in ipairs(control) do
    Controls.LineOK[i].Color = colors[1]
    Controls.LetterOK[i].Color = colors[1]
    str.EventHandler = function()
      str.String = (str.String == "" or str.String:lower():find("ok") or str.String:lower():find("true")) and "OK"
      or (str.String:lower():find("false")) and "NG"
      or (str.String:lower():find("fault")) and "Fault"
      or (str.String:lower():find("missing")) and "Missing"
      or (str.String == "NG") and "NG"
      or str.String
      Controls.LineOK[i].Color = str.String == "OK" and colors[1] or colors[2]
      Controls.LetterOK[i].Color = str.String == "OK" and colors[1] or colors[2]

      coltbl[i] = Controls.LineOK[i].Color
      msgtbl[i] = Controls.LineEndMsg[i].String
    end
    str.EventHandler()
  end
end
--Colors EventHandler OK, NG
for i, color in ipairs(Controls.Color) do
  color.EventHandler = function()
    local j = i
    if color.String == "" then color.String = colors[j]; color.Color = colors[j] end
    colors[j] = color.String
    color.Color = color.String
    SetMsgToOK(Controls.LineEndMsg)
    SetMsgToOK(Controls.LetterEndMsg)
  end
  color.EventHandler()
end
-- Initialize----------------------------------------------------------------------------------
SetInvisibility(Controls.LineOK)
SetInvisibility(Controls.LetterOK)
SetInvisibility(Controls.LineEndMsg)
SetInvisibility(Controls.LetterEndMsg)
SetMsgToOK(Controls.LineEndMsg)
SetMsgToOK(Controls.LetterEndMsg)
CalculateMaxLenIndex()
--UpdateEmptyInput()
ScrollingLetterInt()
ScrollingLineInt()
TypewritterInt()
Controls.LetterTime.EventHandler()
Controls.LineTime.EventHandler()
Controls.LupanMode.EventHandler()