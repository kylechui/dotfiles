#!/usr/bin/python3
# Based on https://github.com/cmus/cmus/wiki/cmus_status.py
# Switches to python3, and adds back, forward, and pause buttons
# Requirements:
#  * PyGObject - https://pygobject.readthedocs.io/en/latest/getting_started.html
# Optional (for image display):
#  * Pillow - pip install Pillow
#  * mutagen - pip install mutagen

import gi
import os.path
from subprocess import call
import sys

d = dict(zip(sys.argv[1::2], sys.argv[2::2]))

if d.get('status') != 'playing':
    sys.exit()

gi.require_version('Notify', '0.7')
gi.require_version('GdkPixbuf', '2.0')
from gi.repository import GdkPixbuf, GLib, Notify

title = '{}'.format(
    d.get('title', os.path.basename(
        os.path.splitext(d.get('file', 'Untitled'))[0])
    )
)
display = d.get('artist', 'Unknown Artist')
if d.get('album'):
    display = '{} ({})'.format(display, d.get('album'))

try:
    from io import BytesIO
    from mutagen import File
    from PIL import Image

    temp_image = '/tmp/cmus_album_art.png'
    file = File(d.get('file'))
    try:
        art = BytesIO(file.tags.getall('APIC')[0].data);
    except:
        art = BytesIO(file.pictures[0].data);
    pic = Image.open(art)
    pic.save(temp_image)
    image = GdkPixbuf.Pixbuf.new_from_file(temp_image)
except:
    try:
        # Set a default icon here
        fallback_image_path = '/path/to/notification_icon.png'
        image = GdkPixbuf.Pixbuf.new_from_file(fallback_image_path)
    except:
        image = None


def cmus_callback(notification, action, *args, **kwargs):
    if action == 'next':
        call(['cmus-remote', '-n'])
    elif action == 'prev':
        call(['cmus-remote', '-r'])
    elif action == 'pause':
        call(['cmus-remote', '-u'])

def close_callback(*args, **kwargs):
    main.quit()

notification_timeout = 3000;
Notify.init("cmus-status")
main = GLib.MainLoop()
n = Notify.Notification.new(title, display)
n.set_timeout(notification_timeout)
n.set_urgency(0)
if image:
    n.set_image_from_pixbuf(image)
n.set_hint('transient', GLib.Variant.new_boolean(True))
n.set_hint('suppress-sound', GLib.Variant.new_boolean(True))
n.add_action('prev', 'Previous', cmus_callback, None)
n.add_action('pause', 'Pause', cmus_callback, None)
n.add_action('next', 'Next', cmus_callback, None)
n.connect('closed', close_callback)
n.show()

main.run()
