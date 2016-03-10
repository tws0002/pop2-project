import MMtoKey


mmtokey = MMtoKey.MMtoKey()


def press(markingmenu=None, ctrl=False, shift=False, alt=False, search=0, *args, **kwargs):
    mmtokey.press(markingmenu, ctrl, shift, alt, search)


def release(command=None, language='mel', *args, **kwargs):
    mmtokey.release(command, language)


def pressPreset(ctrl=False, shift=False, alt=False, radial=False, hud=True, section=2, block=3, *args, **kwargs):
    mmtokey.pressPreset(ctrl, shift, alt, radial, hud, section, block)


def releasePreset(*args, **kwargs):
    mmtokey.releasePreset()


def ui():
    mmtokey.ui()