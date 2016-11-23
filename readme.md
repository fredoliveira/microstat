<img src="http://helloform.com/images/microstat.png" width="250px">

[![Code Climate](https://codeclimate.com/github/fredoliveira/microstat/badges/gpa.svg)](https://codeclimate.com/github/fredoliveira/microstat) [![Issue Count](https://codeclimate.com/github/fredoliveira/microstat/badges/issue_count.svg)](https://codeclimate.com/github/fredoliveira/microstat) [![Test Coverage](https://codeclimate.com/github/fredoliveira/microstat/badges/coverage.svg)](https://codeclimate.com/github/fredoliveira/microstat/coverage)

Microstat is a utility class that provides a way to keep track of
arbitrary event runs. Send it data whenever something relevant happens
and it'll keep track of the number of times it happens per day, which
in turn lets you create histograms and charts. Easy.

### Using Microstat

Create a new Microstat object:

```
s = Microstat.new(namespace: 'myapp')
```

Track your first few events using the `track` method.

```
s.track 'sign-up' => 1
s.track 'sign-up' => 2
```

Get `total` and `history` for a given event:

```
s.total 'sign-up' => 2
s.history 'sign-up' => { "20161027"=>"4" }
```

### Internal storage format convention

Microstat uses a combination of Redis primitives to store data. The examples
below document how you could explore the available data manually by connecting
to your Redis server.

```
mstat:events - group of known event keys
mstat:events:event-name:total - total count of event calls
mstat:events:event-name:yyyymmdd - total count for a given timestamp
mstat:events:event-name:dates - known dates for a given event
```
