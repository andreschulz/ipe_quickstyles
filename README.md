# ipe_quickstyles
Ipelet for quickly saving and selecting styles via hotkeys

## Installation

Copy the lua file into the ipelet directory (`~/.ipe/ipelets/` should work). To find the ipelet directories start ipe and select "show configuration" in the ipe help menu.

## Usage

The ipelet lets you store 5 styles. To store a style press the Shift-key and a number between 1 and 5. The style is then stored under this number. To restore a style, simply press the number.

Currently a style stores:

- stroke color
- fill color
- fillstyle (stroked, filled, filled & stroked)
- line width
- dash style
- front/back arrow heads on/off
- front/back arrow head sizes
- the opacity

The data is stored in a ipe style sheet named *QuickStyle*. This means that you will store all styles within the documents. It is also possible to manually change the styles by editing the style sheet. You can also save the style sheet and add it to another document to transfer the presets. 

The repository contains a [Quickstyles.isy](stylefile) with a preset-set. This might be useful if you run a presentation inside ipe and use the ink tool for annotations. The presets are:

- 1: red pen
- 2: blue pen
- 3: green dashed pen
- 4: highlight marker yellow
- 5: "eraser" (white marker for white background)

## Implementation Details 

The properties for stroke color, fill color, line width, opacity, arrowsize and dashstyle are all assigned to a special color/width/dashstyle/opacity/arrowsize. For each of these properties a new preset name will be defined and the current values will be copied. As a result, if you overwrite a style, all previously drawn elements in this style will get the new definition. Other attributes (fillstyle, arrow heads) are encoded in a special (misused) opacity value. These values wont change if you redefine a style.

## Future plans

I am unsure if it would be a better idea to store the values for colors, width, etc. also inside a fake oppacity value. It would be easy to store more properties with the presets (line caps, arrow head shapes, ...), not sure if this is needed. 

## Updates

- 05/11/18 Added size of arrow and included a preset isy-file
- 05/10/18 First Version
