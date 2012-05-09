This is a tiny [Sinatra] [sinatra] app, to serve little badges showing the
current status of a pull request on GitHub: open, merged, or rejected. They're
based on the lovely [Travis CI] [travis] status images. The app is live at
[https://pullstat.us] [site]. You're welcome to use it, or host your own.


### Why is this useful?

I have quite a few forks of popular repos which contain no useful indication of
why they exist. Mostly they're hanging around waiting for a pull request to be
merged into or rejected from the upstream repo. I've started replacing `README`
with a note about why the fork exists, with links to the pull requests in
question. [Here's an example] [example]. This app simply provides little badges
to make these lists more useful.


### How do I use it?

Add the following image to your `README`:

    ![Pull Request #1] (https://​pullstat.us/adammck/pull-status/pull/1)

Obviously, you'll want to replace my name, repo, and pull request number with your own.  
The path is exactly the same as the pull request on GitHub. Just change the domain.


### License

[Pull Status] [repo] is available under the [MIT license] [license].




[site]:    https://pullstat.us
[repo]:    https://github.com/adammck/pull-status
[license]: https://raw.github.com/adammck/pull-status/master/LICENSE
[sinatra]: http://www.sinatrarb.com
[travis]:  http://about.travis-ci.org
[example]: https://github.com/adammck/grit
