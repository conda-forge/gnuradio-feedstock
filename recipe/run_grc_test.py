import time

# start an Xvfb virtual display if we can (if xvfbwrapper is installed)
try:
    from xvfbwrapper import Xvfb
except (ModuleNotFoundError, ImportError):
    print("Using physical display")
    vdisplay = None
else:
    print("Using Xvfb virtual display")
    vdisplay = Xvfb(width=1024, height=768, colordepth=24)
    vdisplay.start()
    # wait a bit to make sure the virtual display is ready
    time.sleep(1)

try:
    import pathlib
    import tempfile
    import threading

    import gi

    gi.require_version("Gtk", "3.0")
    gi.require_version("PangoCairo", "1.0")
    from gi.repository import GLib
    from gnuradio import gr
    from gnuradio.grc.gui.Platform import Platform
    from gnuradio.grc.gui.Application import Actions, Application

    # include the necessary boilerplate from grc's main function to create the app
    platform = Platform(
        version=gr.version(),
        version_parts=(gr.major_version(), gr.api_version(), gr.minor_version()),
        prefs=gr.prefs(),
        install_prefix=gr.prefix(),
    )
    platform.build_library()

    # pick an example that runs a bunch of qt-gui sinks
    example_grc_path = (
        pathlib.Path(gr.prefix())
        / "share"
        / "gnuradio"
        / "examples"
        / "qt-gui"
        / "qtgui_multi_input.grc"
    )
    app = Application((example_grc_path,), platform)

    # script what we want to try out with the app
    def script(app):
        # ensure the app is initialized before proceeding
        while not app.init:
            time.sleep(1)
        # add a block and undo it
        win = app.get_active_window()
        GLib.idle_add(win.vars.emit, "create_new_block", "analog_noise_source_x")
        GLib.idle_add(Actions.FLOW_GRAPH_UNDO)
        # save the flowgraph to a temporary directory
        file_path = str(pathlib.Path(tempfile.gettempdir(), "grc-test.grc"))
        win.current_page.file_path = file_path
        GLib.idle_add(Actions.FLOW_GRAPH_SAVE)
        # trigger the menu and then cancel it
        GLib.idle_add(win.menu_bar.select_first, False)
        time.sleep(1)
        GLib.idle_add(win.menu_bar.cancel)
        # execute the flowgraph and stop it after some time
        GLib.idle_add(Actions.FLOW_GRAPH_EXEC)
        time.sleep(10)
        GLib.idle_add(Actions.FLOW_GRAPH_KILL)
        time.sleep(1)
        # finally, quit the application
        GLib.idle_add(Actions.APPLICATION_QUIT)

    # start the script in a separate thread
    thread = threading.Thread(target=script, args=(app,))
    # make it a daemon thread so we don't have to wait for it to exit the main thread
    thread.daemon = True
    thread.start()

    app.run()
finally:
    # clean up the virtual display if we used one
    print("cleanup")
    if vdisplay is not None:
        vdisplay.stop()
