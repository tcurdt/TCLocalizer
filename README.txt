Localizing Cocoa projects usually means maintaining a NIB per language. This is a maintenance nightmare. There is tooling to help but this still adds complexity that most of time is not even really needed.

With TCLocalizer you use only have to maintain a single NIB and localize during runtime. It's fast, you can keep everything in localizable string files. All you have to call is:

  - (void) viewDidLoad
  {
      [[TCLocalizer localizer] localizeView:self.view];
  }

It can't get much easier than that.

Right now TCLocalizer supports

  - UIView
  - UIButton
  - UILabel
  - UITextView

The code is released under the Apache License 2.0.