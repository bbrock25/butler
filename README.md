Butler
======

Butler is a simple slack bot designed to make your life easier.  He's a swell guy.

## Getting started

Butler needs a slack api token in order to connect to your organization.

    $ export SLACK_API_KEY=your_api_key

Once you've done that you should be able to install your dependencies and fire up your bot.


    $ mix deps.get
    $ iex -S mix

Butler should now be up and running.

Quick sanity check:

send a direct message to your butler bot from your slack, here are a few that
will generate a response (if and only if you have cowsay installed)
'''
butler cowsay I AM THE GIT MASTER
'''

You can investigate the plugin running here in lib/butler/plugins/cowsay.ex
Also, there is another sample plugin under lib/butler/plugins/test_count.ex

That's it!

```
 ________
< enjoy! >
 --------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```
