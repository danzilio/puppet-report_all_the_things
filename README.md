[![Puppet Forge](http://img.shields.io/puppetforge/v/danzilio/report_all_the_things.svg?style=flat)](https://forge.puppetlabs.com/danzilio/report_all_the_things) [![Build Status](https://travis-ci.org/danzilio/puppet-report_all_the_things.svg)](https://travis-ci.org/danzilio/puppet-report_all_the_things) [![Documentation Status](http://img.shields.io/badge/docs-puppet--strings-ff69b4.svg?style=flat)](http://danzilio.github.io/puppet-report_all_the_things)

Are you a data nerd? Are you never able to get enough information out of your Puppet reports? Me too. There's a wealth of information in the Puppet reports. For large environments, this data is essential when trying to diagnose performance issues or detecting trends. Most report processors focus on small bits of information like the `metrics`, `logs`, or the `summary` sections. This is fine for some environments, but it's just not enough data for me! PuppetDB with dashboards like Puppetboard or Puppet Explorer are great for getting a quick glance at the status of your Puppet environment, but aren't powerful enough to get a good picture of the larger trends. I have big analytics platforms at my disposal and I want to use them. This is an attempt to solve this problem.

This module is really just a helper, not a report processor. This module provides some primitives for building report processors. The meat of this module is the `Puppet::ReportAllTheThings::Helper` module (ruby module, not Puppet module). This module contains a `report_all_the_things` method that takes a `Puppet::Transaction::Report` report object as an argument. This method calls the `to_data_hash` method on that report and iterates over the resulting data structure to ensure that all of the objects are serialized as regular hashes. The method will return a hash with all of the report data in it. You can then use this output to ship the data wherever you want.

I've written a report processor based on this module that ships reports to a Scribe log server (see: [scribe_reporter](https://github.com/danzilio/puppet-scribe_reporter)).

## Development

1. Fork it
2. Create a feature branch
3. Write a failing test
4. Write the code to make that test pass
5. Refactor the code
6. Submit a pull request

We politely request (demand) tests for all new features. Pull requests that contain new features without a test will not be considered. If you need help, just ask!
