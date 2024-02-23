This bug demonstrates a focus loop bug in macOS Sonoma 14.3.1 where the 
presence of a focusable control (happens with buttons and textfields) in 
a sidebar alongside a UICollectionView causes the focus loop to get 
stuck in the sidebar, without jumping into the other focus gruops in the
app.

Once the focus loop has been captured in the sidebar, the only way to get
it un-stuck is to ensure that the focus is on the control, then removing 
focus from the window, and refocusing the window. If this jump is done 
while the collection view cell is in focus, the focus loop remains stuck.

This sample app behaves correctly on iPadOS.

FB13648756



https://github.com/bergenco/sidebarFocusBug/assets/51309/3e54adda-9eba-4fbd-9924-781e4cbc826e



https://github.com/bergenco/sidebarFocusBug/assets/51309/ce6d80fc-b984-47b7-a9bb-fa8e4ab918e5

