from libqtile.config import Key, Screen, Group
from libqtile.command import lazy
from libqtile import layout, bar, widget

import socket

laptop = True

keys = [
    Key(
        ["mod1"], "k",
        lazy.layout.down()
    ),
    Key(
        ["mod1"], "j",
        lazy.layout.up()
    ),
    Key(
        ["mod1", "control"], "k",
        lazy.layout.shuffle_down()
    ),
    Key(
        ["mod1", "control"], "j",
        lazy.layout.shuffle_up()
    ),
    Key(
        ["mod1"], "space",
        lazy.layout.next()
    ),
    Key(
        ["mod1", "shift"], "space",
        lazy.layout.rotate()
    ),
    Key(
        ["mod1", "shift"], "Return",
        lazy.layout.toggle_split()
    ),
    Key(["mod1"], "h",      lazy.to_screen(1)),
    Key(["mod1"], "l",      lazy.to_screen(0)),
    Key(["mod4"], "Return", lazy.spawn("urxvt")),
    Key(["mod1"], "Tab",    lazy.nextlayout()),
    Key(["mod1"], "w",      lazy.window.kill()),
    Key(["mod4"], "p", lazy.spawn("dmenu_run")),

    Key(["mod1", "control"], "r", lazy.restart()),
]

groups = [
    Group("a"),
    Group("s"),
    Group("d"),
    Group("f"),
    Group("u"),
    Group("i"),
    Group("o"),
    Group("p"),
]
for i in groups:
    keys.append(
        Key(["mod1"], i.name, lazy.group[i.name].toscreen())
    )
    keys.append(
        Key(["mod1", "shift"], i.name, lazy.window.togroup(i.name))
    )

dgroups_key_binder = None
dgroups_app_rules = []

layouts = [
    layout.Max(),
    layout.Stack(stacks=2)
]

list_widget = [
    widget.GroupBox(font="Envy Code R"),
    widget.WindowName(font="Envy Code R"),
    widget.CPUGraph(),
    widget.MemoryGraph(),
    widget.Notify(font="Envy Code R"),
    widget.TextBox(socket.gethostname(), font="Envy Code R"),
    widget.Systray(),
    widget.Clock('%Y-%m-%d %a %R', font="Envy Code R"),
]

if laptop:
    list_widget.extend([widget.Battery(format="{percent:2.0%}"),
                       widget.BatteryIcon()])

screens = [Screen(bottom=bar.Bar(list_widget, 28,), ), ]

main = None
follow_mouse_focus = True
cursor_warp = False
floating_layout = layout.Floating()
mouse = ()
auto_fullscreen = True
widget_defaults = {}
