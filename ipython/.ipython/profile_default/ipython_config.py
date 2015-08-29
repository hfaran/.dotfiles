c = get_config()

# Enable autoreload 2: https://ipython.org/ipython-doc/dev/config/extensions/autoreload.html
c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = ['%autoreload 2']

c.InteractiveShellApp.exec_lines.append('print("=== Interactive configuration from ~/.ipython/profile_default/ipython_config.py follows ===")')
c.InteractiveShellApp.exec_lines.append('print("Warning: disable autoreload in ipython_config.py to improve performance.")')
