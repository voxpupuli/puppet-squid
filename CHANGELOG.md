## 2016-06-01 Release 0.2.2
* Correct documentation examples.

## 2016-06-01 Release 0.2.1

* All defined types can now be loaded as a hash to *init* and
  so can be loaded easily from hiera.
  e.g
```
class{'squid:
   http_ports => {'10000' =>  { options => 'accel vhost'},
                  '3000'  => {},
                 }
```

## 2016-04-18 Release 0.1.1

* Add tags to module metadata.

## 2016-04-13 Release 0.1.0
