# Microstat

Microstat is a utility class that provides a way to keep track of
arbitrary event runs. Send it data whenever something relevant happens
and it'll keep track of the number of times it happens per day, which
in turn lets you create histograms and charts. Easy.

### Using Microstat

```
s = Microstat.new(namespace: Rails.env)
s.track "sign-up" => 1
s.track "sign-up" => 2
s.total "sign-up" => 2
s.history "sign-up" => { "20161027"=>"4" }
```

### Internal storage format convention

```
mustat:events - group of known event keys
mustat:events:event-name:total - total count of event calls
mustat:events:event-name:yyyymmdd - total count for a given timestamp
mustat:events:event-name:dates - known dates for a given event
```
