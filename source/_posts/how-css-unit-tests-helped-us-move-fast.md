---
title: "How CSS unit tests helped\_us move\_fast"
author: Tomek Wiszniewski
author_url: 'https://github.com/architectcodes'
cover: /img/machinery
date: 2016-05-13 13:25:05
---


The way you manage styles can make or break a long-running web project. Keeping things modular helps a great deal, but that’s only part of the solution.

Six months ago we had a go at setting up CSS unit tests for our UI components. Brilliant decision, as it turns out! Since then, our job is a lot nicer. The speed of development is fast and steady. Each of us on the team is now coding with confidence, without the fear that things might unexpectedly break.

And here’s how we did it:

<!-- more -->



{% raw %}<a id="/our-story"></a>{% endraw %}

## Our tale

Let’s start with a story. Over a year ago I started developing a UI framework. Initially, it was similar in scope and stack to Twitter Bootstrap. A LESS monolith with around 20 well-documented, kinda-independent components – some of them sprinkled with a pinch of JS. Development went really smoothly at first. We quickly shipped a successful prototype, very well received. We ended up with another contract for developing the long-term project itself.

With another big goal down the line, we faced scaling our framework way over what we then had. To meet a tight deadline, we took other developers on the team. After all, a bigger team means that things go faster – that’s how it’s supposed to work, isn’t it?

Well, not in our case. As soon as more people laid their hands on the project, serious problems began.

{% pullquote %}
When your team grows,  
CSS gets hairy
{% endpullquote %}

{% raw %}<a id="/our-story/regressions"></a>{% endraw %}

“Why is this CSS rule here? What happens if I change it? Looks good in this view, should be okay.” That was the way we used to develop our components. One of them created back then by an external contributor has been a source of countless bugs over the last months. No-one knows what his CSS was meant to do and what to pay attention to when changing it. Whenever one of us has to extend that component, he has to summon all his courage and pick the only choice he has. It’s a very brittle way, which we call…

{% pullquote %}
“poking around  
until it works.”
{% endpullquote %}

Even if the change works well in one test view, we have no way of knowing if it doesn’t break another view or the live app itself.

{% raw %}<a id="/our-story/fat-stylesheets"></a>{% endraw %}

The uncertainty of the poking-around approach leads to another problem – stylesheets growing fat over time. “Why is this CSS rule here? This view looks good if I change it, but what if the change breaks another view? I’d better add a new class and use the new one instead.” Everyone keeps adding stuff to the CSS, rather than reusing, optimizing or cleaning up existing code. There are some [stunning numbers](#/slim-stylesheets/numbers) related to this at the end of the article.

<p class="text-center"><figure><img class="img-responsive"
  src="/post-images/stacking-foam-blocks.gif"
  alt="Video of a guy stacking giant foam blocks in a warehouse"
/><figcaption>Source: giphy.com</figcaption></figure></p>




{% raw %}<a id="/a-step-back"></a>{% endraw %}

## A step back

Before we see the solution, let’s take a broader look at the problem itself. CSS was originally designed to power simple websites – and it’s a wonderful tool for that. It’s amazing, how quickly you can get up and running creating beautiful UI nuggets, which work across all platforms and devices. Just a few lines of CSS make a pretty decent button:

<iframe src="https://jsfiddle.net/27eb7a01/1/embedded/css,html,result" style="border: none; width: 100%; height: 13em"></iframe>

But since CSS appeared in 1996, the web has changed beyond recognition. We’re now delivering full-blown apps with beautiful, immersive user experiences. Like never before, we’re living the “write once, run anywhere” dream. Web apps [run without installation][step-back.A] on any device and adapt to the size of the screen, network availability, user permissions, pointing device, viewing mode, browser support and other factors.

[step-back.A]: /good-quotes/#/web-best-app-delivery-platform "The web as an app delivery platform"

{% pullquote %}
A modern web frontend  
has zillions of moving parts
{% endpullquote %}

The price for all this awesomeness is complexity. Countless moving parts which we have to wire up and keep synchronized. And let’s face it – despite web standards moving forward at breakneck speed today, the building blocks that power our apps are still good old HTML, CSS and JavaScript. Technologies designed for simple websites in the mid-nineties.

Let’s focus on CSS. We all know the [problems with CSS at scale][step-back.C]. We know the feeling when you discover a visual bug caused by that line of CSS changed weeks ago at the other end of your app. We know how much harder it gets with every new member on the team.

[step-back.C]: https://speakerdeck.com/vjeux/react-css-in-js?slide=2 "CSS in JS — by Christopher Chedeau"

<p class="text-center"><figure><img class="img-responsive"
  src="/post-images/simpsons-jenga.gif"
  alt="CSS at scale is like Bart Simpson playing Jenga"
  width="500"
  height="281"
/><figcaption>Source: giphy.com</figcaption></figure></p>

Brilliant folks keep coming up with [loads][step-back.B2] [of][step-back.B3] [brilliant][step-back.B4] [solutions][step-back.B5] to many of these problems. We are learning to [write our styles in a modular way][step-back.B6], not needing to worry about the global namespace anymore. We’re learning to [share variables and logic between CSS and JS][step-back.B1]. All this improves scalability – but it’s just part of the solution. Just as the arrival of modules to JavaScript didn’t magically make our apps well-organized and bug-free, modular CSS isn’t a cure for everything.

[step-back.B1]: https://git.io/jss-lite-loader#/usage/code-sharing "A css-in-js webpack loader – architectcodes/jss-lite-loader"
[step-back.B2]: https://github.com/jsstyles/jss "A lib for generating Style Sheets with JavaScript – jsstyles/jss"
[step-back.B3]: https://github.com/krasimir/cssx "CSS in JavaScript – krasimir/cssx"
[step-back.B4]: https://github.com/css-modules/css-modules "A CSS file in which all names are scoped locally by default – css-modules/css-modules"
[step-back.B5]: https://github.com/rtfeldman/elm-css "Elm CSS preprocessor that lets you use union types rather than Strings for your classes and IDs – rtfeldman/elm-css"
[step-back.B6]: http://chrispearce.co/elephants-the-three-code-ilities-two-months-with-css-modules/ "Elephants, The Three Code Ilities, & Two Months With CSS Modules — by Chris Pearce"




{% raw %}<a id="/moving-fast"></a>{% endraw %}

## Moving fast

The key to moving fast is to embrace change – or even [drive change][moving-fast.A]. Move forward with confidence, without looking back.

[moving-fast.A]: https://vimeo.com/91537336 "Bringing Change to Life — by Bill Scott"

{% blockquote Eric Elliott https://medium.com/javascript-scene/how-to-build-a-high-velocity-development-team-4b2360d34021 How to build a high-velocity development team %}
Eradicate your team’s fear of change.  
This should be **priority number one** until nobody  
worries about changing a line of code again.
{% endblockquote %}

Facebook [used to say “move fast and break things”][moving-fast.C] – but a couple of years ago they announced in a famous keynote: “Breaking things wasn’t helping us to move faster, because we had to slow down to fix these bugs and it wasn't improving our speed”. Following this conclusion, they changed their motto to “move fast with stable infra”.

[moving-fast.C]: http://mashable.com/2014/04/30/facebooks-new-mantra-move-fast-with-stability/#BryYX_gAQsqq "Facebook Changes Its ‘Move Fast and Break Things’ Motto — at Mashable"

<p class="text-center"><figure><img class="img-responsive"
  src="/post-images/move-fast-with-stable-infra.jpg"
  alt="Mark Zuckerberg saying “move fast with stable infra”"
  width="794"
  height="459"
/><figcaption>Source: facebook</figcaption></figure></p>

But what exactly does it mean to “not look back”? What exactly does “stable infra” mean? How to make sure nobody worries about changing code? Eric Elliott gives us another hint in his [series of][moving-fast.B2] [thought-provoking articles][moving-fast.B1]:

[moving-fast.B1]: https://medium.com/javascript-scene/what-every-unit-test-needs-f6cd34d9836d "5 Questions Every Unit Test Must Answer"
[moving-fast.B2]: https://medium.com/javascript-scene/how-to-build-a-high-velocity-development-team-4b2360d34021 "How to build a high-velocity development team"

{% blockquote Eric Elliott https://medium.com/javascript-scene/how-to-build-a-high-velocity-development-team-4b2360d34021 How to build a high-velocity development team %}
**Write automated tests**  
for every feature  
and every bug fix.
{% endblockquote %}

We definitely found this to be true with libraries doing business logic.

Heavy refactoring. Taking new people on the team. A major rebase. Swapping out a dependency. Getting rid of dead code. Resurrecting code months after the last commit. Handing projects over. These things happen day to day in an environment of constant change. Without unit tests, you might be facing days, weeks or even months of tedious work. But when a good suite of unit tests has your back, each of these is a breeze.

But what about CSS? How is it possible to keep a similar pace of development there?




{% raw %}<a id="/heres-how"></a>{% endraw %}

## Here’s how

Writing unit tests for CSS is a lot easier than it looks. If you’ve already written these for other languages, you’ll feel right at home.

This section is structured like a simple tutorial – feel free to follow along or play around with the live snippets. Just make sure you’re using an up-to-date version of Chrome or Firefox. At the end of the article, I’ll explain how to run the tests headlessly and get the workflow more automated.

Our task is to solve the perennial problem of [centering an element within its parent both horizontally and vertically][heres-how.B1]. We’ll do this in a test-driven manner and go on to see how this helps keep a steady pace of development in a UI-heavy project.

[heres-how.B1]: http://stackoverflow.com/questions/14123999/center-a-div-horizontally-and-vertically "Center a DIV horizontally and vertically – on StackOverflow"

First of all, let’s install the [good and simple][heres-how.A1] test library [*tape*][heres-how.A2]. You could do this all with *tape* itself, but we’ve written a kinda-plugin for it to make CSS unit tests much more elegant: [*tape-css*][heres-how.A3]. Let’s install that as well. The last tool we need is [*hyperscript*][heres-how.A5] – it’ll help us create test DOM trees more conveniently. So here’s our test boilerplate, along with a sample test and assertion:

[heres-how.A1]: https://medium.com/javascript-scene/why-i-use-tape-instead-of-mocha-so-should-you-6aa105d8eaf4 "Why I use Tape Instead of Mocha & So Should You"
[heres-how.A2]: https://github.com/substack/tape "tap-producing test harness for node and browsers – substack/tape"
[heres-how.A3]: https://git.io/tape-css "CSS unit testing. Lightning-fast. tape-style – git.io/tape-css"
[heres-how.A5]: https://github.com/dominictarr/hyperscript "Create HyperText with JavaScript – dominictarr/hyperscript"

<iframe src="https://jsfiddle.net/3w6aun36/4/embedded/js,result" style="border: none; width: 100%; height: 15.5em"></iframe>

Now, let’s make sure we know exactly what our element should do.

* `.parent` should take up the whole width and height of its container.
* `.child` should grow and shrink to fit its contents.
* `.child` should be centered horizontally within its `.parent`.
* `.child` should be centered vertically within its `.parent`.

Let’s translate this to tests, which will automatically make sure our requirements are met. Since we’ll be working a lot with [positioning][heres-how.E], let’s define a simple helper function for that:

[heres-how.E]: https://twitter.com/barneycarroll/status/728616021939064832 "The weirdness of getBoundingClientRect – by @barneycarroll"

<iframe src="https://jsfiddle.net/5ypbnuk9/2/embedded/js" style="border: none; width: 100%; height: 8em"></iframe>

Now we have that covered, we can write the tests themselves:

<iframe src="https://jsfiddle.net/5ypbnuk9/4/embedded/js,result" style="border: none; width: 100%; height: 50em"></iframe>

By the way, we’ve just done a very healthy thing – we’re thinking about *what* we want to do before we actually do it.

If you switched to the *Result* tab above, you surely noticed that our tests fail. No wonder – we haven’t written any styles yet! Let’s do it right now. To keep things simple, we’ll write the styles as a raw string right inside our test file. In the real world, you’d probably want to import them from a CSS module, a raw CSS file, or a preprocessor like [JSS][heres-how.C] or LESS. There we go:

[heres-how.C]: https://github.com/jsstyles/jss "A lib for generating Style Sheets with JavaScript – jsstyles/jss"

<iframe src="https://jsfiddle.net/spsv13sa/embedded/js" style="border: none; width: 100%; height: 19.5em"></iframe>

Now let’s wire that up with all we’ve written so far. Et voilà! Our component is ready.

<iframe src="https://jsfiddle.net/5ypbnuk9/5/embedded/result,js" style="border: none; width: 100%; height: 20em"></iframe>




{% raw %}<a id="/how-it-works"></a>{% endraw %}

## Whoah! How does that work?

[*tape-css*][heres-how.A3] is a thin API wrapper over [*tape*][heres-how.A2] which adds two additional options to the original config of the `test` function: `dom` and `styles`. *tape-css* will take the `dom` element along with all its ancestors and add it to the `<body>` before the test begins. It’ll also clean up by removing the element after the test has ended. `styles` work very similarly – they are added as a `<style>` element to the `<head>` before the test and cleaned up after the test ends.

Since *tape* prints [TAP output][how-it-works.B1] to the JS console, it’s very easy to process in different ways. If you want to check out what the raw TAP stream looks like, go ahead and open your browser console. Right now! You should see the raw TAP results of our test above. Pretty cool, isn’t it? We’ve used [*tap-browser-el*][how-it-works.B2] to format the results in the live snippets, but you can also make TAP pretty [directly in the browser console][how-it-works.B3] and [in the terminal][how-it-works.B4].

[how-it-works.B1]: https://en.wikipedia.org/wiki/Test_Anything_Protocol "Test Anything Protocol – on Wikipedia"
[how-it-works.B2]: https://github.com/Jam3/tap-browser-el "A tap reporter which adds an element to the DOM – Jam3/tap-browser-el"
[how-it-works.B3]: https://github.com/Jam3/tap-dev-tool "Prettify TAP in the browser's console – Jam3/tap-dev-tool"
[how-it-works.B4]: https://github.com/scottcorgan/tap-spec "Formatted TAP output like Mocha's spec reporter – scottcorgan/tap-spec"

Speaking of the terminal, there are also multiple ways to run CSS test in a fast headless environment, directly from your terminal. The best tool I’ve found for this is [*tape-run*][how-it-works.C1]. It starts a lightning-fast instance of *electron*, directs the output to the console and gives you a `0`/`1` exit code. All within a fraction of a second! You can also use *tape-run* to run your tests in any good old traditional browsers installed on your system or CI server, such as *Chrome* or *IE*.

[how-it-works.C1]: https://github.com/juliangruber/tape-run "Headless tape test runner – juliangruber/tape-run"

Come to think of it. You once had to click through your whole app in different browsers to look for visual errors. Well, with unit tests you no longer have to! All you need is push your changes and a CI server like [Travis][how-it-works.D1] can do all the heavy testing for you. If anything goes wrong, you get an email notification with a detailed bug report from your unit tests. Because…

[how-it-works.D1]: https://travis-ci.org/ "Travis CI"

{% blockquote Eric Elliott, https://medium.com/javascript-scene/what-every-unit-test-needs-f6cd34d9836d
5 Questions Every Unit Test Must Answer %}
…a failing test should read  
like a high-quality bug report.
{% endblockquote %}

All that happens in the background, before it has a chance to affect any users. Now we can really move fast and confidently.

Pretty cool, isn’t it?

<p class="text-center"><figure><img class="img-responsive"
  src="/post-images/brent-rambo.gif"
  alt="“Brent Rambo approves” in an Apple ad from the early 90s"
  width="320"
  height="240"
/><figcaption>Source: imgur.com</figcaption></figure></p>




{% raw %}<a id="/regressions"></a>{% endraw %}

## No more regressions

Remember the [first problem with CSS at scale](#/our-story/regressions) I mentioned? In my experience, regressions are common in a traditional CSS project led by a bigger team. Let’s see how unit tests help rule them out.

See that `float: left` line in our test? Doesn’t seem very logical, does it? If I saw that in a project I were to clean up, I bet I’d think it’s an old leftover. So let’s try to take out the `float` out:

<iframe src="https://jsfiddle.net/5ypbnuk9/6/embedded/result,js" style="border: none; width: 100%; height: 25em"></iframe>

Amazing, isn’t it? The tests not only spotted a problem, but also told us what the problem is! If you want to investigate it yourself with developer tools, change the second `test(…)` call to `test.only(…)` – you can find the rendered DOM right inside your `<body>`.

By writing CSS unit tests each of us can tell others exactly what he meant to achieve with his styles.




{% raw %}<a id="/slim-stylesheets"></a>{% endraw %}

## No more fat stylesheets

I mentioned [another problem](#/our-story/fat-stylesheets) at the beginning of the article. Remember that guy stacking foam blocks? When people need new features, they just keep adding things to the CSS, instead of reusing what’s already there.

So let’s see how our CSS unit tests help us keep our stylesheets lean.

Say, the designer comes to us with the next cool thing on his mind. Now we need not one element centered within a parent – but two of them, stacked one under the other.

The immediate idea is to create a new component for that, or an extra modifier for our existing one. This all means more code. But maybe, just maybe, it might be possible with our little component – without adding any new classes? Let’s check that by adding some new requirements to our existing ones:

* If we have two `.child` elements, they should be stacked one over the other.
* Both `.child`ren should be centered horizontally.
* The distance above the first `.child` should equal the distance below the second one.

Here’s how it translates to new tests:

<iframe src="https://jsfiddle.net/cs65apup/1/embedded/js,result" style="border: none; width: 100%; height: 47em"></iframe>

Of course, our new tests will initially fail. But what if we take another approach:

<iframe src="https://jsfiddle.net/cs65apup/3/embedded/js,result" style="border: none; width: 100%; height: 13.5em"></iframe>

A look at the results… Victory!

<iframe src="https://jsfiddle.net/cs65apup/3/embedded/result,js" style="border: none; width: 100%; height: 31.5em"></iframe>

Hey, let’s have a look at what we’ve just done. We added another feature by actually reducing the amount of code! And we’re absolutely sure that our previous features work alright. Now that’s what you call responsible development! After all, we all know that…

{% blockquote Jeff Atwood, http://blog.codinghorror.com/the-best-code-is-no-code-at-all/ The Best Code is No Code At All %}
…the best code  
is no code at all
{% endblockquote %}

This wasn’t possible before with CSS. It’s an amazing thing, if you ask me!

<p class="text-center"><figure><img class="img-responsive"
  src="/post-images/yeeees.gif"
  alt="“Yeeees!” – says an excited girl wearing glasses"
  width="400"
  height="400"
/><figcaption>Source: giphy.com</figcaption></figure></p>

{% raw %}<a id="/slim-stylesheets/numbers"></a>{% endraw %}

Here’s some stunning numbers I promised you earlier. About 15 months of developing the project traditionally (the poking-around approach) in a team of 1 to 2 developers – and the built stylesheet weighed around 190 kB. 6 months of test-driven development onwards, with a team of 3–5, and we’ve **just grown the stylesheet by 40 kB**! Don’t get me wrong – **we’ve been shipping features way faster than ever**! It’s just that now we have a lot more opportunity to extend, reuse, remix and slim down what’s already there.

<p class="text-center"><img class="img-responsive img-responsive·seamless"
  src="/post-images/css-unit-tests-and-development-pace.svg"
  width="780"
  height="1200"
  alt="“CSS development: traditional vs test-driven” – graph"
/></p>



{% raw %}<a id="/in-a-nutshell"></a>{% endraw %}

## In a nutshell

Writing unit tests for the UI is a whole new quality of development in the world of CSS. The only other form of automated UI rendering tests I’m aware of is integration testing by [comparing screenshots][in-a-nutshell.A1]. In my opinion, though it does help spot regressions faster, it doesn’t really make you move faster. You can’t write your tests before implementing stuff. You can’t automate it fully. You can’t run the tests in different browsers without significant infrastructure overhead. Oh, and it’s way too slow for a live development workflow – whereas proper unit tests deliver you results within milliseconds of saving the stylesheet.

[in-a-nutshell.A1]: http://tldr.huddle.com/blog/css-testing/ "CSS regression testing"

We’ve always wanted to move fast with CSS. It looks like this dream is coming true right before our eyes. With CSS modules on their way – and a plethora of different ways to keep your styles modular and DRY – the only thing left until now was a way to develop with confidence. It’s now there!

{% pullquote %}
CSS is finally entering  
an era of sanity
{% endpullquote %}

Before you go, I’d like to share two small facts with you.

Firstly, the example you’ve seen in the tutorial isn’t a contrived case made up for the blog post. It’s the exact story of one of our production components. To make the story more interesting, the component `middle` which does that is a low-level component, which other components mix in as an internal dependency. After the fundamental change we explored in the [*No more fat stylesheets*](#/slim-stylesheets) section, all dependent components continued to work without a glitch.

Secondly, what we’ve just tested is positioning and dimensions – the hardest and most important things to get right with CSS. But with tools like [`getComputedStyle`][in-a-nutshell.B1] and [*sort-specificity*][in-a-nutshell.B2] you can actually test anything you want. We started out by testing dimensions, but experience taught us to test virtually everything. That’s right, 100% code coverage on CSS components! (We’re even toying with the idea of a CSS code coverage tool. More details soon, hopefully!)

[in-a-nutshell.B1]: http://devdocs.io/dom/window/getcomputedstyle "window.getComputedStyle – on DevDocs"
[in-a-nutshell.B2]: https://github.com/inuscript/sort-specificity "Sort css selector for specificity – inuscript/sort-specificity"

Warm thanks for Ossi Hanhinen, Barboros Can Konar and Scott Corgan for reading through previous versions of this article and suggesting improvements.

If you’ve got any comments, ideas you’d like to share or critical thoughts, don’t hesitate to leave a comment below or give me a shout at [@architectcodes](https://twitter.com/architectcodes).

If you liked this article, you can help me spread the word by [sharing it on Twitter](https://twitter.com/share?text=%E2%80%9CHow%20CSS%20unit%20tests%20helped%20us%20move%20fast%E2%80%9D%20%E2%80%94%20by%20%40architectcodes&url=http%3A%2F%2Ftomek.wiszniewski.cc%2Fhow-css-unit-tests-helped-us-move-fast%2F). Thanks a lot!
