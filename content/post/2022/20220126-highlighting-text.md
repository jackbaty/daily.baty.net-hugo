---
title: "Highlighting text in ox-hugo"
date: 2022-01-26T09:47:00-05:00
lastmod: 2022-01-26T10:02:14-05:00
tags: ["Orgmode"]
draft: false
weight: 0
---

I've been experimenting with adding highlights to text in my daily posts. The idea is that it makes scanning easier. I pick out the important parts of each entry and add a `<mark>` HTML tag. Then I style the region like so:

```css
mark {
  background: rgba(255, 255, 0, 0.3);
}
```

Recently, there's been a <mark>change in org that broke my markup</mark> when exporting from ox-hugo. Here's the comment by [kaushalmodi](https://github.com/kaushalmodi):

[Issue #540](https://github.com/kaushalmodi/ox-hugo/issues/540)

> This was a recent breaking change that fixed an inconsistency in ox-hugo (compared to ox-html). If we want to export verbatim HTML, it needs to be in .. or in an HTML export block

His suggestion to use a macro was excellent, so I did that. At the top of my posts.org file, is this:

`#+macro: mark @@html:<mark>$1</mark>@@`

When I want to `<mark>` some text, I add the macro inline, like so:

`I would like to {{{mark(mark this text)}}} so that it is highlighted`

But who has time to add all that markup by hand? To make it easier, I created the following function:

```lisp
(defun jab/markregion ()
  "Add a 'mark' macro to the current region (for Hugo)"
  (interactive)
  (if (region-active-p)
      (progn
        (goto-char (region-end))
        (insert ")}}}")
        (goto-char (region-beginning))
        (insert "{{{mark("))))
```

Now, I select a region and run `M-x jab/markregion`. I may create a keybinding for it, too, but for now this is fast and easy.

[//]: # "Exported with love from a post written in Org mode"
[//]: # "- https://github.com/kaushalmodi/ox-hugo"
