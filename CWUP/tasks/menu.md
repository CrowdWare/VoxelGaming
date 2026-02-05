# Task Fix Menu Rendering and MenuItem Action

## Context

When starting the Builder the menu behaves incorrectly.

On macOS the File menu is visible but disabled.  
The menu window (menu bar / menu UI) appears twice.  
MenuItem action in UI.sml should be used to trigger the event MenuItemClicked(action).
MenuItem action should be an enum mapped to a stable integer similar to a Windows MenuID.

## Goals

The File menu on macOS is enabled and clickable.  
The menu is shown only once.  
MenuItem action is dispatched as an integer action id.

## Tasks

### Fix disabled File menu on macOS

Identify where the enabled state of menu items is decided.  
A menu item must be enabled when it defines an action.  

Result  
The File menu is enabled.  
Save As, Save and Load can be clicked.  

### Fix duplicated menu (menu appears twice) on macOS

Find all code paths that create or attach the menu. Ensure it is created only once.  
Possibly this stems from adding the actual loaded into the menu, which we don't need.
Ensure the original menu from mac is not altered.  

Result  
The Windows menu is visible exactly once.

### Implement MenuItem action

Extend the UI model to support MenuItem action as enum.  
Map enum values to stable integer ids.  
Dispatch menu clicks via a central menu action handler.  

Result  
Save As triggers its action id.  
