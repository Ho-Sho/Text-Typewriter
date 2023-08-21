local CurrentPage = PageNames[props["page_index"].Value]
local Colors = {
  Black     = {0,0,0}, White = {255,255,255}, White30 = {255,255,255,0.3}, White0 = {255,255,255,0},--White Alpha 1~0.1
  Red       = {255,0,0}, ShureGreen = {178,255,51}, Lime = {0,255,0},
  Gray      = {105,105,105}, Gray50 = {105,105,105,0.5}, DeepBlue = {5,97,165},--Deep Blue
  OffGray   = {124,124,124}, On = {0,139,139},--Dark Cyan
  SteelBlue = {70,130,180},  --Steel Blue
  BackGray  = {102,102,102}, --Normal Background Color
}
local inputtextnum = tonumber(props["Input Texts"].Value)
local display_y = (inputtextnum >= 5) and inputtextnum or 1
local btn, label, space = {size = {40,20}}, {size = {100,20}}, 38
local textbox = {size = {206,38}}
local displaybox = {size = {345, 140+space*(display_y-1)}}
local led, msg = {size = {12,38}}, {size = {46,38}}
local groupbox = {size = {115,38}}
-- Local Functions
local function createGroupBox(text, position, size, color, fill, cornerRadius, strokeColor, strokeWidth, fontSize, hTextAlign)
  table.insert(graphics, {
    Type = "GroupBox",
    Text = text,
    Position = position,
    Size = size,
    Color = color,
    Fill = fill,
    CornerRadius = cornerRadius,
    StrokeColor = strokeColor,
    StrokeWidth = strokeWidth,
    FontSize = fontSize,
    HTextAlign = hTextAlign,
  })
end
local function createText(text, position, size, fill, conerRadius, margin, padding, strokecolor, strokeWidth, textColor, fontSize, hTextAlign, vTextAlign)
  table.insert(graphics, {
    Type = "Text",
    Text = text,
    Position = position,
    Size = size,
    Fill = fill,
    CornerRadius = conerRadius,
    Margin = margin,
    Padding = padding,
    StrokeColor = strokecolor,
    StrokeWidth = strokeWidth,
    TextColor = textColor,
    FontSize = fontSize,
    HTextAlign = hTextAlign,
    VTextAlign = vTextAlign,
  })
end
local function createColorItem(name, prettyName, position)
  return {
    PrettyName = prettyName,
    Style = "Text",
    FontSize = 12,
    Fill = Colors.White,
    StrokeColor = Colors.Gray,
    CornerRadius = 5,
    Margin = 0,
    Padding = 0,
    StrokeWidth = 1,
    Position = position,
    Size = btn.size,
    IsReadOnly = false
  }
end
local function createLayoutItem(name, prettyName, style, position, size, fill, color, offColor, unlink, strokecolor, conerRadius, margin, padding, fontSize, strokeWidth, showTextBox, isReadonly, hTextAlign, vTextAlign, textBoxStyle, btnStyle, zOrder)
  local item = {
    PrettyName = prettyName,
    Style = style,
    Position = position,
    Size = size,
    Fill = fill,
    Color = color,
    OffColor = offColor,
    UnlinkOffColor = unlink,
    StrokeColor = strokecolor,
    CornerRadius = conerRadius,
    Margin = margin,
    Padding = padding,
    FontSize = fontSize or 12,
    StrokeWidth = strokeWidth or 1,
    ShowTextbox = showTextBox,
    IsReadOnly = isReadonly,
    HTextAlign = hTextAlign,
    VTextAlign = vTextAlign,
    TextBoxStyle = textBoxStyle,
    ButtonVisualStyle = btnStyle,
    ZOrder = zOrder,
  }
  if name then layout[name] = item end
  return item
end
-- Main Code
if CurrentPage == "Single-Line" then
  createGroupBox("", {0,0}, {775, 300+space*(inputtextnum -1)}, Colors.Black, Colors.White0, 0, Colors.Black, 0, 12, "Center")
  createGroupBox("", {20,20}, {735,120}, Colors.Black, Colors.White0, 8, Colors.Black, 1, 12, "Center")
  createGroupBox("", {20,170}, {270,100+space*(inputtextnum -1)}, Colors.Black, Colors.White0, 8, Colors.Black, 1, 12, "Center")
  createGroupBox("", {300,170}, {330,100+space*(inputtextnum -1)}, Colors.Black, Colors.White0, 8, Colors.Black, 1, 12, "Center")
  createText("Control", {98,2}, groupbox.size, Colors.White, 10, 0, 0, Colors.Black, 1, Colors.Black, 12, "Center")
  createText("Input Text", {98,150}, groupbox.size, Colors.White, 10, 0, 0, Colors.Black, 1, Colors.Black, 12, "Center")
  createText("Typewriter\nSingleLine Text", {408,150}, groupbox.size, Colors.White, 10, 0, 0, Colors.Black, 1, Colors.Black, 12, "Center")
  --createText(text, position, size, color, conerRadius, margin, padding, strokecolor, strokeWidth, textColor, fontSize, hTextAlign, vTextAlign)
  for i=1, 7 do
    if     i==1 then createText("Processing Order", {52+100*(i-1),48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==2 then createText("Loop On/Off", {52+100*(i-1),48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==3 then createText("Text Speed", {52+100*(i-1),48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==4 then createText("Total Time", {52+100*(i-1),48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==5 then createText("LED OK Color", {52+100*(i-1),48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==6 then createText("Start On/Off", {52+100*(i-1),48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    else             createText("Clear", {52+100*(i-1)+5,48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    end
  end
  for i=1, 7 do
    if     i==1 then createText("Processing Rev\nEffect", {52+100*(i-1),88}, {100,40}, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==2 then createText("Loop On/Off", {52+100*(i-1),88}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==3 then createText("Text Speed", {52+100*(i-1),88}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==4 then createText("Total Time", {52+100*(i-1),88}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==5 then createText("LED NG Color", {52+100*(i-1),88}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==6 then createText("Start Effect On/Off", {52+100*(i-1),88}, {105,20}, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    else             createText("Clear", {52+100*(i-1)+5,88}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    end
  end

  -- System
  for i = 1, 2 do
    layout["Color " .. i] = createColorItem("Color " .. i, (i == 1) and "LED Color at OK" or "LED Color at NG", { 452, 68 + 40* (i-1)})
  end
--name, prettyName, style, position, size, fill, color, offColor, unlink, strokecolor, conerRadius, margin, padding, fontSize, strokeWidth, showTextBox, isReadonly, hTextAlign, vTextAlign, textBoxStyle, btnStyle, zOrder
  for i= 1, inputtextnum do
  layout["InputText "..i] = createLayoutItem("InputText "..i, "Input Text "..i, "Text", {52,207 + space*(i-1)}, textbox.size, nil, Colors.White30, nil, nil, Colors.OffGray, 5, 0, 10, 14)
  layout["DisplayScrollTextLine "..i] = createLayoutItem("DisplayScrollTextLine "..i, "Diplay Single Line Text "..i, "Text", {332,207 + space*(i-1)}, textbox.size, nil, Colors.White0, nil, nil, Colors.Gray, 5, 0, 10, 14, 0, nil, nil, "Left", nil, "NoBackground")
  layout["LineOK "..i] = createLayoutItem("LineOK "..i, "Line LED "..i, "Button", {538,207 + space*(i-1)}, led.size, nil, Colors.White30, nil, nil, Colors.Gray, 0, 2, 0, 14, 0, nil, nil, nil, nil, nil, "Flat")
  layout["LineEndMsg "..i] = createLayoutItem("LineEndMsg "..i, "Line Msg "..i, "Text", {553,207 + space*(i-1)}, msg.size, nil, Colors.White0, nil, nil, Colors.Gray, 0, 0, 0, 14, 0, nil, nil, "Center", nil, "NoBackground")
    if i == 1 then
    layout["InputText"] = createLayoutItem("InputText", "Input Text", "Text", {52,207 + space*(i-1)}, textbox.size, nil, Colors.White30, nil, nil, Colors.OffGray, 5, 0, 10, 14)
    layout["DisplayScrollTextLine"] = createLayoutItem("DisplayScrollTextLine", "Diplay Single Line Text", "Text", {332,207 + space*(i-1)}, textbox.size, nil, Colors.White0, nil, nil, Colors.Gray, 5, 0, 10, 14, 0, nil, nil, "Left", nil, "NoBackground")
    layout["LineOK"] = createLayoutItem("LineOK", "Line LED", "Button", {538,207 + space*(i-1)}, led.size, nil, Colors.White30, nil, nil, Colors.Gray, 0, 2, 0, 14, 0, nil, nil, nil, nil, nil, "Flat")
    layout["LineEndMsg"] = createLayoutItem("LineEndMsg", "Line Msg", "Text", {553,207 + space*(i-1)}, msg.size, nil, Colors.White0, nil, nil, Colors.Gray, 0, 0, 0, 14, 0, nil, nil, "Center", nil, "NoBackground")
    end
  end
  --LayoutItem(name, prettyName, style, position, size, fill, color, offColor, unlink, strokecolor, conerRadius, margin, padding, fontSize, strokeWidth, showTextBox, isReadonly, hTextAlign, vTextAlign, textBoxStyle, btnStyle, zOrder)
  layout["StartLine"] = createLayoutItem("StartLine", "Start Single Line", "Button",{552,68},btn.size, nil, Colors.On, Colors.OffGray, true, Colors.Gray, 2, 2, 0)
  layout["Order"] = createLayoutItem("Order", "Processing Order", "Button",{52,68},btn.size, nil, Colors.On, Colors.OffGray, true, Colors.Gray, 2, 2, 0)
  layout["LineLoop"] = createLayoutItem("LineLoop", "Single Line Loop", "Button",{152,68},btn.size, nil, Colors.On, Colors.OffGray, true, Colors.Gray, 2, 2, 0)
  layout["Clear 2"] = createLayoutItem("Clear 2", "Clear Single Line", "Button",{658,68},btn.size, nil, Colors.White, Colors.SteelBlue, true, Colors.Gray, 2, 2, 0)
  layout["LineTime"] = createLayoutItem("LineTime", "Single Text Speed", "Text", {252,68}, btn.size, nil, Colors.SteelBlue, nil, nil, Colors.Gray, 5, 0, 0)
  layout["TotalTime 2"] = createLayoutItem("TotalTime 2", "Single Line TotalTime", "Text", {352,68}, btn.size, nil, Colors.SteelBlue, nil, nil, Colors.Gray, 5, 0, 0)

  layout["StartEffect"] = createLayoutItem("StartEffect", "Start Single Effect Line", "Button",{552,108},btn.size, nil, Colors.On, Colors.OffGray, true, Colors.Gray, 2, 2, 0)
  layout["EffectLoop"] = createLayoutItem("EffectLoop", "Single Effect Line Loop", "Button",{152,108},btn.size, nil, Colors.On, Colors.OffGray, true, Colors.Gray, 2, 2, 0)
  layout["Clear 3"] = createLayoutItem("Clear 3", "Clear Effect Line", "Button",{658,108},btn.size, nil, Colors.White, Colors.SteelBlue, true, Colors.Gray, 2, 2, 0)
  layout["EffectTime"] = createLayoutItem("EffectTime", "Single Effect Text Speed", "Text", {252,108}, btn.size, nil, Colors.SteelBlue, nil, nil, Colors.Gray, 5, 0, 0)
  layout["TotalTime 3"] = createLayoutItem("TotalTime 3", "Single Effect Line TotalTime", "Text", {352,108}, btn.size, nil, Colors.SteelBlue, nil, nil, Colors.Gray, 5, 0, 0)

elseif CurrentPage == "Multi-Line" then
  -----------------------text, position, size, color, fill, cornerRadius, strokeColor, strokeWidth, fontSize, hTextAlign, vTextAlign
  createGroupBox("", {0,0}, {775, 400+space*(display_y -1)}, Colors.Black, Colors.White0, 0, Colors.Black, 0, 12, "Center")
  createGroupBox("", {20,20}, {735,120}, Colors.Black, Colors.White0, 8, Colors.Black, 1, 12, "Center")
  createGroupBox("", {20,170}, {270,210+space*(display_y -1)}, Colors.Black, Colors.White0, 8, Colors.Black, 1, 12, "Center")
  createGroupBox("", {300,170}, {455,210+space*(display_y -1)}, Colors.Black, Colors.White0, 8, Colors.Black, 1, 12, "Center")
  --createGroupBox("", {766,170}, {455,210+space*(display_y -1)}, Colors.Black, Colors.White0, 8, Colors.Black, 1, 12, "Center")
  createText("Control", {98,2}, groupbox.size, Colors.White, 10, 0, 0, Colors.Black, 1, Colors.Black, 12, "Center")
  createText("Input Text", {98,150}, groupbox.size, Colors.White, 10, 0, 0, Colors.Black, 1, Colors.Black, 12, "Center")
  createText("Typewriter\nMultiLine Text", {473,150}, groupbox.size, Colors.White, 10, 0, 0, Colors.Black, 1, Colors.Black, 12, "Center")
  --createText("LupanMode", {939,150}, groupbox.size, Colors.White, 10, 0, 0, Colors.Black, 1, Colors.Black, 12, "Center")
  for i=1, 6 do
    if     i==1 then createText("Lupan Mode", {52+100*(i-1),48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==2 then createText("Loop On/Off", {52+100*(i-1),48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==3 then createText("Text Speed", {52+100*(i-1),48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==4 then createText("Total Time", {52+100*(i-1),48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    elseif i==5 then createText("LED OK Color", {52+100*(i-1),48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    else             createText("Start On/Off", {52+100*(i-1)+100,48}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
    end
  end
  createText("LED NG Color", {452,88}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")
  createText("Clear", {652,88}, label.size, nil, 0, 0, 0, Colors.Black, 0, Colors.Black, 12, "Left")

  -- System
  for i = 1, 2 do
    layout["Color " .. i] = createColorItem("Color " .. i, (i == 1) and "LED Color at Start" or "LED Color at End", { 452, 68 + 40* (i-1)})
  end

  for i= 1, inputtextnum do
  layout["InputText "..i] = createLayoutItem("InputText "..i, "Input Text "..i, "Text", {52,207 + space*(i-1)}, textbox.size, nil, Colors.White30, nil, nil, Colors.OffGray, 5, 0, 10, 14)
  layout["LetterOK "..i] = createLayoutItem("LetterOK "..i, "MultiLine LED "..i, "Button", {666,207 + space*(i-1)}, led.size, nil, Colors.White30, nil, nil, Colors.Gray, 0, 2, 0, 14, 0, nil, nil, nil, nil, nil, "Flat")
  layout["LetterEndMsg "..i] = createLayoutItem("LetterEndMsg "..i, "MultiLine Msg "..i, "Text", {681,207 + space*(i-1)}, msg.size, nil, Colors.White0, nil, nil, Colors.Gray, 0, 0, 0, 14, 0, nil, nil, "Center", nil, "NoBackground")
    if i == 1 then
    layout["InputText"] = createLayoutItem("InputText", "Input Text", "Text", {52,207 + space*(i-1)}, textbox.size, nil, Colors.White30, nil, nil, Colors.OffGray, 5, 0, 10, 14)
    layout["LetterOK"] = createLayoutItem("LetterOK", "MultiLine LED", "Button", {666,207 + space*(i-1)}, led.size, nil, Colors.White30, nil, nil, Colors.Gray, 0, 2, 0, 14, 0, nil, nil, nil, nil, nil, "Flat")
    layout["LetterEndMsg"] = createLayoutItem("LetterEndMsg", "MultiLine Msg", "Text", {681,207 + space*(i-1)}, msg.size, nil, Colors.White0, nil, nil, Colors.Gray, 0, 0, 0, 14, 0, nil, nil, "Center", nil, "NoBackground")
    end
  end
--LayoutItem(name, prettyName, style, position, size, fill, color, offColor, unlink, strokecolor, conerRadius, margin, padding, fontSize, strokeWidth, showTextBox, isReadonly, hTextAlign, vTextAlign, textBoxStyle, btnStyle, zOrder)
--layout["DisplayLupan"] = createLayoutItem("DisplayLupan", "Diplay Lupan Text", "Text", {321,207}, displaybox.size, {240,240,241}, nil, nil, nil, Colors.Gray, 5, 0, 10, 52, 0, nil, nil, "Center", nil, "NoBackground")--{825,207}
  layout["DisplayScrollTextLetter"] = createLayoutItem("DisplayScrollTextLetter", "Diplay Multi Line Text", "Text", {321,207}, displaybox.size, nil, Colors.White0, nil, nil, Colors.Gray, 5, 0, 5, 18, 0, nil, nil, "Left", "Top", "NoBackground", 0)
  layout["StartLetter"] = createLayoutItem("StartLetter", "Start Mutil Line","Button",{652,68},btn.size, nil, Colors.On, Colors.OffGray, true, Colors.Gray, 2, 2, 0)
  layout["LupanMode"] = createLayoutItem("LupanMode", "Lupan Mode", "Button",{52,68},btn.size, nil, Colors.On, Colors.OffGray, true, Colors.Gray, 2, 2, 0)
  layout["LetterLoop"] = createLayoutItem("LetterLoop", "Multi Line Loop", "Button",{152,68},btn.size, nil, Colors.On, Colors.OffGray, true, Colors.Gray, 2, 2, 0)
  layout["Clear 1"] = createLayoutItem("Clear 1", "Clear Multi Line", "Button",{652,108},btn.size, nil, Colors.White, Colors.SteelBlue, true, Colors.Gray, 2, 2, 0)
  layout["LetterTime"] = createLayoutItem("LetterTime", "Multi Text Speed", "Text", {252,68}, btn.size, nil, Colors.SteelBlue, nil, nil, Colors.Gray, 5, 0, 0)
  layout["TotalTime 1"] = createLayoutItem("TotalTime 1", "Multi Line TotalTime", "Text", {352,68}, btn.size, nil, Colors.SteelBlue, nil, nil, Colors.Gray, 5, 0, 0)
  layout["DisplayLupan"] = createLayoutItem("DisplayLupan", "Diplay Lupan Text", "Text", {321,207}, displaybox.size, nil, {240,240,241}, nil, nil, Colors.Gray, 5, 0, 10, 52, 0, nil, nil, "Center", nil, 5)--{825,207}

elseif CurrentPage == "Help" then
---------text, position, size, color, fill, cornerRadius, strokeColor, strokeWidth, fontSize, hTextAlign, vTextAlign
  createGroupBox("", {0,0}, {775,585}, Colors.Black, Colors.White0, 0, Colors.Black, 0, 12, "Center")
  createGroupBox("", {20,20}, {735,545}, Colors.Black, Colors.White0, 8, Colors.Black, 1, 12, "Center")
  createText("Help", {98,2}, groupbox.size, Colors.White, 10, 0, 0, Colors.Black, 1, Colors.Black, 12, "Center")
local HelpText = [[

  ■Loop button
    On  -> When on, the character string that has finished processing will start processing again.
    Off => When the process is finished, the Start button will be turned off.
  ■Text Speed
    Float value from 0.01 to 5sec.
    Smaller values are processed faster.
  ■Total Time
    Float value from 0 to 15sec.
    The time from when text processing started until it finished.
    It changes depending on the number of characters in Text Time and InputText.
  ■LED Color
    The color of the LED displayed when processing is finished.
    OK color when the Line/MultiLine Msg Pin's String is "OK","true". Otherwise, it will be NG color. it's usually OK color.
    The LED will be NG color, but you can enter anything other than "OK" and it will be displayed when the process is completed.

  🔴Single Line tab
  ■Processing Order
    On  -> Scrolls the text entered in the Input text in order like a typewriter.
    Off -> Starts scrolling the text entered in Enter text all at once.
  ■Processing Rev Effect
    The text is displayed one character at a time, and when the end of the line is reached, it moves to the next line below.

  🔵Multi Line tab
  ■Lupan Mode
    On  -> Like the opening of Lupine's anime, characters are displayed one by one, and finally all the characters are displayed.
    Off -> InputText 1 to i are concatenated, and each InputText is inserted into a new line and
    scrolled in a multi-line style like a typewriter.
    ★The Lupine mode display frame and the multiline display frame are placed in the same place with IsInvisible true/false.
    A multiline text frame can have the Vertical Alignment changed to
    Bottom, Top, or Center, which has the effect of displaying the characters bottom-to-top, center-to-top, and top-to-bottom.

  *Known Issues: If the InputText includes nil, after performing the Effect Process,
    performing the Order Process causes the sequence of LEDs for the nil portion of the input text
    to become reversed and not correctly invisible.
    The opposite process is also the same. If nil is not included, there doesn't seem to be an issue. I can't come up with a solution.
    ]]
  createText(HelpText, {38,40}, {700,525}, nil, 10, 0, 20, Colors.Black, 0, Colors.Black, 12, "Left", "Top")
end