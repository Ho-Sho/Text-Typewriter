table.insert(ctrls, {
  Name = "InputText",
  ControlType = "Text",
  PinStyle = "Both",
  Count = tonumber(props["Input Texts"].Value),--Change
  UserPin = true,
  DefaultValue = "Sample Text Typewriter"
})
table.insert(ctrls, {
  Name = "DisplayScrollTextLine",
  ControlType = "Text",
  PinStyle = "Both",
  Count = tonumber(props["Input Texts"].Value),--Change
  UserPin = true
})
table.insert(ctrls, {
  Name = "DisplayScrollTextLetter",
  ControlType = "Text",
  PinStyle = "Both",
  Count = 1,
  UserPin = true
})
table.insert(ctrls, {
  Name = "DisplayLupan",
  ControlType = "Text",
  PinStyle = "Both",
  Count = 1,
  UserPin = true
})
table.insert(ctrls, {
  Name = "StartLetter",
  ControlType = "Button",
  ButtonType = "Toggle",
  PinStyle = "Both",
  Count = 1,
  UserPin = true
})
table.insert(ctrls, {
  Name = "StartLine",
  ControlType = "Button",
  ButtonType = "Toggle",
  PinStyle = "Both",
  Count = 1,
  UserPin = true
})
table.insert(ctrls, {
  Name = "StartEffect",
  ControlType = "Button",
  ButtonType = "Toggle",
  PinStyle = "Both",
  Count = 1,
  UserPin = true
})
table.insert(ctrls, {
  Name = "LetterLoop",
  ControlType = "Button",
  ButtonType = "Toggle",
  PinStyle = "Both",
  Count = 1,
  UserPin = true
})
table.insert(ctrls, {
  Name = "LineLoop",
  ControlType = "Button",
  ButtonType = "Toggle",
  PinStyle = "Both",
  Count = 1,
  UserPin = true
})
table.insert(ctrls, {
  Name = "EffectLoop",
  ControlType = "Button",
  ButtonType = "Toggle",
  PinStyle = "Both",
  Count = 1,
  UserPin = true
})
table.insert(ctrls, {
  Name = "LetterOK",
  ControlType = "Button",
  ButtonType = "Toggle",
  PinStyle = "Both",
  Count = tonumber(props["Input Texts"].Value), --Change
  UserPin = true
})
table.insert(ctrls, {
  Name = "LineOK",
  ControlType = "Button",
  ButtonType = "Toggle",
  PinStyle = "Both",
  Count = tonumber(props["Input Texts"].Value),--Change
  UserPin = true
})
table.insert(ctrls, {
  Name = "LetterTime",
  ControlType = "Knob",
  ControlUnit = "Float",
  Min = 0,
  Max = 5,
  PinStyle = "Both",
  Count = 1,
  UserPin = true,
  DefaultValue = 0.05
})
table.insert(ctrls, {
  Name = "LineTime",
  ControlType = "Knob",
  ControlUnit = "Float",
  Min = 0,
  Max = 5,
  PinStyle = "Both",
  Count = 1,
  UserPin = true,
  DefaultValue = 0.05
})
table.insert(ctrls, {
  Name = "EffectTime",
  ControlType = "Knob",
  ControlUnit = "Float",
  Min = 0,
  Max = 5,
  PinStyle = "Both",
  Count = 1,
  UserPin = true,
  DefaultValue = 0.05
})
table.insert(ctrls, {
  Name = "TotalTime",
  ControlType = "Knob",
  ControlUnit = "Float",
  Min = 0,
  Max = 15,
  PinStyle = "Both",
  Count = 3,
  UserPin = true,
  --Default = 4.00
})
table.insert(ctrls, {
  Name = "Clear",
  ControlType = "Button",
  ButtonType = "Trigger",
  PinStyle = "Both",
  Count = 3,
  UserPin = true
})
table.insert(ctrls, {
  Name = "Order",
  ControlType = "Button",
  ButtonType = "Toggle",
  PinStyle = "Both",
  Count = 1,
  UserPin = true,
  DefaultValue = true
})
table.insert(ctrls, {
  Name = "LupanMode",
  ControlType = "Button",
  ButtonType = "Toggle",
  PinStyle = "Both",
  Count = 1,
  UserPin = true,
  --DefaultValue = true
})
table.insert(ctrls, {
  Name = "LetterEndMsg",
  ControlType = "Text",
  PinStyle = "Both",
  Count = tonumber(props["Input Texts"].Value),--Change
  UserPin = true
})
table.insert(ctrls, {
  Name = "LineEndMsg",
  ControlType = "Text",
  PinStyle = "Both",
  Count = tonumber(props["Input Texts"].Value),--Change
  UserPin = true
})
table.insert(ctrls, {
  Name = "Color",
  ControlType = "Text",
  PinStyle = "Both",
  Count = 2,
  UserPin = true,
})